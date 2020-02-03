import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:gonna_client/services/auth/auth.dart';

class AuthPage extends StatefulWidget {
  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final AuthService _auth = AuthService();

  _signInFacebook(BuildContext context) async {
    try {
      await _auth.signInFacebook();
    } catch (err) {
      final snackBar = SnackBar(content: Text('Error: ' + err.cause));
      Scaffold.of(context).showSnackBar(snackBar);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _contentLayer(),
    );
  }

  Builder _contentLayer() {
    return Builder(
      builder: (BuildContext context) {
        return Center(
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
                  onPressed: () => _signInFacebook(context),
                  padding: EdgeInsets.symmetric(horizontal: 40),
                  child: const Text(
                    'LOG IN WITH FACEBOOK',
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  )),
            ],
          ),
        );
      }
    );
  }
}
