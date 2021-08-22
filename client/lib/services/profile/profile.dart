import 'package:flutter/widgets.dart';

class ProfileService extends ChangeNotifier {

  static ProfileService? _instance;

  static ProfileService get instance {
    if (_instance == null) {
      _instance = ProfileService();
    }
    return _instance!;
  }
}
