import 'package:flutter/widgets.dart';
import 'package:gonna_client/services/auth/auth.dart' as auth;
import 'package:gonna_client/services/database/app_state_dao.dart'
    as app_state_dao;
import 'package:gonna_client/services/database/database.dart' as database;

class AppState extends ChangeNotifier {
  final auth.AuthService _authService = auth.AuthService.instance;
  final app_state_dao.AppStateDao _appStateDao =
      app_state_dao.AppStateDao.instance;

  auth.User? user = null;
  database.AppStateData? appStateData = null;

  AppState() {
    _authService.currentUserChanges().listen(_userChangeHandler);
    _appStateDao.watchAppState().listen(_persistedAppStateChangeHandler);
  }

  _userChangeHandler(auth.User? newUser) {
    bool userSignedIn = user == null && newUser != null;
    bool userSignedOut = user != null && newUser == null;
    user = newUser;
    if (userSignedIn || userSignedOut) {
      notifyListeners();
    }
  }

  _persistedAppStateChangeHandler(
      database.AppStateData? newAppStateData) async {
    appStateData = newAppStateData;

    // If the user hit the profile creation editor, exchanged their phone sign in
    // token for a device sign in token and the device token went stale (can't be
    // used to update phone directory). The user should be signed out to throw
    // them back to the initial phone verification page. Also suppress notifying
    // the router as a subsequent notification is imminent due to the impending 
    // sign out.
    if (!isProfileInitialized() && _isUserLoggedInWithStaleDeviceToken()) {
      await _authService.signOut();
      return;
    }
    notifyListeners();
  }

  bool _isUserLoggedInWithStaleDeviceToken() {
    return user?.getSignInProvider() == auth.SignInProvider.device &&
        !(user!.isDeviceSignInTokenFresh());
  }

  bool isCodeSent() {
    return appStateData?.verificationId != null;
  }

  bool isUserLoggedInWithPhoneNumber() {
    return user?.getSignInProvider() == auth.SignInProvider.phone;
  }

  bool isUserLoggedInWithFreshDeviceToken() {
    return user?.getSignInProvider() == auth.SignInProvider.device &&
        (user?.isDeviceSignInTokenFresh() ?? false);
  }

  bool isProfileInitialized() {
    return appStateData?.phoneNumberMappedToProfile ?? false;
  }
}
