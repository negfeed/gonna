import 'package:flutter/material.dart';
import 'package:gonna_client/pages/auth/AuthPage.dart';
import 'package:gonna_client/pages/home/home.dart';
import 'package:gonna_client/services/auth/auth.dart';
import 'package:provider/provider.dart';

import 'models/user/user.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService().user,
      child: MaterialApp(
        title: 'Gonna',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: AuthWrapper(),
      )
    );
  }
}

class AuthWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);

    // return either the Home or Authenticate widget
    if (user == null){
      return AuthPage();
    } else {
      return HomePage();
    }
  }
}
