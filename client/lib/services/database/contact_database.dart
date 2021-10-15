import 'dart:async';

import 'package:flutter/foundation.dart' as foundation;
import 'package:gonna_client/services/database/database.dart' as database;
import 'package:quiver/core.dart' as quiver;
import 'package:sqflite/sqflite.dart' as sqflite;

final String contactsTable = 'contacts';
final String phoneNumberColumn = 'phone_number';
final String contactsPhoneNumberColumn = 'contacts_phone_number_type';
final String profileIdColumn = 'profile_id';
final String contactsFirstNameColumn = 'contacts_first_name';
final String contactsLastNameColumn = 'contacts_last_name';
final String profileFirstNameColumn = 'profile_first_name';
final String profileLastNameColumn = 'profile_last_name';
final String lastUpdatedTimestampColumn = 'last_updated_timestamp';

class Contact {}

class ContactRecord {
  late final String phoneNumber;
  late final String? contactsPhoneNumberType;
  late final String? profileId;
  late final String? contactsFirstName;
  late final String? contactsLastName;
  late final String? profileFirstName;
  late final String? profileLastName;
  int? _lastUpdatedTimestamp;

  int? get lastUpdatedTimestamp {
    return this._lastUpdatedTimestamp;
  }

  static List<String> getColumns() {
    return List.of([
      phoneNumberColumn,
      contactsPhoneNumberColumn,
      profileIdColumn,
      contactsFirstNameColumn,
      contactsLastNameColumn,
      profileFirstNameColumn,
      profileLastNameColumn,
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
      profileLastNameColumn: profileLastName
    };
    return map;
  }

  T? tryCast<T>(dynamic object) => object is T ? object : null;

  ContactRecord.fromMap(Map<String, Object?> map) {
    phoneNumber = map[phoneNumberColumn] as String;
    contactsPhoneNumberType = tryCast<String>(map[contactsPhoneNumberColumn]);
    profileId = tryCast<String>(map[profileIdColumn]);
    contactsFirstName = tryCast<String>(map[contactsFirstNameColumn]);
    contactsLastName = tryCast<String>(map[contactsLastNameColumn]);
    profileFirstName = tryCast<String>(map[profileFirstNameColumn]);
    profileLastName = tryCast<String>(map[profileLastNameColumn]);
    _lastUpdatedTimestamp = tryCast<int>(map[lastUpdatedTimestampColumn]);
  }

  ContactRecord.create(this.phoneNumber,
      {this.contactsPhoneNumberType,
      this.profileId,
      this.contactsFirstName,
      this.contactsLastName,
      this.profileFirstName,
      this.profileLastName});

  @override
  bool operator ==(Object other) {
    if (!(other is ContactRecord)) {
      return false;
    }
    return phoneNumber == other.phoneNumber &&
        contactsPhoneNumberType == other.contactsPhoneNumberType &&
        profileId == other.profileId &&
        contactsFirstName == other.contactsFirstName &&
        contactsLastName == other.contactsLastName &&
        profileFirstName == other.profileFirstName &&
        profileLastName == other.profileLastName;
  }

  @override
  int get hashCode => quiver.hashObjects([
        phoneNumber,
        contactsPhoneNumberType,
        profileId,
        contactsFirstName,
        contactsLastName,
        profileFirstName,
        profileLastName
      ]);
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

  Future<void> upsertContactRecord(ContactRecord contactRecord) async {
    var contactRecordMap = contactRecord.toMap();
    contactRecordMap[lastUpdatedTimestampColumn] = DateTime.now().millisecondsSinceEpoch;
    await _database.insert(contactsTable, contactRecordMap,
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

  @foundation.visibleForTesting
  Future<ContactRecord> readContactRecordByPhoneNumber(
      String phoneNumber) async {
    return _database.query(contactsTable,
        columns: ContactRecord.getColumns(),
        where: '$phoneNumberColumn = ?',
        whereArgs: [
          phoneNumber
        ]).then((listOfOneMap) => ContactRecord.fromMap(listOfOneMap.single));
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
