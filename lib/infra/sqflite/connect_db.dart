import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

const scripts = {
  '2': [
    '''
CREATE TABLE sample(
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  name TEXT,
  password TEXT,
  email TEXT,
  created_at TEXT NOT NULL DEFAULT (DATETIME('now', 'localtime')),
  updated_at TEXT NOT NULL DEFAULT (DATETIME('now', 'localtime'))
)
'''
  ],
//   '3': [
//     '''
//   drop table sample;
//   '''
//   ],
};

class DBManager {
  DBManager._internal();

  static Database _database;
  static final DBManager _dbManager = DBManager._internal();
  static DBManager get instance => _dbManager;

  Future<Database> initDB() async {
    if (_database != null) {
      return _database;
    }
    final database = openDatabase(join(await getDatabasesPath(), 'database.db'),
        version: 1, onConfigure: _onConfigure, onCreate: _onCreate,
        onUpgrade: (Database db, int oldVersion, int newVersion) async {
      for (var i = oldVersion + 1; i <= newVersion; i++) {
        final queries = scripts[i.toString()];
        for (final query in queries) {
          await db.execute(query);
        }
      }
    });

    return _database = await database;
  }
}

Future<void> _onConfigure(Database db) async {
  await db.execute('PRAGMA foreign_keys = ON');
}

Future<void> _onCreate(Database db, int version) async {
  await _createTransaction(db);
}

Future<void> _createTransaction(Database db) async {
  await db.transaction((txn) async {
    // CREATE STUDENT
    await db.execute('''
      CREATE TABLE type(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        delete_flag TEXT,
        color TEXT,
        content TEXT,
        created_at TEXT NOT NULL DEFAULT (DATETIME('now', 'localtime')),
        updated_at TEXT NOT NULL DEFAULT (DATETIME('now', 'localtime')),
      )
    ''');

    // CREATE TASK
    await db.execute('''
      CREATE TABLE task(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        content TEXT,
        delete_flag TEXT,
        type_id INTEGER,
        created_at TEXT NOT NULL DEFAULT (DATETIME('now', 'localtime')),
        updated_at TEXT NOT NULL DEFAULT (DATETIME('now', 'localtime')),
        FOREIGN KEY (type_id) REFERENCES type (id) ON DELETE CASCADE ON UPDATE CASCADE
      )
      ''');

    // await _insertSeatTransaction(db);
  });
}

// Future<void> _insertSeatTransaction(Database db) async {
//   await db.transaction((txn) async {
//     final id = await txn.rawInsert('''
//         INSERT INTO folder(title, delete_flag) VALUES('はじめのフォルダー', 'false')
//     ''');
//   });
// }
