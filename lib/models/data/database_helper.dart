import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;

  static Database? _database;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
  String path = join(await getDatabasesPath(), 'feedback.db');
  print('Database Path: $path'); // Log the path
  return await openDatabase(
    path,
    version: 1,
    onCreate: _createDB,
  );
}

  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE feedback(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        email TEXT,
        mobile TEXT,
        feedback TEXT,
        datetime TEXT
      )
    ''');
  }

  Future<void> insertFeedback(Map<String, dynamic> feedback) async {
    final db = await database;
    await db.insert(
      'feedback',
      feedback,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Map<String, dynamic>>> getFeedbacks() async {
    final db = await database;
    return await db.query('feedback');
  }

  Future<void> deleteFeedback(int id) async {
    final db = await database;
    await db.delete(
      'feedback',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
