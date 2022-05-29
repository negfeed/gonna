import 'package:gonna_client/services/auth/auth.dart' as auth;
import 'package:gonna_client/services/database/database.dart';

class WipeoutService {
  static signoutAndWipeoutDatabase() {
    auth.AuthService.instance.signOut();
    GonnaDatabase.instance.closeAndDelete();
  }
}
