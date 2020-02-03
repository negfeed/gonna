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

  bool _signInInProgress = false;

  _signInFacebook(BuildContext context) async {
    setState(() {
      _signInInProgress = true;
    });
    try {
      await _auth.signInFacebook();
    } catch (err) {
      final snackBar = SnackBar(content: Text(err.cause));
      Scaffold.of(context).showSnackBar(snackBar);
    }
    setState(() {
      _signInInProgress = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    var stackLayers = new List<Widget>();
    stackLayers.add(_contentLayer());
    if (_signInInProgress) {
      stackLayers.add(_progressIndicatorLayer());
    }
    return Scaffold(
      body: Stack(
        children: stackLayers,
      ),
    );
  }

  Widget _progressIndicatorLayer() {
    return Stack(
      children: [
        new Opacity(
          opacity: 0.3,
          child: const ModalBarrier(dismissible: false, color: Colors.grey),
        ),
        new Center(
          child: new CircularProgressIndicator(),
        ),
      ],
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
