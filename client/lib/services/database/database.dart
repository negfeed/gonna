import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:gonna_client/services/database/app_state_dao.dart';
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
  TextColumn get phoneNumber => text()();
  TextColumn get contactsPhoneNumberType => text().nullable()();
  TextColumn get profileId => text()();
  TextColumn get contactsFirstName => text().nullable()();
  TextColumn get contactsLastName => text().nullable()();
  TextColumn get profileFirstName => text().nullable()();
  TextColumn get profileLastName => text().nullable()();
  IntColumn get creationTimestamp => integer()();
  DateTimeColumn get lastUpdatedTimestamp => dateTime()();

  @override
  Set<Column> get primaryKey => {phoneNumber, profileId};
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

@DriftDatabase(tables: [AppState, Contacts], daos: [AppStateDao])
class GonnaDatabase extends _$GonnaDatabase {
  GonnaDatabase() : super(_openConnection());

  static late GonnaDatabase _instance;

  static GonnaDatabase get instance {
    return _instance;
  }

  static Future<void> init() async {
    _instance = GonnaDatabase();
  }

  @override
  int get schemaVersion => 1;
}
