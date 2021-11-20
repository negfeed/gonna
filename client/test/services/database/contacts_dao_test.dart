import 'package:drift/native.dart';
import 'package:test/test.dart';
// the file defined above, you can test any drift database of course
import 'package:gonna_client/services/database/database.dart' as gonna_database;
import 'package:gonna_client/services/database/contacts_dao.dart'
    as contacts_dao;

void main() {
  gonna_database.GonnaDatabase? database;
  contacts_dao.ContactsDao? contactsDao;

  setUp(() {
    database = gonna_database.GonnaDatabase(NativeDatabase.memory());
    contactsDao = contacts_dao.ContactsDao(database!);
  });

  test('Create contacts and read them.', () async {
    await contactsDao!.createContacts([
      contacts_dao.ContactSeed('+123456789',
          firstName: 'John', lastName: 'Doe'),
      contacts_dao.ContactSeed('+987654321', firstName: 'Barack'),
      contacts_dao.ContactSeed('+555444555', lastName: 'Adams'),
    ]);

    await contactsDao!.readAllContacts().then((contacts) {
      expect(contacts.length, 3);
      var contact = contacts.firstWhere((c) => c.phoneNumber == '+123456789');
      expect(contact.firstName, 'John');
      expect(contact.lastName, 'Doe');
      expect(contact.profileId, isNull);
      expect(contact.creationTimestamp, isNotNull);
      expect(contact.lastSyncTimestamp, isNull);
      contact = contacts.firstWhere((c) => c.phoneNumber == '+987654321');
      expect(contact.firstName, 'Barack');
      expect(contact.lastName, isNull);
      expect(contact.profileId, isNull);
      expect(contact.creationTimestamp, isNotNull);
      expect(contact.lastSyncTimestamp, isNull);
      contact = contacts.firstWhere((c) => c.phoneNumber == '+555444555');
      expect(contact.firstName, isNull);
      expect(contact.lastName, 'Adams');
      expect(contact.profileId, isNull);
      expect(contact.creationTimestamp, isNotNull);
      expect(contact.lastSyncTimestamp, isNull);
    });
  });

  test('Create contacts then delete some.', () async {
    await contactsDao!.createContacts([
      contacts_dao.ContactSeed('+123456789',
          firstName: 'John', lastName: 'Doe'),
      contacts_dao.ContactSeed('+987654321', firstName: 'Barack'),
      contacts_dao.ContactSeed('+555444555', lastName: 'Adams'),
    ]);

    await contactsDao!.deleteContacts(['+123456789', '+987654321'].toSet());

    await contactsDao!.readAllContacts().then((contacts) {
      expect(contacts.length, 1);
      final contact = contacts.first;
      expect(contact.phoneNumber, '+555444555');
    });
  });

  test('Create contacts then update profile IDs', () async {
    await contactsDao!.createContacts([
      contacts_dao.ContactSeed('+123456789',
          firstName: 'John', lastName: 'Doe'),
      contacts_dao.ContactSeed('+987654321',
          firstName: 'Barack', lastName: 'Obama'),
    ]);

    await contactsDao!.updateProfileId(
        contacts_dao.UpdateProfileId('+123456789', profileId: '123456789'));
    await contactsDao!
        .updateProfileId(contacts_dao.UpdateProfileId('+987654321'));

    await contactsDao!.readAllContacts().then((contacts) {
      expect(contacts.length, 2);
      var contact = contacts.firstWhere((c) => c.phoneNumber == '+123456789');
      expect(contact.firstName, 'John');
      expect(contact.lastName, 'Doe');
      expect(contact.profileId, '123456789');
      expect(contact.creationTimestamp, isNotNull);
      expect(contact.lastSyncTimestamp, isNotNull);
      contact = contacts.firstWhere((c) => c.phoneNumber == '+987654321');
      expect(contact.firstName, 'Barack');
      expect(contact.lastName, 'Obama');
      expect(contact.profileId, isNull);
      expect(contact.creationTimestamp, isNotNull);
      expect(contact.lastSyncTimestamp, isNotNull);
    });
  });

  test('Create contact then set profile ID then unset profile ID', () async {
    await contactsDao!.createContacts([
      contacts_dao.ContactSeed('+123456789',
          firstName: 'John', lastName: 'Doe'),
    ]);

    await contactsDao!.updateProfileId(
        contacts_dao.UpdateProfileId('+123456789', profileId: '123456789'));

    await contactsDao!.readAllContacts().then((contacts) {
      expect(contacts.length, 1);
      var contact = contacts.first;
      expect(contact.firstName, 'John');
      expect(contact.lastName, 'Doe');
      expect(contact.profileId, '123456789');
      expect(contact.creationTimestamp, isNotNull);
      expect(contact.lastSyncTimestamp, isNotNull);
    });

    await contactsDao!.updateProfileId(
        contacts_dao.UpdateProfileId('+123456789', profileId: null));

    await contactsDao!.readAllContacts().then((contacts) {
      expect(contacts.length, 1);
      var contact = contacts.first;
      expect(contact.firstName, 'John');
      expect(contact.lastName, 'Doe');
      expect(contact.profileId, isNull);
      expect(contact.creationTimestamp, isNotNull);
      expect(contact.lastSyncTimestamp, isNotNull);
    });
  });

  test('Create contacts then update multiple profile IDs', () async {
    await contactsDao!.createContacts([
      contacts_dao.ContactSeed('+123456789',
          firstName: 'John', lastName: 'Doe'),
      contacts_dao.ContactSeed('+987654321',
          firstName: 'Barack', lastName: 'Obama'),
    ]);

    await contactsDao!.updateProfileIds([
      contacts_dao.UpdateProfileId('+123456789', profileId: '123456789'),
      contacts_dao.UpdateProfileId('+987654321')
    ]);

    await contactsDao!.readAllContacts().then((contacts) {
      expect(contacts.length, 2);
      var contact = contacts.firstWhere((c) => c.phoneNumber == '+123456789');
      expect(contact.firstName, 'John');
      expect(contact.lastName, 'Doe');
      expect(contact.profileId, '123456789');
      expect(contact.creationTimestamp, isNotNull);
      expect(contact.lastSyncTimestamp, isNotNull);
      contact = contacts.firstWhere((c) => c.phoneNumber == '+987654321');
      expect(contact.firstName, 'Barack');
      expect(contact.lastName, 'Obama');
      expect(contact.profileId, isNull);
      expect(contact.creationTimestamp, isNotNull);
      expect(contact.lastSyncTimestamp, isNotNull);
    });
  });

  tearDown(() async {
    await database!.close();
  });
}
