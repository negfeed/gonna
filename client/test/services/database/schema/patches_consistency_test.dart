import 'dart:io' as io;

import 'package:flutter_test/flutter_test.dart' as flutter_test;
import 'package:gonna_client/services/database/database.dart' as database;
import 'package:sqflite_common_ffi/sqflite_ffi.dart' as sqflite_ffi;
import 'package:sqflite/sqflite.dart' as sqflite;
import 'package:test/test.dart';

const currentSchemaVersion = 1;

void main() {
  setUpAll(() {
    flutter_test.TestWidgetsFlutterBinding.ensureInitialized();
    sqflite.databaseFactory = sqflite_ffi.databaseFactoryFfi;
  });

  test('Initialize non-existent database', () async {
    sqflite_ffi.sqfliteFfiInit();
    var db = await database.Database.init();
    expect(await db.getVersion(), currentSchemaVersion);
    await db.close();
    sqflite.deleteDatabase(db.path);
  });

  test('Upgrading schema through patches is equivelant to current schema',
      () async {
    for (var path in {'upgraded.db', 'created.db'}) {
      if (await sqflite.databaseExists(path)) {
        sqflite.deleteDatabase(path);
      }
    }
    var upgradedDb = await sqflite.openDatabase('upgraded.db',
        onUpgrade: database.Database.onUpgrade, version: currentSchemaVersion);
    var createdDb = await sqflite.openDatabase('created.db',
        onCreate: database.Database.onCreate, version: currentSchemaVersion);
    var result = await io.Process.run(
        'sqldiff', ['--schema', upgradedDb.path, createdDb.path]);
    expect(result.stdout, flutter_test.isEmpty,
        reason:
            'Found difference in sql schema and sum of patches: ${result.stdout}');
    sqflite.deleteDatabase(upgradedDb.path);
    sqflite.deleteDatabase(createdDb.path);
  });

  test('Patch paths start with the version number and are in order', () async {
    var paths = await database.Database.getSchemaPatchesPaths();
    var patchNumber = 1;
    for (var path in paths) {
      var name = path.split('/').last;
      flutter_test.expect(name, flutter_test.startsWith('${patchNumber}_'));
      patchNumber++;
    }
  });
}
