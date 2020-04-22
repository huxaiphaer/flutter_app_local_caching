import 'dart:async';
import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

final todoTable = "todoTable";
class DatabaseProvider {
  static final DatabaseProvider dbProvider = DatabaseProvider();

  Database _database;

  String colId = "id";
  String description = "description";
  String is_done = "is_done";

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await createDatabase();
    return _database;
  }

  createDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();

    // ReactiveTodo.db is our database instance name
    String path = join(documentsDirectory.path, "ReactiveTodo.db");

    var database = await openDatabase(path,
        version: 1, onCreate: initDB, onUpgrade: onUpgrade);

    return database;
  }

  void initDB(Database db, int version) async {
    await db.execute(
        'CREATE TABLE $todoTable($colId INTEGER PRIMARY KEY AUTOINCREMENT, $description TEXT, '
        '$is_done INTEGER)');
  }

  void onUpgrade(Database db, int oldVersion, int newVersion) {
    if (newVersion > oldVersion) {}
  }
}

String join(String path, String s) {
  return path + s;
}
