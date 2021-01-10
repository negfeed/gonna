enum BasicRoutes {
  phoneEntry,
  phoneVerification,
  profileInitialization,
  home,
  unknown,
}

class GonnaRoutePath {
  final BasicRoutes route;

  GonnaRoutePath.phoneEntry() : route = BasicRoutes.phoneEntry;

  GonnaRoutePath.phoneVerification() : route = BasicRoutes.phoneVerification;

  GonnaRoutePath.profileInitialization()
      : route = BasicRoutes.profileInitialization;

  GonnaRoutePath.home() : route = BasicRoutes.home;

  GonnaRoutePath.unknown() : route = BasicRoutes.unknown;

  bool get isPhoneEntryPage => route == BasicRoutes.phoneEntry;

  bool get isPhoneVerificationPage => route == BasicRoutes.phoneVerification;

  bool get isProfileInitializationPage =>
      route == BasicRoutes.profileInitialization;

  bool get isHomePage => route == BasicRoutes.home;
}
