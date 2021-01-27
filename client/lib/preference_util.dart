import 'dart:async' show Future;
import 'package:shared_preferences/shared_preferences.dart';

class PreferenceUtil {
  static SharedPreferences instance;

  // call this method from iniState() function of mainApp().
  static Future<SharedPreferences> init() async {
    instance = await SharedPreferences.getInstance();
    return instance;
  }
}
