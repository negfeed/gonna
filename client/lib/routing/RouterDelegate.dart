import 'package:flutter/material.dart';
import 'package:gonna_client/pages/auth/PhoneEntryPage.dart';
import 'package:gonna_client/pages/auth/PhoneVerificationPage.dart';
import 'package:gonna_client/pages/home/home.dart';
import 'package:gonna_client/pages/profile/profile_editor.dart';
import 'package:gonna_client/routing/RoutePath.dart';
import 'package:gonna_client/services/app_state/AppState.dart';
import 'package:gonna_client/services/app_state/InheritedAppState.dart';

class GonnaRouterDelegate extends RouterDelegate<GonnaRoutePath>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<GonnaRoutePath> {
  final AppState _appState = AppState();

  GonnaRouterDelegate() {
    _appState.addListener(notifyListeners);
  }

  void dispose() {
    _appState.removeListener(notifyListeners);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InheritedAppState(
      appState: _appState,
      child: Navigator(
        key: navigatorKey,
        pages: _getPages(),
        onPopPage: (route, result) {
          if (!route.didPop(result)) {
            return false;
          }
          return true;
        },
      ),
    );
  }

  @override
  GlobalKey<NavigatorState> get navigatorKey => GlobalKey<NavigatorState>();

  @override
  Future<void> setNewRoutePath(GonnaRoutePath configuration) {
    return Future.value();
  }

  GonnaRoutePath get currentConfiguration {
    return GonnaRoutePath.home();
  }

  List<Page> _getPages() {
    List<Page> pages = [];
    if (_appState.isProfileInitialized()) {
      pages = [MaterialPage(child: HomePage())];
    } else if (_appState.isUserLoggedInWithPhoneNumber() ||
        _appState.isUserLoggedInWithFreshDeviceToken()) {
      pages = [MaterialPage(child: ProfileEditorPage())];
    } else {
      pages = [MaterialPage(child: PhoneEntryPage())];
      if (_appState.isCodeSent()) {
        pages.add(MaterialPage(child: PhoneVerificationPage()));
      }
    }
    return pages;
  }
}
