import 'dart:async';
import 'package:floor/floor.dart';
import 'package:navigation/core/entities/app_config.dart';
import 'package:navigation/core/entities/user.dart';
import 'package:navigation/data/app_config_dao.dart';
import 'package:navigation/data/user_dao.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
import 'package:navigation/data/book_dao.dart';
import 'package:navigation/core/entities/book.dart';

part 'app_database.g.dart'; // the generated code will be there

@Database(version: 1, entities: [Book, User, AppConfig])
abstract class AppDatabase extends FloorDatabase {
  BookDao get bookDao;
  UserDao get userDao;
  AppConfigDao get appConfigDao;
}
