import 'package:floor/floor.dart';

@entity
class User {
  @PrimaryKey(autoGenerate: true)
  int id;

  final String name;
  final String password;

  User({required this.name, required this.password, required this.id});

  /// Retorna true si la contrasenia coincide
  bool verifyPassword(String pass) {
    if (pass == password) {
      return true;
    } else {
      return false;
    }
  }
}
