import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  DatabaseHelper._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final path = join(await getDatabasesPath(), 'local_data.db');
    return openDatabase(
      path,
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE urls(id INTEGER PRIMARY KEY AUTOINCREMENT, date TEXT, url TEXT, result TEXT)',
        );
      },
      version: 1,
    );
  }

  Future<void> insertUrlData({required String date, required String url, required String result}) async {
    final db = await database;
    await db.insert(
      'urls',
      {'date': date, 'url': url, 'result': result},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Map<String, dynamic>>> getUrlData() async {
    final db = await database;
    return db.query('urls');
  }

  Future<void> deleteUrlData(int id) async {
    final db = await database;
    await db.delete(
      'urls',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
