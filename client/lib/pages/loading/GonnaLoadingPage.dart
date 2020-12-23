import 'package:flutter/material.dart';

class GonnaLoadingPage extends StatelessWidget {
  GonnaLoadingPage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Gonna"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Loading ...',
            ),
          ],
        ),
      ),
    );
  }
}
