import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  DatabaseHelper._internal();

  static final DatabaseHelper instance =
      DatabaseHelper._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }

    _database = await _initDatabase();
    return _database!;
  }

   Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();

    final path = join(dbPath, 'book_swap.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(
    Database db,
    int version,
  ) async {
    await db.execute('''
      CREATE TABLE users (
        id TEXT PRIMARY KEY,
        name TEXT NOT NULL,
        email TEXT UNIQUE NOT NULL,
        password TEXT NOT NULL,
        avatar TEXT,
        bio TEXT,
        token TEXT,
        created_at TEXT DEFAULT CURRENT_TIMESTAMP
      )
    ''');

        await db.execute('''
      CREATE TABLE books (
        id TEXT PRIMARY KEY,
        title TEXT NOT NULL,
        author TEXT NOT NULL,
        genre TEXT,
        year INTEGER,
        pages INTEGER,
        synopsis TEXT,
        image_path TEXT,
        owner_id TEXT NOT NULL,
        owner_name TEXT,
        owner_avatar TEXT,
        status TEXT DEFAULT 'available',
        publisher TEXT,
        created_at TEXT DEFAULT CURRENT_TIMESTAMP,
        FOREIGN KEY (owner_id)
          REFERENCES users(id)
          ON DELETE CASCADE
      )
    ''');
  }

  Future<void> close() async {
    final db = await database;
    await db.close();
  }

  Future<void> resetDatabase() async {
    final dbPath = await getDatabasesPath();

    final path = join(dbPath, 'book_swap.db');

    await deleteDatabase(path);

    _database = null;
  }
}