import 'package:arch_box_control/data/models/user_model.dart';
import 'package:arch_box_control/data/repositories/user_repository.dart';

class UserService {
  final UserRepository _userRepository = UserRepository();

  Future<UserModel?> saveUser({
    required String name,
    required String email,
    required String password,
    String? department,
    String? profile,
  }) async {
    return await _userRepository.saveUser(_toUserModel(
      name: name,
      email: email,
      password: password,
      department: department,
      profile: profile,
    ));
  }

  UserModel _toUserModel({
    required String name,
    required String email,
    required String password,
    String? department = '',
    String? profile = '',
  }) {
    UserModel userModel = UserModel(name, email, password);
    userModel.setDepartment = department ?? '';
    userModel.setProfile = profile ?? '';
    return userModel;
  }
}
