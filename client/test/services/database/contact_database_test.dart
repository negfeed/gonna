import 'dart:io';

import 'package:flutter_test/flutter_test.dart' as flutter_test;
import 'package:gonna_client/services/database/contact_database.dart'
    as contact_database;
import 'package:gonna_client/services/database/database.dart' as database;
import 'package:sqflite_common_ffi/sqflite_ffi.dart' as sqflite_ffi;
import 'package:sqflite/sqflite.dart' as sqflite;
import 'package:test/test.dart';

void main() {
  var db;
  var contactsDb;

  setUpAll(() async {
    flutter_test.TestWidgetsFlutterBinding.ensureInitialized();
    sqflite.databaseFactory = sqflite_ffi.databaseFactoryFfi;
    sqflite_ffi.sqfliteFfiInit();
    db = await database.Database.init();
    contactsDb = contact_database.ContactDatabase.instance;
  });

  tearDownAll(() async {
    await db.close();
    sqflite.deleteDatabase(db.path);
  });

  test('Write a contact record and read it back.', () async {

    // Arrange.
    contact_database.ContactRecord contactRecord =
        contact_database.ContactRecord.create('6509337887',
            contactsPhoneNumberType: 'personal',
            profileId: '0x123456',
            contactsFirstName: 'Mohamed',
            contactsLastName: 'Abdul-Amir',
            profileFirstName: 'Mohammad',
            profileLastName: 'Shamma');

    // Act.
    int beforeUpsert = DateTime.now().millisecondsSinceEpoch;
    sleep(Duration(milliseconds: 10));
    await contactsDb.upsertContactRecord(contactRecord);
    sleep(Duration(milliseconds: 10));
    int afterUpsert = DateTime.now().millisecondsSinceEpoch;
    contact_database.ContactRecord readContactRecord = await contactsDb.readContactRecordByPhoneNumber('6509337887');

    // Assert.
    expect(readContactRecord, equals(contactRecord));
    expect(readContactRecord.lastUpdatedTimestamp, greaterThan(beforeUpsert));
    expect(readContactRecord.lastUpdatedTimestamp, lessThan(afterUpsert));
  });
}