import 'package:hive_flutter/hive_flutter.dart';

class ConfigDbService {
  static final Box _boxDbSettings = Hive.box('dbSettings');

  static bool isUrlSaved() {
    var connectionUrl = _boxDbSettings.get('db_conn_url');

    if (connectionUrl == null || connectionUrl == '') {
      return false;
    }

    return true;
  }
}
