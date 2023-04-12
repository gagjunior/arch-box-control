import 'package:arch_box_control/data/models/user_model.dart';
import 'package:arch_box_control/services/config_db_service.dart';
import 'package:mongo_dart/mongo_dart.dart';

class UserRepository {
  static final String _urlDb = ConfigDbService.getDbUrl();
  static const String _collectionName = 'users';

  Future<UserModel?> saveNewUser(UserModel user) async {
    Db db = await Db.create(_urlDb);

    await db.open();
    WriteResult result =
        await db.collection(_collectionName).insertOne(user.toMap);
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
    await db
        .collection(_collectionName)
        .find(where.eq('profile', profile))
        .forEach((user) {
      userList.add(UserModel.toUser(user));
    });
    await db.close();

    return userList;
  }

  Future<UserModel?> findUserByEmail(String email) async {
    Db db = await Db.create(_urlDb);
    await db.open();
    Map<String, dynamic>? userData =
        await db.collection(_collectionName).findOne(where.eq('email', email));
    await db.close();

    if (userData != null) {
      return UserModel.toUser(userData);
    }

    return null;
  }
}
