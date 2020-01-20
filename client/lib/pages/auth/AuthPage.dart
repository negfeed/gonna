import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gonna_client/services/auth/auth.dart';

class AuthPage extends StatelessWidget {

  final AuthService _auth = AuthService();

  _signIn() {
    dynamic result = _auth.signInAnon();
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
                onPressed: _signIn,
                child: const Text('Sign in', style: TextStyle(fontSize: 20))),
          ],
        ),
      ),
    );
  }
}
