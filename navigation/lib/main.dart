import 'package:flutter/material.dart';
import 'package:navigation/core/app_router.dart';
import 'package:navigation/core/database/app_database.dart';
//import 'package:navigation/data/fake_book_repository.dart';
// import 'package:navigation/data/fake_book_repository.dart';
// import 'package:navigation/core/entities/app_config.dart';

late AppDatabase database;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Inicializacion base de datos
  database = await $FloorAppDatabase.databaseBuilder('app_database.db').build();

  // final userDao = database.userDao;
  //final bookDao = database.bookDao;
  // final appConfigDao = database.appConfigDao;

  // // Precarga de datos
  // for (final user in listaDeUsers) {
  //   await userDao.insertUser(user);
  // }
  // for (final book in FakeBookRepository.listOfBooks) {
  //   await bookDao.insertBook(book);
  // }
  // await bookDao.insertBook(FakeBookRepository.listOfBooks[7]);
  // await appConfigDao.insertAppConfig(AppConfig(activeSesion: false, id: 1));

  // // Chequeo de datos
  // final localUsers = await userDao.getAllUsers();
  // final localBooks = await bookDao.findAllBooks();
  // final localAppConfig = await appConfigDao.getAppConfig();

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: appRouter,
      theme: ThemeData(colorSchemeSeed: Colors.blue),
    );
  }
}

// final List<User> listaDeUsers = [
//   User(name: "admin", password: "admin", id: 0),
//   User(name: "Juan", password: "123", id: 1),
//   User(name: "Martin", password: "password", id: 2),
// ];
