import 'package:gonna_client/services/database/contacts_profiles_dao.dart'
    as contacts_profiles_dao;

class User {
  String phoneNumber;
  String? profileId;
  String? firstName;
  String? lastName;

  User({
    required this.phoneNumber,
    this.profileId,
    this.firstName,
    this.lastName,
  });
}

class UserService {
  static UserService? _instance;

  static UserService get instance {
    if (_instance == null) {
      _instance = UserService();
    }
    return _instance!;
  }

  bool _userHasSomeName(User user) {
    return user.firstName?.isNotEmpty == true ||
        user.lastName?.isNotEmpty == true;
  }

  bool _userMatchesQuery(User user, String query) {
    List<String> words = query.split(' ');
    for (String word in words) {
      if (user.firstName?.toLowerCase().contains(word.toLowerCase()) != true &&
          user.lastName?.toLowerCase().contains(word.toLowerCase()) != true) {
        return false;
      }
    }
    ;
    return true;
  }

  Stream<List<User>> queryPhoneContactsUsersByName(String queryString) {
    return contacts_profiles_dao.ContactsProfilesDao.instance
        .watchAllContactsProfiles(orderByName: true)
        .asyncMap((contactsProfiles) => contactsProfiles
            .map(_convertToUser)
            .where(_userHasSomeName)
            .where((user) => _userMatchesQuery(user, queryString))
            .toList());
  }

  User _convertToUser(contacts_profiles_dao.ContactProfile contactProfile) {
    if (contactProfile.profile == null) {
      return User(
        phoneNumber: contactProfile.contact.phoneNumber,
        firstName: contactProfile.contact.firstName,
        lastName: contactProfile.contact.lastName,
      );
    } else {
      return User(
        phoneNumber: contactProfile.contact.phoneNumber,
        profileId: contactProfile.contact.profileId,
        firstName: contactProfile.profile!.firstName,
        lastName: contactProfile.profile!.lastName,
      );
    }
  }
}
