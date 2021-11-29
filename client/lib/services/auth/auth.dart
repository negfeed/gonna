import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:gonna_client/preference_util.dart';
import 'package:gonna_client/services/database/app_state_dao.dart'
    as app_state_dao;
import 'package:gonna_client/services/error.dart';
import 'package:gonna_client/services/flavor/flavor.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

const verificationTimeoutInSeconds = 60;
const createDeviceAccountPath = 'createDeviceAccount';

enum VerificationResult { codeSent, verificationCompleted }

class VerifyPhoneGenericError extends UserVisibleError {
  VerifyPhoneGenericError(Exception cause) : super(cause);

  @override
  String get longMessage =>
      "Failed to verify phone number. Please try again later.";

  @override
  String get shortMessage => "Failed to verify phone number.";
}

class SubmitSmsCodeGenericError extends UserVisibleError {
  SubmitSmsCodeGenericError(Exception cause) : super(cause);

  @override
  String get longMessage =>
      "SMS code submission error. Please try again later.";

  @override
  String get shortMessage => "SMS code submission error.";
}

enum SignInProvider { none, phone, device }

class User {
  firebase_auth.User _firebaseUser;
  firebase_auth.IdTokenResult _idTokenResult;

  User(this._firebaseUser, this._idTokenResult);

  String get uid {
    return _firebaseUser.uid;
  }

  String? get phoneNumber {
    if (getSignInProvider() == SignInProvider.device) {
      return _idTokenResult.claims!['phoneNumber'];
    }
  }

  Future<String> getIdToken() async {
    return _firebaseUser.getIdToken();
  }

  SignInProvider getSignInProvider() {
    if (_idTokenResult.signInProvider == 'phone') {
      return SignInProvider.phone;
    } else if (_idTokenResult.signInProvider == 'custom' &&
        _idTokenResult.claims != null &&
        _idTokenResult.claims!.containsKey('gat') &&
        _idTokenResult.claims!['gat'] == 'device') {
      return SignInProvider.device;
    }
    return SignInProvider.none;
  }

  bool isDeviceSignInTokenFresh() {
    return getSignInProvider() == SignInProvider.device &&
        _firebaseUser.metadata.creationTime!
            .add(Duration(minutes: 8))
            .isAfter(DateTime.now());
  }
}

class AuthService extends ChangeNotifier {
  final firebase_auth.FirebaseAuth _auth = firebase_auth.FirebaseAuth.instance;
  final SharedPreferences _preferences = PreferenceUtil.instance;

  static AuthService? _instance;

  static AuthService get instance {
    if (_instance == null) {
      _instance = AuthService();
    }
    return _instance!;
  }

  User? currentUser;

  AuthService() {
    _registerCurrentUserChanges();
  }

  Future<VerificationResult> verifyPhoneNumber(String phoneNumber) async {
    Completer<VerificationResult> _completer = new Completer();

    firebase_auth.FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        timeout: Duration(seconds: verificationTimeoutInSeconds),
        verificationCompleted: (firebase_auth.PhoneAuthCredential credentials) {
          print("Verification completed.");
          _onVerificationCompleted(credentials, _completer);
        },
        verificationFailed: (firebase_auth.FirebaseAuthException exception) {
          print("Verification failed: $exception");
          _completer.completeError(VerifyPhoneGenericError(exception));
        },
        codeSent: (String verificationId, int? resendToken) {
          print("Code sent: $verificationId, $resendToken");
          _onCodeSent(verificationId, resendToken, _completer);
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          print("Code auto retrieval timeout: $verificationId");
        });

    await app_state_dao.AppStateDao.instance.markPhoneVerificationStarted(
        phoneNumber, verificationTimeoutInSeconds);

    return _completer.future;
  }

  void _onVerificationCompleted(firebase_auth.PhoneAuthCredential credentials,
      Completer completer) async {
    await _auth.signInWithCredential(credentials);
    completer.complete(VerificationResult.verificationCompleted);
    notifyListeners();
  }

  void _onCodeSent(
      String verificationId, int? resendToken, Completer completer) async {
    await app_state_dao.AppStateDao.instance
        .setVerificationId(verificationId, resendToken);

    completer.complete(VerificationResult.verificationCompleted);
    notifyListeners();
  }

  Future submitSmsCode(String smsCode) async {
    var verificationId = await app_state_dao.AppStateDao.instance.getVerificationId();
    var credential = PhoneAuthProvider.credential(
        verificationId: verificationId, smsCode: smsCode);
    try {
      await _auth.signInWithCredential(credential);
    } on firebase_auth.FirebaseAuthException catch (e) {
      throw SubmitSmsCodeGenericError(e);
    }
    notifyListeners();
  }

  void _registerCurrentUserChanges() {
    currentUserChanges().listen(_handleCurrentUserChanges);
  }

  void _handleCurrentUserChanges(User? user) {
    print('User change');
    print('New user: $user, phoneNumber: ${user?.phoneNumber}, '
        'uid: ${user?.uid}, signInProvider: ${user?.getSignInProvider()}');
    print('Old user: $currentUser, phoneNumber: ${currentUser?.phoneNumber}, '
        'uid: ${currentUser?.uid}, signInProvider: ${currentUser?.getSignInProvider()}');
    currentUser = user;
  }

  Stream<User?> currentUserChanges() {
    return _auth.authStateChanges().asyncMap((firebaseUser) {
      return firebaseUser
          ?.getIdTokenResult()
          .then((idTokenResult) => User(firebaseUser, idTokenResult));
    });
  }

  void signOut() async {
    await _auth.signOut();
    await app_state_dao.AppStateDao.instance.reset();
  }

  void deleteAccount() async {
    await _auth.currentUser?.delete();
    await app_state_dao.AppStateDao.instance.reset();
  }

  // Creates a device account if it has not been created yet, and signs into that device account.
  Future<void> maybeCreateAndSignInUsingDeviceAccount() async {
    if (currentUser == null) {
      throw new Exception("User is not signed in.");
    } else if (currentUser!.getSignInProvider() == SignInProvider.device) {
      return;
    } else if (currentUser!.getSignInProvider() != SignInProvider.phone) {
      throw new Exception(
          "User must be signed in using a phone number to mint a device token.");
    }

    print("Create device account.");
    var customToken = await currentUser!.getIdToken().then((token) async {
      var response = await http.post(_getFunctionUrl(createDeviceAccountPath),
          headers: {'Authorization': 'Bearer ' + token});
      print("Response status code: ${response.statusCode}");
      print("Response body: ${response.body}");
      return response.body;
    });
    await _auth.signInWithCustomToken(customToken);

    // There seems to be a race condition where the next firebase operation will
    // be associated with the phone account rather than the device account. This
    // block will prevent returning from this method until the authenticated user
    // has switched from phone account to device account.
    await for (User? user in currentUserChanges()) {
      if (user != null && user.getSignInProvider() == SignInProvider.device) {
        return;
      }
    }
  }

  Uri _getFunctionUrl(String path) {
    return Uri.parse(FlavorConfig.instance.functionsUrlBase + path);
  }
}
