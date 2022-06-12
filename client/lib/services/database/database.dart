import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:gonna_client/services/database/app_state_dao.dart';
import 'package:gonna_client/services/database/contacts_dao.dart';
import 'package:gonna_client/services/database/profiles_dao.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

part 'database.g.dart';

class AppState extends Table {
  // - ID: Primary key.
  IntColumn get id => integer()();
  // Phone auth stuff.
  // - verification starting time.
  DateTimeColumn get verificationStartTime => dateTime()();
  // - verification timeout: The time the OTP is valid.
  IntColumn get verificationTimeoutInSeconds => integer().nullable()();
  // - verification ID: passed in with the verification code.
  TextColumn get verificationId => text().nullable()();
  // - resend token: passed to the resend a new verification code (not currently used).
  IntColumn get resendToken => integer().nullable()();
  // - phone number: holds the phone number we requested authentication for.
  TextColumn get phoneNumber => text().nullable()();
  // - phone number mapped to profile ID.
  BoolColumn get phoneNumberMappedToProfile =>
      boolean().nullable().withDefault(const Constant(false))();
  // Profile stuff.
  // - first name.
  TextColumn get firstName => text().nullable()();
  // - last name.
  TextColumn get lastName => text().nullable()();
}

class Contacts extends Table {
  // Phone number stored in the E164 format.
  TextColumn get phoneNumber => text()();

  // The profile ID associated with the contact.
  TextColumn get profileId => text().nullable()();

  // Contact's first name as it appears in the phone contacts.
  TextColumn get firstName => text().nullable()();

  // Contact's last name as it appears in the phone contacts.
  TextColumn get lastName => text().nullable()();

  // The time when this record was first created.
  DateTimeColumn get creationTimestamp =>
      dateTime().withDefault(currentDateAndTime)();

  // The time when the contact information was last updated from the server.
  DateTimeColumn get lastSyncTimestamp => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {phoneNumber};
}

class Profiles extends Table {
  // The profile ID.
  TextColumn get profileId => text()();

  // The first name that appears on the profile.
  TextColumn get firstName => text().nullable()();

  // The last name that appears on the profile.
  TextColumn get lastName => text().nullable()();

  // The time when this record was first created.
  DateTimeColumn get creationTimestamp =>
      dateTime().withDefault(currentDateAndTime)();

  // The time when the profile information was last updated from the server.
  DateTimeColumn get lastSyncTimestamp => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {profileId};
}

LazyDatabase _openConnection() {
  // the LazyDatabase util lets us find the right location for the file async.
  return LazyDatabase(() async {
    // put the database file, called db.sqlite here, into the documents folder
    // for your app.
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'gonna.sqlite'));
    return NativeDatabase(file);
  });
}

Future<void> _deleteDatabase() async {
  final dbFolder = await getApplicationDocumentsDirectory();
  final file = File(p.join(dbFolder.path, 'gonna.sqlite'));
  await file.delete();
}

@DriftDatabase(
    tables: [AppState, Contacts, Profiles],
    daos: [AppStateDao, ContactsDao, ProfilesDao])
class GonnaDatabase extends _$GonnaDatabase {
  GonnaDatabase(QueryExecutor e) : super(e);

  static GonnaDatabase? _instance;

  static GonnaDatabase get instance {
    if (_instance == null) {
      _instance = GonnaDatabase(_openConnection());
    }
    return _instance!;
  }

  @override
  int get schemaVersion => 1;

  closeAndDelete() async {
    await close();
    await _deleteDatabase();
  }
}
