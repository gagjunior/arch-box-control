import 'package:arch_box_control/data/models/user_model.dart';
import 'package:arch_box_control/services/db_config_service.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:mongo_dart/mongo_dart.dart';

class UserRepository {
  final _urlDb = DbConfigService.getDbUrl();

  Future<UserModel?> saveUser(UserModel user) async {
    Db db = await Db.create(_urlDb);
    await db.open();
    debugPrint(db.databaseName);
    debugPrint(db.isConnected.toString());
    debugPrint(db.state.toString());
    debugPrint(db.getCollectionNames().toString());
    DbCollection usersCollection = db.collection('users');

    await usersCollection.insertOne(user.toMap);

    await db.close();
    return null;
  }
}
