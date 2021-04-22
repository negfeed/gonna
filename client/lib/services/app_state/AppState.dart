import 'package:flutter/widgets.dart';
import 'package:gonna_client/services/auth/auth.dart';

class AppState extends ChangeNotifier {

  final AuthService _authService = AuthService.instance;

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
    return _authService.currentUserHasPhoneNumber();
  }
}
