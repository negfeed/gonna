import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:gonna_client/preference_util.dart';
import 'package:gonna_client/routing/RouteInformationParser.dart';
import 'package:gonna_client/routing/RouterDelegate.dart';
import 'package:gonna_client/services/contact_sync/contact_sync.dart' as contact_sync;
import 'package:gonna_client/services/flavor/flavor.dart';
import 'package:gonna_client/theme_data.dart';
import 'package:gonna_client/services/background/background.dart' as background;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PreferenceUtil.init();
  await FlavorConfig.init();
  await Firebase.initializeApp();
  await background.BackgroundService.init();
  contact_sync.ContactSyncService.scheduleSyncAllContacts();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return _maybeWrapWithBanner(MaterialApp.router(
      key: Key('Gonna App'),
      title: 'Gonna',
      theme: themeData,
      routeInformationParser: GonnaRouteInformationParser(),
      routerDelegate: GonnaRouterDelegate(),
    ));
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
