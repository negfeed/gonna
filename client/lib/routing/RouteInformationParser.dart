import 'package:flutter/widgets.dart';
import 'package:gonna_client/routing/RoutePath.dart';

class GonnaRouteInformationParser
    extends RouteInformationParser<GonnaRoutePath> {
  @override
  Future<GonnaRoutePath> parseRouteInformation(
      RouteInformation routeInformation) {
    if (routeInformation.location == null) {
      return Future.value(GonnaRoutePath.unknown());
    }
    final uri = Uri.parse(routeInformation.location!);
    // Handle '/'
    if (uri.pathSegments.length == 0) {
      return Future.value(GonnaRoutePath.home());
    }

    // Handle unknown routes
    return Future.value(GonnaRoutePath.unknown());
  }

  @override
  RouteInformation restoreRouteInformation(GonnaRoutePath path) {
    return RouteInformation(location: '/');
  }
}
