import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:gonna_client/services/auth/auth.dart';

class AuthPage extends StatelessWidget {
  final AuthService _auth = AuthService();

  _signInFacebook() {
    dynamic result = _auth.signInFacebook();
    print(result);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(40),
              child: Image(
                  image:
                      AssetImage('assets/memes/wait-a-minute-who-are-you.jpg')),
            ),
            RaisedButton(
                color: Color.fromRGBO(66, 103, 178, 1),
                onPressed: _signInFacebook,
                padding: EdgeInsets.symmetric(horizontal: 40),
                child: const Text(
                  'LOG IN WITH FACEBOOK',
                  style: TextStyle(fontSize: 20, color: Colors.white),
                )),
          ],
        ),
      ),
    );
  }
}
