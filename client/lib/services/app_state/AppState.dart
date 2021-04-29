import 'package:flutter/widgets.dart';
import 'package:gonna_client/services/auth/auth.dart' as auth;

class AppState extends ChangeNotifier {

  final auth.AuthService _authService = auth.AuthService.instance;

  AppState() {
    _authService.addListener(notifyListeners);
  }

  @override
  void dispose() {
    _authService.removeListener(notifyListeners);
    super.dispose();
  }

  bool isCodeSent() {
    return _authService.isCodeSent();
  }

  bool isUserLoggedInWithPhoneNumber() {
    return _authService.currentUser.getSignInProvider() == auth.SignInProvider.phone;
  }

  bool isUserLoggedInWithDeviceToken() {
    return _authService.currentUser.getSignInProvider() == auth.SignInProvider.device;
  }
}
