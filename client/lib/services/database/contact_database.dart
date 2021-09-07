import 'dart:async';

import 'package:gonna_client/services/database/database.dart' as database;
import 'package:sqflite/sqflite.dart' as sqflite;

final String contactsTable = 'contacts';
final String phoneNumberColumn = 'phone_number';
final String contactsPhoneNumberColumn = 'contacts_phone_number_type';
final String profileIdColumn = 'profile_id';
final String contactsFirstNameColumn = 'contacts_first_name';
final String contactsLastNameColumn = 'contacts_last_name';
final String profileFirstNameColumn = 'profile_first_name';
final String profileLastNameColumn = 'profile_last_name';
final String firstNameColumn = 'first_name';
final String lastNameColumn = 'last_name';
final String lastUpdatedTimestampColumn = 'last_updated_timestamp';

class Contact {}

class ContactRecord {
  late final String phoneNumber;
  late final String contactsPhoneNumberType;
  late final String profileId;
  late final String contactsFirstName;
  late final String contactsLastName;
  late final String profileFirstName;
  late final String profileLastName;
  late final String firstName;
  late final String lastName;
  late final int lastUpdatedTimestamp;

  static List<String> getColumns() {
    return List.of([
      phoneNumberColumn,
      contactsPhoneNumberColumn,
      profileIdColumn,
      contactsFirstNameColumn,
      contactsLastNameColumn,
      profileFirstNameColumn,
      profileLastNameColumn,
      firstNameColumn,
      lastNameColumn,
      lastUpdatedTimestampColumn,
    ]);
  }

  Map<String, Object?> toMap() {
    var map = <String, Object?>{
      phoneNumberColumn: phoneNumber,
      contactsPhoneNumberColumn: contactsPhoneNumberType,
      profileIdColumn: profileId,
      contactsFirstNameColumn: contactsFirstName,
      contactsLastNameColumn: contactsLastName,
      profileFirstNameColumn: profileFirstName,
      profileLastNameColumn: profileLastName,
      firstNameColumn: firstName,
      lastNameColumn: lastName,
      lastUpdatedTimestampColumn: lastUpdatedTimestamp
    };
    return map;
  }

  ContactRecord.fromMap(Map<String, Object?> map) {
    phoneNumber = map[phoneNumberColumn] as String;
    contactsPhoneNumberType = map[contactsFirstNameColumn] as String;
    profileId = map[profileIdColumn] as String;
    contactsFirstName = map[contactsFirstNameColumn] as String;
    contactsLastName = map[contactsLastNameColumn] as String;
    profileFirstName = map[profileFirstNameColumn] as String;
    profileLastName = map[profileLastNameColumn] as String;
    firstName = map[firstNameColumn] as String;
    lastName = map[lastNameColumn] as String;
    lastUpdatedTimestamp = map[lastUpdatedTimestampColumn] as int;
  }
}

class ContactDatabase {
  final sqflite.Database _database = database.Database.instance;

  static ContactDatabase? _instance;

  static ContactDatabase get instance {
    if (_instance == null) {
      _instance = ContactDatabase();
    }
    return _instance!;
  }

  void upsertContactRecord(ContactRecord contactRecord) async {
    await _database.insert(contactsTable, contactRecord.toMap(),
        conflictAlgorithm: sqflite.ConflictAlgorithm.replace);
  }

  void deleteContactRecord(String phoneNumber) async {
    await _database.delete(contactsTable,
        where: '$phoneNumberColumn = ?', whereArgs: [phoneNumber]);
  }

  Future<Iterable<ContactRecord>> readAllContactRecords() async {
    return _database
        .query(contactsTable, columns: ContactRecord.getColumns())
        .then((listOfMaps) =>
            listOfMaps.map((map) => ContactRecord.fromMap(map)));
  }

  Stream<Contact> readContactByPhoneNumber(String phoneNumber) {
    // Read contact
    return Stream.empty();
  }

  Stream<List<Contact>> readContactsByProfileIds(List<String> profileIds) {
    return Stream.empty();
  }

  Stream<List<Contact>> query(String query) {
    return Stream.empty();
  }
}
