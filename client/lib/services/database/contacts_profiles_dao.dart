import 'package:drift/drift.dart';
import 'package:gonna_client/services/database/database.dart';

part 'contacts_profiles_dao.g.dart';

class ContactProfile {
  Contact contact;
  Profile? profile;
  ContactProfile(this.contact, {this.profile = null});
}

@DriftAccessor(tables: [Contacts, Profiles])
class ContactsProfilesDao extends DatabaseAccessor<GonnaDatabase>
    with _$ContactsProfilesDaoMixin {
  // this constructor is required so that the main database can create an instance
  // of this object.
  ContactsProfilesDao(GonnaDatabase db) : super(db);

  static ContactsProfilesDao? _instance;

  static ContactsProfilesDao get instance {
    if (_instance == null) {
      _instance = ContactsProfilesDao(GonnaDatabase.instance);
    }
    return _instance!;
  }

  Future<Iterable<ContactProfile>> getAllContactsProfiles({orderByName: false}) {
    return _readAllContactsProfiles(orderByName: orderByName)
        .get()
        .then(_mapToContactProfile);
  }

  Stream<Iterable<ContactProfile>> watchAllContactsProfiles({orderByName: false}) {
    return _readAllContactsProfiles(orderByName: orderByName)
        .watch()
        .map(_mapToContactProfile);
  }

  JoinedSelectStatement<HasResultSet, dynamic> _readAllContactsProfiles(
      {orderByName: false}) {
    var query = select(contacts).join([
      leftOuterJoin(profiles, contacts.profileId.equalsExp(profiles.profileId))
    ]);
    if (orderByName) {
      query = query
        ..orderBy([
          OrderingTerm.asc(contacts.firstName),
          OrderingTerm.asc(contacts.lastName),
          OrderingTerm.asc(profiles.firstName),
          OrderingTerm.asc(profiles.lastName),
        ]);
    }
    return query;
  }

  Iterable<ContactProfile> _mapToContactProfile(List<TypedResult> rows) {
    // If this list is empty, then we have to explicitly return an empty list
    // to force the type to be List<ContactProfile>.
    if (rows.isEmpty) {
      return [];
    }
    return rows.map((row) {
      return ContactProfile(row.readTable(contacts),
          profile: row.readTableOrNull(profiles));
    });
  }
}
