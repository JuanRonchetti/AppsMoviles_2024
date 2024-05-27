import 'package:navigation/core/entities/app_config.dart';
import 'package:navigation/data/app_config_dao.dart';
import 'package:navigation/main.dart';

class AppConfigRepository {
  final AppConfigDao _appConfigDao = database.appConfigDao;

  Future<AppConfig?> getAppConfig() {
    return _appConfigDao.getAppConfig();
  }

  Future<void> insertAppConfig(AppConfig appConfig) async {
    _appConfigDao.insertAppConfig(appConfig);
  }

  Future<void> updateAppConfig(AppConfig appConfig) async {
    _appConfigDao.updateAppConfig(appConfig);
  }

  // Future<int?> getUserId(AppConfig appConfig) async {
  //   appConfig = await _appConfigDao.getAppConfig();
  //   return appConfig.userId;
  // }
}
