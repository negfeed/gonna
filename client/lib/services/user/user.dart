import 'package:gonna_client/services/database/contacts_dao.dart'
    as contacts_dao;
import '../database/database.dart' as database;

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
    return contacts_dao.ContactsDao.instance.readAllContacts().watch().asyncMap(
        (contacts) => contacts
            .map(_convertToUser)
            .where(_userHasSomeName)
            .where((user) => _userMatchesQuery(user, queryString))
            .toList());
  }

  User _convertToUser(database.Contact contact) {
    if (contact.profileId == null) {
      return User(
        phoneNumber: contact.phoneNumber,
        firstName: contact.firstName,
        lastName: contact.lastName,
      );
    } else {
      return User(
        phoneNumber: contact.phoneNumber,
        profileId: contact.profileId,
        firstName: contact.profileFirstName,
        lastName: contact.profileLastName,
      );
    }
  }
}
