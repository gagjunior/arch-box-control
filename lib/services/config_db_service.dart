import 'package:hive_flutter/hive_flutter.dart';

class ConfigDbService {
  static const String _boxName = 'dbSettings';
  static const String _keyDbUrl = 'dbUrl';
  static const String _keyUserAdm = 'userAdm';
  static final Box _boxDbSettings = Hive.box(_boxName);

  static bool dbUrlFound() {
    var connectionUrl = _boxDbSettings.get(_keyDbUrl);
    return connectionUrl == null || connectionUrl == '' ? false : true;
  }

  static bool userAdmFound() {
    var userAdm = _boxDbSettings.get(_keyUserAdm);
    return userAdm == null || userAdm == '' ? false : true;
  }

  static void saveConnection(String urlConn) async =>
      await _boxDbSettings.put(_keyDbUrl, '$urlConn/archBoxControl');

  static String getDbUrl() => dbUrlFound() ? _boxDbSettings.get(_keyDbUrl) : '';
}
