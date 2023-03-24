import 'package:arch_box_control/exceptions/config_db_exception.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ConfigDbService {
  static const String _boxName = 'dbSettings';
  static const String _keyUrlConn = 'db_conn_url';
  static final Box _boxDbSettings = Hive.box(_boxName);

  static bool isUrlSaved() {
    var connectionUrl = _boxDbSettings.get(_keyUrlConn);
    return connectionUrl == null || connectionUrl == '' ? false : true;
  }

  static void saveConnection(String urlConn) {
    if (isUrlSaved()) {
      throw ConfigDbException('URL de conexão já existe!');
    }
    _boxDbSettings.put('db_conn_url', urlConn);
  }

  static String databaseConnectionUrl() {
    return isUrlSaved() ? _boxDbSettings.get(_keyUrlConn) : '';
  }
}
