import 'package:gonna_client/services/database/contacts_dao.dart'
    as contacts_dao;
import 'package:gonna_client/services/firestore/profile_firestore.dart';
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

  Stream<List<User>> queryPhoneContactsUsersByName(String queryString) {
    return contacts_dao.ContactsDao.instance
        .queryContactsByName(queryString: queryString)
        .watch()
        .asyncMap((contacts) =>
            Future.wait(contacts.map(_convertToUser)));
  }

  Future<User> _convertToUser(database.Contact contact) {
    if (contact.profileId == null) {
      return Future.value(User(
        phoneNumber: contact.phoneNumber,
        firstName: contact.firstName,
        lastName: contact.lastName,
      ));
    } else {
      return ProfileFirestoreService.instance.lookupProfile(contact.profileId!)
          .then((profile) {
            if (profile != null) {
              return User(
                phoneNumber: contact.phoneNumber,
                profileId: contact.profileId,
                firstName: profile.firstName,
                lastName: profile.lastName,
              );
            } else {
              return User(
                phoneNumber: contact.phoneNumber,
                firstName: contact.firstName,
                lastName: contact.lastName,
              );
            }
          });
    }
  }
}
