import 'package:book_swap/core/database/database_helper.dart';
import 'package:book_swap/features/books/data/models/book.dart';

class BooksRepository {
  final DatabaseHelper _db =
      DatabaseHelper.instance;

  Future<void> insertBook(Book book) async {
    final db = await _db.database;

    await db.insert(
      'books',
      book.toMap(),
    );
  }

  Future<List<Book>> getAllBooks() async {
    final db = await _db.database;

    final List<Map<String, dynamic>> maps =
        await db.query('books');

    return maps
        .map((map) => Book.fromMap(map))
        .toList();
  }

  Future<Book?> getBookById(String id) async {
    final db = await _db.database;

    final result = await db.query(
      'books',
      where: 'id = ?',
      whereArgs: [id],
    );

    if (result.isNotEmpty) {
      return Book.fromMap(result.first);
    }

    return null;
  }

  Future<void> updateBook(Book book) async {
    final db = await _db.database;

    await db.update(
      'books',
      book.toMap(),
      where: 'id = ?',
      whereArgs: [book.id],
    );
  }

  Future<void> deleteBook(String id) async {
    final db = await _db.database;

    await db.delete(
      'books',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}