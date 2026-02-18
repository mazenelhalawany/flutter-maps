import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SqlDb {
  static final SqlDb instance = SqlDb._internal();
  static Database? _database;

  SqlDb._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  /// اسم الداتابيز + version
  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, "app_database.db");

    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );
  }

  /// هنا بتحط الجداول بتاعتك
  Future<void> _onCreate(Database db, int version) async {
    // مثال: جدول الأماكن
    await db.execute('''
      CREATE TABLE places (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        displayName TEXT NOT NULL,
        lat REAL NOT NULL,
        lon REAL NOT NULL
      )
    ''');
    print("Created database ----------------");
  }

  /// لو غيرت في ال database version بعدين
  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    // هنا بتحط migration logic
  }

  // =============================
  // CRUD Methods (Reusable)
  // =============================

  Future<int> insert(String table, Map<String, dynamic> data) async {
    final db = await database;
    return await db.insert(
      table,
      data,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Map<String, dynamic>>> getAll(String table) async {
    final db = await database;
    return await db.query(table);
  }

  Future<List<Map<String, dynamic>>> getWhere(
    String table, {
    required String where,
    required List<dynamic> whereArgs,
  }) async {
    final db = await database;
    return await db.query(table, where: where, whereArgs: whereArgs);
  }

  Future<int> update(
    String table,
    Map<String, dynamic> data, {
    required String where,
    required List<dynamic> whereArgs,
  }) async {
    final db = await database;
    return await db.update(table, data, where: where, whereArgs: whereArgs);
  }

  Future<int> delete(
    String table, {
    required String where,
    required List<dynamic> whereArgs,
  }) async {
    final db = await database;
    return await db.delete(table, where: where, whereArgs: whereArgs);
  }

  Future<int> deleteAll(String table) async {
    final db = await database;
    return await db.delete(table);
  }

  Future<void> close() async {
    final db = await database;
    await db.close();
  }
}
