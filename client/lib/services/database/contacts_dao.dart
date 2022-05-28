import 'package:drift/drift.dart';
import 'package:gonna_client/services/database/database.dart';

part 'contacts_dao.g.dart';

class ContactSeed {
  String phoneNumber;
  String? firstName;
  String? lastName;
  ContactSeed(this.phoneNumber, {this.firstName, this.lastName});
}

class UpdateProfileId {
  String phoneNumber;
  String? profileId;
  UpdateProfileId(this.phoneNumber, {this.profileId=null});
}

@DriftAccessor(tables: [Contacts])
class ContactsDao extends DatabaseAccessor<GonnaDatabase>
    with _$ContactsDaoMixin {
  // this constructor is required so that the main database can create an instance
  // of this object.
  ContactsDao(GonnaDatabase db) : super(db);

  static ContactsDao? _instance;

  static ContactsDao get instance {
    if (_instance == null) {
      _instance = ContactsDao(GonnaDatabase.instance);
    }
    return _instance!;
  }

  Future<List<Contact>> readAllContacts() {
    return select(contacts).get();
  }

  Future<void> deleteContacts(Set<String> phoneNumbers) {
    return (delete(contacts)..where((c) => c.phoneNumber.isIn(phoneNumbers)))
        .go();
  }

  Future<void> createContacts(Iterable<ContactSeed> contactSeeds) async {
    await batch((batch) {
      batch.insertAll(
          contacts,
          contactSeeds
              .map((cs) => ContactsCompanion.insert(
                  phoneNumber: cs.phoneNumber,
                  firstName: Value<String>.ofNullable(cs.firstName),
                  lastName: Value<String>.ofNullable(cs.lastName),
                  creationTimestamp: Value(DateTime.now())))
              .toList());
    });
  }

  Future<void> updateProfileId(UpdateProfileId updateProfileId) async {
    await (update(contacts)
          ..where((c) => c.phoneNumber.equals(updateProfileId.phoneNumber)))
        .write(ContactsCompanion(
            profileId: Value(updateProfileId.profileId),
            lastSyncTimestamp: Value(DateTime.now())));
  }

  Future<void> updateProfileIds(
      Iterable<UpdateProfileId> updateProfileIds) async {
    await Future.wait(updateProfileIds.map((e) => updateProfileId(e)));
  }
}
