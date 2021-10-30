import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

part 'database.g.dart';

late Database _instance;

Database get instance {
  return _instance;
}

Future<void> init() async {
  _instance = Database();
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

@DriftDatabase(tables: [Contacts])
class Database extends _$Database {
 
  Database() : super(_openConnection());  

  @override
  int get schemaVersion => 1;
}
