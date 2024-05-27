// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

abstract class $AppDatabaseBuilderContract {
  /// Adds migrations to the builder.
  $AppDatabaseBuilderContract addMigrations(List<Migration> migrations);

  /// Adds a database [Callback] to the builder.
  $AppDatabaseBuilderContract addCallback(Callback callback);

  /// Creates the database and initializes it.
  Future<AppDatabase> build();
}

// ignore: avoid_classes_with_only_static_members
class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static $AppDatabaseBuilderContract databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static $AppDatabaseBuilderContract inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder implements $AppDatabaseBuilderContract {
  _$AppDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  @override
  $AppDatabaseBuilderContract addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  @override
  $AppDatabaseBuilderContract addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  @override
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  BookDao? _bookDaoInstance;

  UserDao? _userDaoInstance;

  AppConfigDao? _appConfigDaoInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Book` (`id` INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, `name` TEXT NOT NULL, `author` TEXT NOT NULL, `year` TEXT NOT NULL, `description` TEXT NOT NULL, `coverURL` TEXT)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `User` (`id` INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, `name` TEXT NOT NULL, `password` TEXT NOT NULL)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `AppConfig` (`id` INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, `activeSesion` INTEGER NOT NULL, `userId` INTEGER)');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  BookDao get bookDao {
    return _bookDaoInstance ??= _$BookDao(database, changeListener);
  }

  @override
  UserDao get userDao {
    return _userDaoInstance ??= _$UserDao(database, changeListener);
  }

  @override
  AppConfigDao get appConfigDao {
    return _appConfigDaoInstance ??= _$AppConfigDao(database, changeListener);
  }
}

class _$BookDao extends BookDao {
  _$BookDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _bookInsertionAdapter = InsertionAdapter(
            database,
            'Book',
            (Book item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'author': item.author,
                  'year': item.year,
                  'description': item.description,
                  'coverURL': item.coverURL
                }),
        _bookUpdateAdapter = UpdateAdapter(
            database,
            'Book',
            ['id'],
            (Book item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'author': item.author,
                  'year': item.year,
                  'description': item.description,
                  'coverURL': item.coverURL
                }),
        _bookDeletionAdapter = DeletionAdapter(
            database,
            'Book',
            ['id'],
            (Book item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'author': item.author,
                  'year': item.year,
                  'description': item.description,
                  'coverURL': item.coverURL
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Book> _bookInsertionAdapter;

  final UpdateAdapter<Book> _bookUpdateAdapter;

  final DeletionAdapter<Book> _bookDeletionAdapter;

  @override
  Future<List<Book>> findAllBooks() async {
    return _queryAdapter.queryList('SELECT * FROM Book',
        mapper: (Map<String, Object?> row) => Book(
            name: row['name'] as String,
            author: row['author'] as String,
            year: row['year'] as String,
            description: row['description'] as String,
            coverURL: row['coverURL'] as String?,
            id: row['id'] as int));
  }

  @override
  Future<Book?> findBookById(int id) async {
    return _queryAdapter.query('SELECT * FROM Book WHERE id = ?1',
        mapper: (Map<String, Object?> row) => Book(
            name: row['name'] as String,
            author: row['author'] as String,
            year: row['year'] as String,
            description: row['description'] as String,
            coverURL: row['coverURL'] as String?,
            id: row['id'] as int),
        arguments: [id]);
  }

  @override
  Future<int?> getBookCount() async {
    return _queryAdapter.query('SELECT COUNT(*) FROM Book',
        mapper: (Map<String, Object?> row) => row.values.first as int);
  }

  @override
  Future<int?> getMaxId() async {
    return _queryAdapter.query('SELECT MAX(id) FROM Book',
        mapper: (Map<String, Object?> row) => row.values.first as int);
  }

  @override
  Future<void> insertBook(Book book) async {
    await _bookInsertionAdapter.insert(book, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateBook(Book book) async {
    await _bookUpdateAdapter.update(book, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteBook(Book book) async {
    await _bookDeletionAdapter.delete(book);
  }
}

class _$UserDao extends UserDao {
  _$UserDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _userInsertionAdapter = InsertionAdapter(
            database,
            'User',
            (User item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'password': item.password
                }),
        _userUpdateAdapter = UpdateAdapter(
            database,
            'User',
            ['id'],
            (User item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'password': item.password
                }),
        _userDeletionAdapter = DeletionAdapter(
            database,
            'User',
            ['id'],
            (User item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'password': item.password
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<User> _userInsertionAdapter;

  final UpdateAdapter<User> _userUpdateAdapter;

  final DeletionAdapter<User> _userDeletionAdapter;

  @override
  Future<List<User>> getAllUsers() async {
    return _queryAdapter.queryList('SELECT * FROM User',
        mapper: (Map<String, Object?> row) => User(
            name: row['name'] as String,
            password: row['password'] as String,
            id: row['id'] as int));
  }

  @override
  Future<User?> getUserById(int id) async {
    return _queryAdapter.query('SELECT * FROM User WHERE id = ?1',
        mapper: (Map<String, Object?> row) => User(
            name: row['name'] as String,
            password: row['password'] as String,
            id: row['id'] as int),
        arguments: [id]);
  }

  @override
  Future<int?> getUserCount() async {
    return _queryAdapter.query('SELECT COUNT(*) FROM User',
        mapper: (Map<String, Object?> row) => row.values.first as int);
  }

  @override
  Future<int?> getMaxId() async {
    return _queryAdapter.query('SELECT MAX(id) FROM User',
        mapper: (Map<String, Object?> row) => row.values.first as int);
  }

  @override
  Future<User?> validateUser(
    String username,
    String pass,
  ) async {
    return _queryAdapter.query(
        'SELECT * FROM User WHERE name = ?1 AND password = ?2',
        mapper: (Map<String, Object?> row) => User(
            name: row['name'] as String,
            password: row['password'] as String,
            id: row['id'] as int),
        arguments: [username, pass]);
  }

  @override
  Future<void> insertUser(User user) async {
    await _userInsertionAdapter.insert(user, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateUser(User user) async {
    await _userUpdateAdapter.update(user, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteUser(User user) async {
    await _userDeletionAdapter.delete(user);
  }
}

class _$AppConfigDao extends AppConfigDao {
  _$AppConfigDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _appConfigInsertionAdapter = InsertionAdapter(
            database,
            'AppConfig',
            (AppConfig item) => <String, Object?>{
                  'id': item.id,
                  'activeSesion': item.activeSesion ? 1 : 0,
                  'userId': item.userId
                }),
        _appConfigUpdateAdapter = UpdateAdapter(
            database,
            'AppConfig',
            ['id'],
            (AppConfig item) => <String, Object?>{
                  'id': item.id,
                  'activeSesion': item.activeSesion ? 1 : 0,
                  'userId': item.userId
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<AppConfig> _appConfigInsertionAdapter;

  final UpdateAdapter<AppConfig> _appConfigUpdateAdapter;

  @override
  Future<AppConfig?> getAppConfig() async {
    return _queryAdapter.query('SELECT * FROM AppConfig',
        mapper: (Map<String, Object?> row) => AppConfig(
            activeSesion: (row['activeSesion'] as int) != 0,
            userId: row['userId'] as int?,
            id: row['id'] as int));
  }

  @override
  Future<void> insertAppConfig(AppConfig appConfig) async {
    await _appConfigInsertionAdapter.insert(
        appConfig, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateAppConfig(AppConfig appConfig) async {
    await _appConfigUpdateAdapter.update(appConfig, OnConflictStrategy.abort);
  }
}
