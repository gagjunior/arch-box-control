import 'package:arch_box_control/data/models/user_model.dart';
import 'package:arch_box_control/services/config_db_service.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:mongo_dart/mongo_dart.dart';

class UserRepository {
  final String _urlDb = ConfigDbService.getDbUrl();
  static const String _collectionName = 'users';

  Future<UserModel?> saveNewUser(UserModel user) async {
    debugPrint(_urlDb);
    Db db = await Db.create(_urlDb);

    await db.open();
    DbCollection usersCollection = db.collection(_collectionName);
    WriteResult result = await usersCollection.insertOne(user.toMap);
    await db.close();

    if (result.isSuccess) {
      Map<String, dynamic> savedUser = result.document as Map<String, dynamic>;
      return UserModel.toUser(savedUser);
    }

    return null;
  }

  Future<List<UserModel>> findUsersByProfile(String profile) async {
    Db db = await Db.create(_urlDb);
    List<UserModel> userList = [];

    await db.open();
    DbCollection usersCollection = db.collection(_collectionName);
    await usersCollection.find(where.eq('profile', profile)).forEach((user) {
      userList.add(UserModel.toUser(user));
    });
    await db.close();

    debugPrint(userList.length.toString());

    return userList;
  }
}
