import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:gonna_client/pages/error/GonnaErrorPage.dart';
import 'package:gonna_client/pages/loading/GonnaLoadingPage.dart';
import 'package:gonna_client/preference_util.dart';
import 'package:gonna_client/routing/RouteInformationParser.dart';
import 'package:gonna_client/routing/RouterDelegate.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  PreferenceUtil.init();
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
                key: Key('Gonna ERROR'),
                title: 'Gonna ERROR',
                home: GonnaErrorPage(snapshot.error));
          }
          // Once complete, show your application
          if (snapshot.connectionState == ConnectionState.done) {
            return MaterialApp.router(
              key: Key('Gonna App'),
              title: 'Gonna',
              theme: ThemeData(primarySwatch: Colors.blue),
              routeInformationParser: GonnaRouteInformationParser(),
              routerDelegate: GonnaRouterDelegate(),
            );
          }
          return MaterialApp(
              key: Key('Gonna loading'),
              title: 'Gonna Loading ...',
              home: GonnaLoadingPage());
        });
  }
}
