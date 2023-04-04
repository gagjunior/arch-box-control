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
    UserModel user = UserModel(name, email, password,
        department: department, profile: profile);
    return await _userRepository.saveUser(user);
  }
}
