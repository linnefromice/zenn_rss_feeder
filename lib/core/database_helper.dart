import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final _dbName = 'zenn_rss_feeder_db.db';
  static final _dbVersion = 1;

  static final tableName = 'favorite_feed';

  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database _database;
  Future<Database> getDatabase() async {
    if (_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }

  Future<Database> _initDatabase() async {
    final documentDirectory = await getApplicationDocumentsDirectory();
    final path = documentDirectory.path + _dbName;
    // await deleteDatabase(path); // for development
    return await openDatabase(
      path,
      version: _dbVersion,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $tableName (
        id INTEGER PRIMARY KEY,
        title TEXT NOT NULL,
        genre TEXT NOT NULL,
        addedDate TEXT NOT NULL,
        authorName TEXT NOT NULL,
        pubDate TEXT NOT NULL,
        description TEXT NOT NULL,
        link TEXT NOT NULL,
        version INTEGER NOT NULL
      );
    ''');
  }

  Future<int> insert(final Map<String, dynamic> row, final String table) async {
    final db = await instance.getDatabase();
    return await db.insert(table, row);
  }

  Future<List<Map<String, dynamic>>> selectAllRows(final String table) async {
    final db = await instance.getDatabase();
    return await db.query(table);
  }

  Future<List<Map<String, dynamic>>> selectAllRowsOrderBySpecified(
    final String table,
    final String sortColumn
  ) async {
    final db = await instance.getDatabase();
    return await db.query(table, orderBy: sortColumn);
  }

  Future<Map<String, dynamic>> selectOneRow(
    final String primaryKeyName,
    final String primaryKeyValue,
    final String table
  ) async {
    final db = await instance.getDatabase();
    final result = await db.query(
      table,
      where: '$primaryKeyName = ?',
      whereArgs: [primaryKeyValue]
    );
    if (result.length == 1) {
      return result[0];
    } else {
      return null; // Unexpected
    }
  }

  Future<int> countAllRows(final String table) async {
    final db = await instance.getDatabase();
    return Sqflite.firstIntValue(
      await db.rawQuery('SELECT COUNT(*) FROM $table')
    );
  }

  Future<int> update(
    final Map<String, dynamic> row,
    final String primaryKeyName,
    final String table
  ) async {
    final db = await instance.getDatabase();
    final primaryKeyValue = row[primaryKeyName];
    return await db.update(
      table,
      row,
      where: '$primaryKeyName = ?', whereArgs: [primaryKeyValue]
    );
  }

  Future<int> delete(
    final String primaryKeyName,
    final String primaryKeyValue,
    final String table
  ) async {
    final db = await instance.getDatabase();
    return await db.delete(
      table,
      where: '$primaryKeyName = ?',
      whereArgs: [primaryKeyValue]
    );
  }
}