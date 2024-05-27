import 'package:floor/floor.dart';
import 'package:navigation/core/entities/user.dart';

@dao
abstract class UserDao {
  @Query('SELECT * FROM User')
  Future<List<User>> getAllUsers();

  @Query('SELECT * FROM User WHERE id = :id')
  Future<User?> getUserById(int id);

  @Query('SELECT COUNT(*) FROM User')
  Future<int?> getUserCount();

  @Query('SELECT MAX(id) FROM User')
  Future<int?> getMaxId();

  @Query('SELECT * FROM User WHERE name = :username AND password = :pass')
  Future<User?> validateUser(String username, String pass);

  @insert
  Future<void> insertUser(User user);

  @update
  Future<void> updateUser(User user);

  @delete
  Future<void> deleteUser(User user);
}
