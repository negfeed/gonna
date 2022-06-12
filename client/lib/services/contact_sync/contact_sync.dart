import 'package:gonna_client/services/auth/auth.dart' as auth;
import 'package:gonna_client/services/contacts/contacts.dart' as phone_contacts;
import 'package:gonna_client/services/database/contacts_dao.dart'
    as contacts_dao;
import 'package:gonna_client/services/database/database.dart';
import 'package:gonna_client/services/database/profiles_dao.dart'
    as profiles_dao;
import 'package:gonna_client/services/firestore/phone_firestore.dart'
    as phone_firestore;
import 'package:gonna_client/services/firestore/profile_firestore.dart'
    as profile_firestore;
import 'package:synchronized/synchronized.dart' as synchronized;

class ContactSyncService {
  static ContactSyncService? _instance;

  static ContactSyncService get instance {
    if (_instance == null) {
      _instance = ContactSyncService();
    }
    return _instance!;
  }

  static bool _scheduledSyncKicked = false;

  static void scheduleSyncAllContacts() {
    auth.AuthService.instance.currentUserChanges().listen((auth.User? user) {
      if (!_scheduledSyncKicked &&
          user != null &&
          user.getSignInProvider() == auth.SignInProvider.device) {
        _scheduledSyncKicked = true;
        ContactSyncService.instance.syncAllContacts();
      }
    });
  }

  final lock = synchronized.Lock();

  Future<void> _syncPhoneNumbers() async {
    // Steps:
    // 1. Read and create a set of all phone numbers found in phone contacts.
    // 2. Read phones and last sync time from the local database.
    // 3. Delete the set of phones not in the phone book but are in the database.
    // 4. Insert empty records for phones numbers in the phone book but not in
    //    the database.

    print('Syncing phone numbers.');

    // 1. Read phone contacts.
    var e164PhoneNumbersToContactMap = await phone_contacts
        .ContactsService.instance
        .getE164PhoneNumberToContactMap();

    // 2. Read database contacts.
    var contactsFromDatabase =
        await contacts_dao.ContactsDao.instance.readAllContacts().get();

    Set<String> phoneNumbersInPhone =
        Set.from(e164PhoneNumbersToContactMap.keys);
    Set<String> phoneNumbersInDatabase =
        Set.from(contactsFromDatabase.map((c) => c.phoneNumber));

    // 3. Delete the set of phones not in the phone book but are in the database.
    final phoneNumbersToDelete =
        phoneNumbersInDatabase.difference(phoneNumbersInPhone);
    await contacts_dao.ContactsDao.instance
        .deleteContacts(phoneNumbersToDelete);

    // 4. Insert records for phone numbers in the phone book but not in
    //    the database.
    final phoneNumbersToAdd =
        phoneNumbersInPhone.difference(phoneNumbersInDatabase);
    await contacts_dao.ContactsDao.instance
        .createContacts(phoneNumbersToAdd.map((phoneNumber) {
      final contact = e164PhoneNumbersToContactMap[phoneNumber]!;
      return contacts_dao.ContactSeed(phoneNumber,
          firstName: contact.givenName, lastName: contact.familyName);
    }));
  }

  // TODO(mshamma): Implement the more efficient solution of syncing the top N priority profiles.
  Future<void> _syncProfileIds() async {
    // Steps:
    // 1. Retrieve all contacts.
    // 2. Calculate the priority list of phone numbers from the phone book.
    // 3. Lookup the top N phone numbers from the priority list.
    //     a. Read phone in phone to profile table.
    //     b. Read profile.
    // 4. Update the read results into the database setting the sync timestamp.
    //
    // How do we calculate priority?
    //
    // Factors that affect priority:
    // - Phone in phonebook
    // - Phone in local database.
    // - Phone last sync is recent.
    //
    // | In phone book | In database | Recent sync | Action | Priority |
    // | ------------- | ----------- | ----------- | ------ | -------- |
    // | true          | true        | true        | sync   | low      |
    // | true          | true        | false       | sync   | medium   |
    // | true          | false       | -           | sync   | high     |
    // | false         | true        | -           | delete | -        |

    print('Syncing profile IDs');

    // 1. Retrieve all contacts.
    final contactsFromDatabase =
        await contacts_dao.ContactsDao.instance.readAllContacts().get();

    // 2. Update the read results into the database setting the sync timestamp.
    final contactStream = Stream.fromIterable(contactsFromDatabase);
    await for (final contactsBatch in _batchContacts(contactStream)) {
      final List<String> phones =
          contactsBatch.map((c) => c.phoneNumber).toList();
      final phoneMap = await phone_firestore.PhoneFirestoreService.instance
          .getPhoneDocsOfPhoneNumbers(phones);
      final List<String> profileIds = phoneMap.values
          .where((e) => e.profileId != null)
          .map((e) => e.profileId!)
          .toSet()
          .toList();
      final profileMap = await profile_firestore.ProfileFirestoreService.instance
              .getProfileDocsOfProfileIds(profileIds);

      List<contacts_dao.UpdateProfileId> contactsToUpdate = [];
      List<profiles_dao.UpsertProfile> profilesToUpsert = [];
      contactsBatch.forEach((contact) {
        final phoneDoc = phoneMap[contact.phoneNumber] ?? null;
        final profileDoc = profileMap[phoneDoc?.profileId] ?? null;
        contactsToUpdate.add(contacts_dao.UpdateProfileId(contact.phoneNumber,
            profileId: phoneDoc?.profileId));
        if (profileDoc != null) {
          profilesToUpsert.add(profiles_dao.UpsertProfile(phoneDoc!.profileId!,
              firstName: profileDoc.firstName, lastName: profileDoc.lastName));
        }
      });

      await contacts_dao.ContactsDao.instance
          .updateProfileIds(contactsToUpdate);
      await profiles_dao.ProfilesDao.instance.upsertProfiles(profilesToUpsert);
    }
  }

  Stream<List<Contact>> _batchContacts(Stream<Contact> contacts) async* {
    List<Contact> batch = [];
    await for (final contact in contacts) {
      batch.add(contact);
      if (batch.length == 10) {
        yield batch;
        batch = [];
      }
    }
    if (batch.isNotEmpty) {
      yield batch;
    }
  }

  Future<void> syncAllContacts() async {
    // Allow only one sync at a time.
    await lock.synchronized(() async {
      print('Starting sync of all contacts.');
      // Steps:
      // 1. Sync the phone numbers in the contacts database. Basically remove
      //    database contacts that are no longer in the phone and create
      //    database contacts for phone numbers that don't already exist in
      //    the database.
      await _syncPhoneNumbers();

      // 2. Sync profile IDs in the contacts database from the phone directory.
      //    If the phone is found, make sure to update the profile ID in the
      //    local database. If the phone is not found, make sure to unlink any
      //    profile ID associated with the contact in the local database.
      await _syncProfileIds();

      print('Finished sync of all contacts.');
    });
  }
}
