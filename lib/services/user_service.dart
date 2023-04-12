import 'package:arch_box_control/data/models/user_model.dart';
import 'package:arch_box_control/data/repositories/user_repository.dart';
import 'package:fluent_ui/fluent_ui.dart';

class UserService {
  final UserRepository _userRepository = UserRepository();

  Future<UserModel?> saveNewUser({
    required String name,
    required String email,
    required String password,
    String? department,
    String? profile,
  }) async {
    UserModel user = UserModel(name, email, password,
        department: department, profile: profile);
    UserModel? user2 = await _userRepository.findUserByEmail(email);
    debugPrint(user2?.toMap.toString());
    return await _userRepository.saveNewUser(user);
  }

  Future<List<UserModel>> findUsersByProfile(String profile) async {
    return await _userRepository.findUsersByProfile(profile);
  }
}
