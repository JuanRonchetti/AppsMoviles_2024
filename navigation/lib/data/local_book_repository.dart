import 'package:navigation/core/entities/book.dart';
import 'package:navigation/data/book_dao.dart';
import 'package:navigation/data/book_repository.dart';
import 'package:navigation/main.dart';

class LocalBookRepository implements BookRepository {
  final BookDao _bookDao = database.bookDao;

  @override
  Future<Book?> getBookById(int id) {
    return _bookDao.findBookById(id);
  }

  @override
  Future<List<Book>> getBooks() {
    return _bookDao.findAllBooks();
  }
}
