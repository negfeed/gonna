import 'package:flutter/widgets.dart';

class AppState extends ChangeNotifier {
  bool _phoneNumberSubmitted = false;
  bool _phoneNumberVerified = false;
  bool _profileInitialized = false;

  bool get phoneNumberSubmitted {
    return _phoneNumberSubmitted;
  }

  bool get phoneNumberVerified {
    return _phoneNumberVerified;
  }

  bool get profileInitialized {
    return _profileInitialized;
  }

  void submitPhoneNumber() {
    _phoneNumberSubmitted = true;
    notifyListeners();
  }

  void setVerifiedPhoneNumber() {
    _phoneNumberVerified = true;
    notifyListeners();
  }

  void submitProfile() {
    _profileInitialized = true;
    notifyListeners();
  }
}
