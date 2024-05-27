import 'package:navigation/core/entities/user.dart';
import 'package:navigation/data/user_dao.dart';
import 'package:navigation/main.dart';

class LocalUserRepository {
  final UserDao _userDao = database.userDao;

  Future<User?> getUserById(int id) {
    return _userDao.getUserById(id);
  }

  Future<List<User>> getUsers() {
    return _userDao.getAllUsers();
  }

  Future<int> getUserCount() async {
    int? userCount = await _userDao.getUserCount();
    if (userCount != null) {
      return userCount;
    } else {
      return 1;
    }
  }

  Future<int> getNewId() async {
    int? maxId = await _userDao.getMaxId();
    if (maxId != null) {
      return maxId + 1;
    } else {
      return 1;
    }
  }

  Future<User?> validateUser(String name, String password) async {
    return _userDao.validateUser(name, password);
  }

  Future<void> insertUser(User user) async {
    _userDao.insertUser(user);
  }

  Future<void> updateUser(User user) async {
    _userDao.updateUser(user);
  }

  Future<void> deleteUser(User user) async {
    _userDao.deleteUser(user);
  }
}
