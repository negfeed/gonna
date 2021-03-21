import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:gonna_client/pages/error/GonnaErrorPage.dart';
import 'package:gonna_client/pages/loading/GonnaLoadingPage.dart';
import 'package:gonna_client/preference_util.dart';
import 'package:gonna_client/routing/RouteInformationParser.dart';
import 'package:gonna_client/routing/RouterDelegate.dart';
import 'package:gonna_client/services/flavor/flavor.dart';
import 'package:gonna_client/theme_data.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PreferenceUtil.init();
  await FlavorConfig.init();
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
          return MyApp._maybeWrapWithBanner(
              buildMaterialApp(context, snapshot));
        });
  }

  Widget buildMaterialApp(context, snapshot) {
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
        theme: themeData,
        routeInformationParser: GonnaRouteInformationParser(),
        routerDelegate: GonnaRouterDelegate(),
      );
    }
    return MaterialApp(
        key: Key('Gonna loading'),
        title: 'Gonna Loading ...',
        home: GonnaLoadingPage());
  }

  static Widget _maybeWrapWithBanner(Widget widget) {
    if (FlavorConfig.instance.flavor == Flavor.PROD) {
      return widget;
    }
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Banner(
        child: widget,
        location: BannerLocation.topStart,
        message: FlavorConfig.instance.flavorString,
        color: Colors.green.withOpacity(0.6),
        textStyle: TextStyle(
            fontWeight: FontWeight.w700, fontSize: 12.0, letterSpacing: 1.0),
        textDirection: TextDirection.ltr,
      ),
    );
  }
}
