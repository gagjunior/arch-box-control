import 'package:arch_box_control/data/models/user_model.dart';
import 'package:arch_box_control/data/repositories/user_repository.dart';
import 'package:arch_box_control/exceptions/user_adm_exception.dart';

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
    await _userRepository.findUserByEmail(email).then((user) => {
          if (user != null)
            {
              throw EmailUserException(
                  'Já existe um usuário cadastrado com o e-mail: ${user.email}')
            }
        });

    return await _userRepository.saveNewUser(user);
  }

  Future<List<UserModel>> findUsersByProfile(String profile) async =>
      await _userRepository.findUsersByProfile(profile);

  Future<UserModel?> findUserByEmail({required String email}) async =>
      await _userRepository.findUserByEmail(email);
}
