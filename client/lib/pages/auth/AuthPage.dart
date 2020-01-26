import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gonna_client/services/auth/auth.dart';

class AuthPage extends StatelessWidget {

  final AuthService _auth = AuthService();

  _signInAnon() {
    dynamic result = _auth.signInAnon();
    print(result);
  }

  _signInFacebook() {
    dynamic result = _auth.signInFacebook();
    print(result);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Authenticate"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
                onPressed: _signInAnon,
                child: const Text('Sign in Anonymously', style: TextStyle(fontSize: 20))),
            RaisedButton(
                onPressed: _signInFacebook,
                child: const Text('Sign in with Facebook', style: TextStyle(fontSize: 20))),
          ],
        ),
      ),
    );
  }
}
