import 'dart:async';

import 'package:notes/core/const/app_strings.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseProvider {
  static late Database database;
  static Future init(
      {required String databasesName,
      required int version,
      required String query}) async {
    final databasesPath = await getDatabasesPath();
    String path = join(databasesPath, databasesName);
    database = await openDatabase(path, version: version,
        onCreate: (Database db, int version) async {
      await db.execute(query);
    }, onOpen: (createdDatabase) async {
      database = createdDatabase;
    });
  }

  static Future<List<Map<String, Object?>>> getAllDataFromDatabase(
      String tableName) async {
    return await database.rawQuery('SELECT * FROM $tableName');
  }

  static Future<int> deleteDataFromDatabaseById(
      {required int id, required String tableName}) async {
    return await database
        .rawDelete('DELETE FROM $tableName WHERE  dataBaseId=$id');
  }

  static Future<int> deleteAllDataFromDatabase(
      {required String tableName}) async {
    return await database.rawDelete('DELETE FROM $tableName');
  }

  static Future<void> insertIntoDataBase(
      {required List<Object?> data, required String query}) async {
    await database.execute(
      query,
      data,
    );
  }

  static Future<List<Object?>> insertListToDatabase(
      List<Map<String, dynamic>> data) async {
    final batch = database.batch();
    for (var element in data) {
      batch.insert(AppStrings.tableName, element);
    }
    return await batch.commit();
  }

  static Future<int> updateDataBase(String query, List arguments) async {
    return await database.rawUpdate(query, arguments);
  }

  static Future close() async => database.close();
}
