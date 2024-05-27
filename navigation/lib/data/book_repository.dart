import 'package:navigation/core/entities/book.dart';

abstract class BookRepository {
  Future<List<Book>> getBooks();
  Future<Book?> getBookById(int id);
  Future<int> getBookCount();
  Future<int> getNewId();

  Future<void> insertBook(Book book);
  Future<void> updateBook(Book book);
  Future<void> deleteBook(Book book);
}
