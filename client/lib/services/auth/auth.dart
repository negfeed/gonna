import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:gonna_client/models/user/user.dart';

class GonnaAuthException implements Exception {
  String cause;
  GonnaAuthException(this.cause);
}

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  User _userFromFirebaseUser(FirebaseUser user) {
    return user != null
        ? User(
            uid: user.uid,
            displayName: user.displayName,
            photoUrl: user.photoUrl,
            email: user.email)
        : null;
  }

  Stream<User> get user {
    return _auth.onAuthStateChanged.map(_userFromFirebaseUser);
  }

  Future _sendFacebookTokenToFirebaseServer(String token) async {
    try {
      AuthCredential credential =
          FacebookAuthProvider.getCredential(accessToken: token);
      AuthResult result = await _auth.signInWithCredential(credential);
      FirebaseUser user = result.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future signInFacebook() async {
    final facebookLogin = FacebookLogin();
    final result = await facebookLogin.logIn(['email']);

    User user;
    switch (result.status) {
      case FacebookLoginStatus.loggedIn:
        user =
            await _sendFacebookTokenToFirebaseServer(result.accessToken.token);
        break;
      case FacebookLoginStatus.cancelledByUser:
        throw GonnaAuthException("User canceled login.");
        break;
      case FacebookLoginStatus.error:
        throw GonnaAuthException(result.errorMessage);
        break;
    }
    return user;
  }

  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (error) {
      print(error);
    }
    final facebookLogin = FacebookLogin();
    try {
      facebookLogin.logOut();
    } catch (error) {
      print(error);
    }
    return null;
  }
}
