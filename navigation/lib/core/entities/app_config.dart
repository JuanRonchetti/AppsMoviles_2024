import 'package:floor/floor.dart';

@entity
class AppConfig {
  @PrimaryKey(autoGenerate: true)
  int id = 1;

  bool activeSesion = false;
  int? userId;

  AppConfig({required this.activeSesion, this.userId, required this.id});
}
