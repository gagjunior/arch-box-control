import 'package:arch_box_control/data/models/user_model.dart';
import 'package:arch_box_control/data/services/config_db_service.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:mongo_dart/mongo_dart.dart';

class UserRepository {
  final String _urlDb = ConfigDbService.getDbUrl();
  static const String _collectionName = 'users';

  Future<UserModel?> saveUser(UserModel user) async {
    Db db = await Db.create(_urlDb);
    await db.open();
    DbCollection usersCollection = db.collection(_collectionName);
    WriteResult result = await usersCollection.insertOne(user.toMap);
    debugPrint(result.toString());
    await db.close();
    return null;
  }

  Future<UserModel> findUsersByProfile(String profile) async {
    Db db = await Db.create(_urlDb);
    await db.open();
    DbCollection usersCollection = db.collection(_collectionName);
    await usersCollection.findOne()
  }
}
