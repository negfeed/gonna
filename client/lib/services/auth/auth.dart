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
const forceResendingTokenPrefKey = "auth-forceResendingToken";
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

class AuthService extends ChangeNotifier {
  final firebase_auth.FirebaseAuth _auth = firebase_auth.FirebaseAuth.instance;
  final SharedPreferences _preferences = PreferenceUtil.instance;

  static AuthService _instance;

  static AuthService get instance {
    if (_instance == null) {
      _instance = AuthService();
    }
    return _instance;
  }

  User currentUser;

  AuthService() {
    _auth.authStateChanges().listen(_handleUserChange);
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
        codeSent: (String verificationId, int forceResendingToken) {
          print("Code sent: $verificationId, $forceResendingToken");
          _onCodeSent(verificationId, forceResendingToken, _completer);
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

  void _onCodeSent(String verificationId, int forceResendingToken,
      Completer completer) async {
    await _preferences.setString(verificationIdPrefKey, verificationId);
    await _preferences.setInt(forceResendingTokenPrefKey, forceResendingToken);
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
    if (_preferences.containsKey(forceResendingTokenPrefKey)) {
      await _preferences.remove(forceResendingTokenPrefKey);
    }
  }

  void undoCodeSent() {
    _undoCodeSent();
    notifyListeners();
  }

  Future submitSmsCode(String smsCode) async {
    var verificationId = _preferences.getString(verificationIdPrefKey);
    var credential = PhoneAuthProvider.credential(
        verificationId: verificationId, smsCode: smsCode);
    try {
      await _auth.signInWithCredential(credential);
    } on firebase_auth.FirebaseAuthException catch (e) {
      throw SubmitSmsCodeGenericError(e);
    }
    notifyListeners();
  }

  void _handleUserChange(User user) {
    print('User change');
    print('New user: $user\n');
    print('Old user: $currentUser\n');
    if (user != currentUser ||
        user != null &&
            currentUser != null &&
            user.phoneNumber != currentUser.phoneNumber) {
      notifyListeners();
    }
    currentUser = user;
  }

  bool currentUserHasPhoneNumber() {
    return (currentUser != null) && ((currentUser?.phoneNumber ?? '') != '');
  }

  void signOut() async {
    _undoCodeSent();
    await _auth.signOut();
  }

  void deleteAccount() async {
    _undoCodeSent();
    await _auth.currentUser.delete();
  }

  void createAndSignInUsingDeviceAccount() async {
    print("Create device account.");
    var customToken = await _auth.currentUser.getIdToken().then((token) async {
      var response = await http.post(getFunctionUrl(createDeviceAccountPath),
          headers: {'Authorization': 'Bearer ' + token});
      print("Response status code: ${response.statusCode}");
      print("Response body: ${response.body}");
      return response.body;
    });
    await _auth.signInWithCustomToken(customToken);
  }

  String getFunctionUrl(String path) {
    return FlavorConfig.instance.functionsUrlBase + path;
  }
}
