import 'package:floor/floor.dart';
import 'package:navigation/core/entities/book.dart';

@dao
abstract class BookDao {
  @Query('SELECT * FROM Book')
  Future<List<Book>> findAllBooks();

  @Query('SELECT * FROM Book WHERE id = :id')
  Future<Book?> findBookById(int id);

  @Query('SELECT COUNT(*) FROM Book')
  Future<int?> getBookCount();

  @Query('SELECT MAX(id) FROM Book')
  Future<int?> getMaxId();

  @insert
  Future<void> insertBook(Book book);

  @update
  Future<void> updateBook(Book book);

  @delete
  Future<void> deleteBook(Book book);

  // @Query('DELETE FROM User WHERE id = :id')
  // Future<Book?> deleteBook(int id);
}
