import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:gonna_client/pages/auth/PhoneEntryPage.dart';
import 'package:gonna_client/pages/error/GonnaErrorPage.dart';
import 'package:gonna_client/pages/home/home.dart';
import 'package:gonna_client/pages/loading/GonnaLoadingPage.dart';
import 'package:gonna_client/services/auth/auth.dart';
import 'package:provider/provider.dart';

import 'models/user/user.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // Create the initialization Future outside of `build`:
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _initialization,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return MaterialApp(
                title: 'Gonna ERROR', home: GonnaErrorPage(snapshot.error));
          }
          // Once complete, show your application
          if (snapshot.connectionState == ConnectionState.done) {
            return StreamProvider<User>.value(
                value: AuthService().user,
                child: MaterialApp(
                  title: 'Gonna',
                  theme: ThemeData(primarySwatch: Colors.blue),
                  home: AuthWrapper(),
                ));
          }
          return MaterialApp(title: 'Gonna ERROR', home: GonnaLoadingPage());
        });
  }
}

class AuthWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    // return either the Home or Authenticate widget
    if (user == null){
      return PhoneEntryPage();
    } else {
      return HomePage();
    }
  }
}
