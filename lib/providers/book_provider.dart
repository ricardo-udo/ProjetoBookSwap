import 'package:flutter/foundation.dart';
import 'package:book_swap/features/books/data/models/book.dart';
import 'package:book_swap/data/repositories/books_repository.dart';
import 'package:book_swap/core/services/book_service.dart';

class BookProvider extends ChangeNotifier {
  final BooksRepository _repository;

  BookProvider({required BooksRepository repository})
      : _repository = repository;

  List<Book> _books = [];

  List<Book> get books => List.unmodifiable(_books);

  Future<void> loadBooks() async {
    _books = await _repository.getAllBooks();

    if (_books.isEmpty) {
      for (final book in BookService.books) {
        await _repository.insertBook(book);
      }
      _books = await _repository.getAllBooks();
    }
    notifyListeners();
  }

  Future<void> addBook(Book book) async {
    await _repository.insertBook(book);
    await loadBooks();
  }

  Future<void> deleteBook(String id) async {
    await _repository.deleteBook(id);
    await loadBooks();
  }

  Future<void> updateBook(Book book) async {
    await _repository.updateBook(book);
    await loadBooks();
  }
}
