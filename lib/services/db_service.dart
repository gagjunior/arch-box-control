import 'package:hive_flutter/hive_flutter.dart';
import 'package:mongo_dart/mongo_dart.dart' as mongodb;

class ConfigDbService {
  static const String _boxName = 'dbSettings';
  static const String _keyDbUrl = 'dbUrl';
  static final Box _boxDbSettings = Hive.box(_boxName);

  static bool dbUrlFound() {
    var connectionUrl = _boxDbSettings.get(_keyDbUrl);
    return connectionUrl == null || connectionUrl == '' ? false : true;
  }

  static void saveConnection(String urlConn) async {
    // if (dbUrlFound()) {
    //   throw ConfigDbException('URL de conexão já existe!');
    // }
    await _boxDbSettings.put(_keyDbUrl, urlConn);
  }

  static String dbConnUrl() {
    return dbUrlFound() ? _boxDbSettings.get(_keyDbUrl) : null;
  }

  static Future<mongodb.Db> db() async {
    return await mongodb.Db.create(dbConnUrl());
  }
}
