import 'package:floor/floor.dart';
import 'package:navigation/core/entities/app_config.dart';

@dao
abstract class AppConfigDao {
  @Query('SELECT * FROM AppConfig')
  Future<AppConfig?> getAppConfig();

  @insert
  Future<void> insertAppConfig(AppConfig appConfig);

  @update
  Future<void> updateAppConfig(AppConfig appConfig);
}
