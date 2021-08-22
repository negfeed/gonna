import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:gonna_client/preference_util.dart';
import 'package:gonna_client/services/error.dart';
import 'package:gonna_client/services/flavor/flavor.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

const verificationIdPrefKey = "auth-verificationId";
const resendTokenPrefKey = "auth-resendToken";
const phoneNumberPrefKey = "auth-phoneNumber";

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

  String get phoneNumber {
    if (getSignInProvider() != SignInProvider.device) {
      throw new Exception('This getter should only be used with device users.');
    }
    return _idTokenResult.claims!['phoneNumber'];
  }

  Future<String> getIdToken() async {
    return _firebaseUser.getIdToken();
  }

  SignInProvider getSignInProvider() {
    if (_idTokenResult!.signInProvider == 'phone') {
      return SignInProvider.phone;
    } else if (_idTokenResult!.signInProvider == 'custom' &&
        _idTokenResult!.claims != null &&
        _idTokenResult!.claims!.containsKey('gat') &&
        _idTokenResult!.claims!['gat'] == 'device') {
      return SignInProvider.device;
    }
    return SignInProvider.none;
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
    await _preferences.setString(phoneNumberPrefKey, phoneNumber);

    Completer<VerificationResult> _completer = new Completer();

    firebase_auth.FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phoneNumber,
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
    await _preferences.setString(verificationIdPrefKey, verificationId);
    if (resendToken != null) {
      await _preferences.setInt(resendTokenPrefKey, resendToken);
    }
    completer.complete(VerificationResult.verificationCompleted);
    notifyListeners();
  }

  bool isCodeSent() {
    if (_preferences.containsKey(verificationIdPrefKey)) {
      return true;
    }
    return false;
  }

  void _undoCodeSent() async {
    if (_preferences.containsKey(verificationIdPrefKey)) {
      await _preferences.remove(verificationIdPrefKey);
    }
    if (_preferences.containsKey(resendTokenPrefKey)) {
      await _preferences.remove(resendTokenPrefKey);
    }
  }

  void undoCodeSent() {
    _undoCodeSent();
    notifyListeners();
  }

  Future submitSmsCode(String smsCode) async {
    var verificationId = _preferences.getString(verificationIdPrefKey);
    var credential = PhoneAuthProvider.credential(
        verificationId: verificationId!, smsCode: smsCode);
    try {
      await _auth.signInWithCredential(credential);
    } on firebase_auth.FirebaseAuthException catch (e) {
      throw SubmitSmsCodeGenericError(e);
    }
    notifyListeners();
  }

  void _registerCurrentUserChanges() {
    _currentUserChanges().listen(_handleCurrentUserChanges);
  }

  void _handleCurrentUserChanges(User? user) {
    print('User change');
    print('New user: $user\n');
    print('Old user: $currentUser\n');
    // Notify the app state of change if the user switched from a logged in state to a logged out state or
    // the other way around. We don't need to notify the app state of any change when the logged in user
    // switches from the phone login provider to the device custom login provider.
    if (user == null && currentUser != null ||
        user != null && currentUser == null) {
      notifyListeners();
    }
    currentUser = user;
  }

  Stream<User?> _currentUserChanges() {
    return _auth.authStateChanges().asyncMap((firebaseUser) {
      return firebaseUser
          ?.getIdTokenResult()
          .then((idTokenResult) => User(firebaseUser, idTokenResult));
    });
  }

  void signOut() async {
    _undoCodeSent();
    await _auth.signOut();
  }

  void deleteAccount() async {
    _undoCodeSent();
    await _auth.currentUser?.delete();
  }

  // Creates a device account if it has not been created yet, and signs into that device account.
  Future<void> maybeCreateAndSignInUsingDeviceAccount() async {

    if (currentUser == null) {
      throw new Exception("User is not signed in.");
    }

    if (currentUser!.getSignInProvider() == SignInProvider.phone) {
      throw new Exception("User must be signed in using a phone number to mint a device token.");
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
    await for (User? user in _currentUserChanges()) {
      if (user != null && user.getSignInProvider() == SignInProvider.device) {
        return;
      }
    }
  }

  Uri _getFunctionUrl(String path) {
    return Uri.parse(FlavorConfig.instance.functionsUrlBase + path);
  }
}
