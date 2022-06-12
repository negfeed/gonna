import 'package:drift/native.dart';
import 'package:test/test.dart';
// the file defined above, you can test any drift database of course
import 'package:gonna_client/services/database/database.dart' as gonna_database;
import 'package:gonna_client/services/database/contacts_dao.dart'
    as contacts_dao;
import 'package:gonna_client/services/database/contacts_profiles_dao.dart'
    as contacts_profiles_dao;
import 'package:gonna_client/services/database/profiles_dao.dart'
    as profiles_dao;

void main() {
  gonna_database.GonnaDatabase? database;
  contacts_dao.ContactsDao? contactsDao;
  profiles_dao.ProfilesDao? profilesDao;
  contacts_profiles_dao.ContactsProfilesDao? contactsProfilesDao;

  setUp(() {
    database = gonna_database.GonnaDatabase(NativeDatabase.memory());
    contactsProfilesDao = contacts_profiles_dao.ContactsProfilesDao(database!);
    contactsDao = contacts_dao.ContactsDao(database!);
    profilesDao = profiles_dao.ProfilesDao(database!);
  });

  tearDown(() async {
    await database!.close();
  });

  test('Get contacts/profiles from an empty database', () async {
    var contactsProfiles = await contactsProfilesDao!.getAllContactsProfiles();
    expect(contactsProfiles, isEmpty);
  });

  test('Get contacts/profiles from a database with contacts only', () async {
    await contactsDao!.createContacts([
      contacts_dao.ContactSeed('1234567890',
          firstName: 'John', lastName: 'Doe'),
      contacts_dao.ContactSeed('1234567891', firstName: 'Jane', lastName: 'Doe')
    ]);
    var contactsProfiles = await contactsProfilesDao!.getAllContactsProfiles();
    expect(contactsProfiles, hasLength(2));
    var contactProfile = contactsProfiles
        .firstWhere((c) => c.contact.phoneNumber == '1234567890');
    expect(contactProfile.contact.firstName, 'John');
    expect(contactProfile.contact.lastName, 'Doe');
    expect(contactProfile.profile, isNull);
    contactProfile = contactsProfiles
        .firstWhere((c) => c.contact.phoneNumber == '1234567891');
    expect(contactProfile.contact.firstName, 'Jane');
    expect(contactProfile.contact.lastName, 'Doe');
    expect(contactProfile.profile, isNull);
  });

  test('Get contacts/profiles from a database with contacts and profiles',
      () async {
    await contactsDao!.createContacts([
      contacts_dao.ContactSeed('1234567890',
          firstName: 'John', lastName: 'Doe'),
      contacts_dao.ContactSeed('1234567891', firstName: 'Jane', lastName: 'Doe')
    ]);
    await contactsDao!.updateProfileId(
        contacts_dao.UpdateProfileId('1234567890', profileId: 'profile-id-1'));
    await profilesDao!.upsertProfiles([
      profiles_dao.UpsertProfile('profile-id-1',
          firstName: 'Johnny', lastName: 'Doeherty')
    ]);
    var contactsProfiles = await contactsProfilesDao!.getAllContactsProfiles();
    expect(contactsProfiles, hasLength(2));
    var contactProfile = contactsProfiles
        .firstWhere((c) => c.contact.phoneNumber == '1234567890');
    expect(contactProfile.contact.firstName, 'John');
    expect(contactProfile.contact.lastName, 'Doe');
    expect(contactProfile.contact.profileId, 'profile-id-1');
    expect(contactProfile.profile, isNotNull);
    expect(contactProfile.profile!.profileId, 'profile-id-1');
    expect(contactProfile.profile!.firstName, 'Johnny');
    expect(contactProfile.profile!.lastName, 'Doeherty');
    contactProfile = contactsProfiles
        .firstWhere((c) => c.contact.phoneNumber == '1234567891');
    expect(contactProfile.contact.firstName, 'Jane');
    expect(contactProfile.contact.lastName, 'Doe');
    expect(contactProfile.profile, isNull);
  });
}
