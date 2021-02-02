import 'package:flutter/widgets.dart';
import 'package:gonna_client/services/auth/auth.dart';

class AppState extends ChangeNotifier {

  final AuthService _authService = AuthService.instance;

  AppState() {
    _authService.addListener(notifyListeners);
  }

  void dispose() {
    _authService.removeListener(notifyListeners);
  }

  bool isCodeSent() {
    return _authService.isCodeSent();
  }

  bool isUserLoggedIn() {
    return _authService.getCurrentUser() != null;
  }
}
