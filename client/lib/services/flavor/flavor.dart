import 'package:flutter/services.dart';

enum Flavor {
  SANDBOX,
  PROD
}

class FlavorConfig {
  static late FlavorConfig instance;

  // call this method from iniState() function of mainApp().
  static Future<FlavorConfig> init() async {
    String? flavorString = await const MethodChannel('flavor')
        .invokeMethod<String>('getFlavor');
    late Flavor flavor;
    if (flavorString == null) {
      throw Exception('Could not fetch build flavor');
    } else if (flavorString == 'prod') {
      flavor = Flavor.PROD;
    } else if (flavorString == 'sandbox') {
      flavor = Flavor.SANDBOX;
    }

    instance = FlavorConfig(flavor, flavorString);
    return instance;
  }

  Flavor flavor;
  String flavorString;
  late String functionsUrlBase;
  late String storageUrlBase;

  FlavorConfig(this.flavor, this.flavorString) {

    switch (flavor) {
      case Flavor.PROD:
        functionsUrlBase = 'https://us-central1-gonna-prod.cloudfunctions.net/';
        storageUrlBase = 'https://firebasestorage.googleapis.com/v0/b/gonna-prod.appspot.com/o/';
        break;
      case Flavor.SANDBOX:
        functionsUrlBase = 'https://us-central1-gonna-sandbox.cloudfunctions.net/';
        storageUrlBase = 'https://firebasestorage.googleapis.com/v0/b/gonna-sandbox.appspot.com/o/';
        break;
      default:
        throw Exception('Unrecognized flavor!!');
    }
  }
}
