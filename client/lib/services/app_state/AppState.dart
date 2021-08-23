import 'package:flutter/widgets.dart';
import 'package:gonna_client/services/auth/auth.dart' as auth;
import 'package:gonna_client/services/firestore/profile_firestore.dart'
    as profile_firestore;
import 'package:gonna_client/services/firestore/phone_firestore.dart'
    as phone_firestore;

class AppState extends ChangeNotifier {
  final auth.AuthService _authService = auth.AuthService.instance;
  final profile_firestore.ProfileFirestoreService _profileFirestoreService =
      profile_firestore.ProfileFirestoreService.instance;
  final phone_firestore.PhoneFirestoreService _phoneFirestoreService =
      phone_firestore.PhoneFirestoreService.instance;

  AppState() {
    _authService.addListener(notifyListeners);
    _profileFirestoreService.addListener(notifyListeners);
    _phoneFirestoreService.addListener(notifyListeners);
  }

  @override
  void dispose() {
    _authService.removeListener(notifyListeners);
    _profileFirestoreService.removeListener(notifyListeners);
    _phoneFirestoreService.removeListener(notifyListeners);
    super.dispose();
  }

  bool isCodeSent() {
    return _authService.isCodeSent();
  }

  bool isUserLoggedInWithPhoneNumber() {
    return _authService.currentUser?.getSignInProvider() ==
        auth.SignInProvider.phone;
  }

  bool isUserLoggedInWithDeviceToken() {
    return _authService.currentUser?.getSignInProvider() ==
        auth.SignInProvider.device;
  }

  bool isProfileInitialized() {
    return _profileFirestoreService.isProfileInitialized();
  }

  bool isPhoneDirectoryUpdated() {
    return _phoneFirestoreService.isPhoneDirectoryUpdated();
  }
}
