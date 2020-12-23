import 'package:flutter/material.dart';

class GonnaErrorPage extends StatelessWidget {
  FlutterError error;

  GonnaErrorPage(this.error);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      appBar: AppBar(
        title: Text("Gonna"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Something went wrong',
            ),
            Text(error.toString())
          ],
        ),
      ),
    );
  }
}
