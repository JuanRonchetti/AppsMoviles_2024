import 'package:flutter/material.dart';
import 'package:navigation/core/app_router.dart';
import 'package:navigation/core/database/book_database.dart';

late AppDatabase database;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Inicializacion base de datos
  database = await $FloorAppDatabase.databaseBuilder('app_database.db').build();
  // final bookDao = database.bookDao;

  // // Precarga de datos
  // final books = BookRepository().listOfBooks;
  // for (final book in books) {
  //   await bookDao.insertBook(book);
  // }

  // // Chequeo de datos
  // final localBooks = await bookDao.findAllBooks();

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: appRouter,
    );
  }
}
