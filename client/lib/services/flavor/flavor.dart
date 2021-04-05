import 'package:flutter/services.dart';

enum Flavor {
  SANDBOX,
  PROD
}

class FlavorConfig {
  static FlavorConfig instance;

  // call this method from iniState() function of mainApp().
  static Future<FlavorConfig> init() async {
    String flavorString = await const MethodChannel('flavor')
        .invokeMethod<String>('getFlavor');
    Flavor flavor;
    if (flavorString == 'prod') {
      flavor = Flavor.PROD;
    } else if (flavorString == 'sandbox') {
      flavor = Flavor.SANDBOX;
    } 
    
    if (flavor == null) {
      throw Exception('Undefined flavor $flavorString');
    }

    instance = FlavorConfig(flavor, flavorString); 
    return instance;
  }

  Flavor flavor;
  String flavorString;

  FlavorConfig(Flavor flavor, String flavorString) {
    this.flavor = flavor;
    this.flavorString = flavorString;
  }
}