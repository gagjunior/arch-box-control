import 'package:arch_box_control/data/models/user_model.dart';
import 'package:arch_box_control/data/services/config_db_service.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:mongo_dart/mongo_dart.dart';

class UserRepository {
  final _urlDb = ConfigDbService.getDbUrl();

  Future<UserModel?> saveUser(UserModel user) async {
    Db db = await Db.create(_urlDb);
    debugPrint(_urlDb);
    await db.open();

    DbCollection usersCollection = db.collection('users');

    await usersCollection.insertOne(user.toMap);

    await db.close();
    return null;
  }
}
