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

  @override
  Future<int> getBookCount() async {
    int? bookCount = await _bookDao.getBookCount();
    if (bookCount != null) {
      return bookCount;
    } else {
      return 1;
    }
  }

  @override
  Future<int> getNewId() async {
    int? maxId = await _bookDao.getMaxId();
    if (maxId != null) {
      return maxId + 1;
    } else {
      return 1;
    }
  }

  @override
  Future<void> insertBook(Book book) async {
    _bookDao.insertBook(book);
  }

  @override
  Future<void> updateBook(Book book) async {
    _bookDao.updateBook(book);
  }

  @override
  Future<void> deleteBook(Book book) async {
    _bookDao.deleteBook(book);
  }
}
