import 'package:navigation/core/entities/book.dart';

abstract class BookRepository {
  Future<List<Book>> getBooks();
  Future<Book?> getBookById(int id);
}
