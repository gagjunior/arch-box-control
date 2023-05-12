import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ConfigDbService extends GetxService {
  static const String _boxName = 'dbSettings';
  static const String _keyDbUrl = 'dbUrl';
  static final Box _boxDbSettings = Hive.box(_boxName);

  static bool dbUrlFound() {
    var connectionUrl = _boxDbSettings.get(_keyDbUrl);
    return connectionUrl == null || connectionUrl == '' ? false : true;
  }

  static void saveConnection(String urlConn) async {
    await _boxDbSettings.put(_keyDbUrl, '$urlConn/archBoxControl');
  }

  static String getDbUrl() => dbUrlFound() ? _boxDbSettings.get(_keyDbUrl) : '';
}
