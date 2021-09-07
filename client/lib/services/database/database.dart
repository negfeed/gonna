import 'dart:convert';

import 'package:flutter/foundation.dart' as foundation;
import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

class Database {
  static const schemaRootPath = 'lib/services/database/schema';
  static const currentSchemaPath = '$schemaRootPath/current.sql';
  static const schemaPatchesPath = '$schemaRootPath/patches';
  static const schemaPatchesIndexPath = '$schemaPatchesPath/index.txt';

  static late sqflite.Database database;

  static Future<sqflite.Database> init() async {
    var version = await _countPatches();
    database = await sqflite.openDatabase('gonna.db',
        onCreate: onCreate,
        onUpgrade: onUpgrade,
        onDowngrade: _onDowngrade,
        version: version);
    return database;
  }

  @foundation.visibleForTesting
  static void onCreate(sqflite.Database db, int version) async {
    var createDatabaseSql = await _getCurrentSchema();
    db.execute(createDatabaseSql);
  }

  @foundation.visibleForTesting
  static void onUpgrade(
      sqflite.Database db, int oldVersion, int newVersion) async {
    var patchPaths = await getSchemaPatchesPaths();
    var patchPathsToApply = patchPaths.skip(oldVersion);
    for (var patchPath in patchPathsToApply) {
      var patchSql = await _getTextAssetContents(patchPath);
      db.execute(patchSql);
    }
  }

  static void _onDowngrade(
      sqflite.Database db, int oldVersion, int newVersion) {
    throw Exception('Downgrades are not supported');
  }

  static Future<int> _countPatches() async {
    var patchesPaths = await getSchemaPatchesPaths();
    return patchesPaths.length;
  }

  static Future<String> _getCurrentSchema() async {
    return _getTextAssetContents('$currentSchemaPath');
  }

  @foundation.visibleForTesting
  static Future<Iterable<String>> getSchemaPatchesPaths() async {
    var patchesIndexText =
        await _getTextAssetContents('$schemaPatchesIndexPath');
    return LineSplitter.split(patchesIndexText)
        .where((line) => line.trim().isNotEmpty)
        .map((patchName) => '$schemaPatchesPath/$patchName');
  }

  static Future<String> _getTextAssetContents(String path) async {
    return rootBundle.loadString(path);
  }
}
