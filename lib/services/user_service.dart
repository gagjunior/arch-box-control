import 'package:arch_box_control/data/models/user_model.dart';
import 'package:arch_box_control/data/repositories/user_repository.dart';
import 'package:arch_box_control/exceptions/user_exception.dart';
import 'package:arch_box_control/screens/components/dialogs.dart';
import 'package:arch_box_control/screens/login.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';

class UserService extends GetxService {
  final UserRepository _userRepository = UserRepository();
  static final Box _boxUserInfo = Hive.box('userInfo');

  // Salva novo usuário na base de dados
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

  // Localiza usuários por perfil
  Future<List<UserModel>> findUsersByProfile(String profile) async =>
      await _userRepository.findUsersByProfile(profile);

  // Localiza usuário por e-mail
  Future<UserModel?> findUserByEmail({required String email}) async =>
      await _userRepository.findUserByEmail(email);

  // Salva localmente usuário logado no sistema
  Future<void> saveLoggedInUser({required UserModel user}) async {
    DateTime dateTime = DateTime.now();
    await _boxUserInfo.putAll({
      'loggedUser': {
        'email': user.email,
        'name': user.name,
        'loggedIn':
            DateFormat('dd/MM/yyyy HH:mm', Intl.withLocale('pt-BR', () => null))
                .format(dateTime)
      }
    });
  }

  static Map<String, dynamic> getLoggedUserInfo() {
    return _boxUserInfo.get('loggedUser');
  }

  Future<bool> isUserDataValid({
    required String name,
    required String email,
    required String password,
  }) async {
    if (name.isEmpty || name == '') {
      throw NameUserException('Nome do usuário não pode estar em branco!');
    }

    if (email.isEmpty || email == '') {
      throw EmailUserException('Email não pode estar em branco!');
    }

    if (password.isEmpty || password == '') {
      throw PasswordUserException('Senha não pode estar em branco!');
    }
    return true;
  }

  Future<void> saveUserAdm(
      {required BuildContext context,
      required String name,
      required String email,
      required String password}) async {
    const String profile = 'admin';
    try {
      await isUserDataValid(name: name, email: email, password: password)
          .then((value) => {
                if (value)
                  {
                    saveNewUser(
                            name: name,
                            email: email,
                            password: password,
                            profile: profile)
                        .then(
                      (value) => Navigator.push(
                        context,
                        FluentPageRoute(
                          builder: (context) => const Login(),
                        ),
                      ),
                    )
                        .catchError((error) {
                      showErrorDialog(
                          context: context,
                          title: 'Erro - Usuário',
                          content: error.toString());
                    })
                  }
              });
    } on NameUserException catch (e) {
      showErrorDialog(
          context: context,
          title: 'Erro - Nome Usuário',
          content: e.toString());
    } on EmailUserException catch (e) {
      showErrorDialog(
          context: context, title: 'Erro - Email', content: e.toString());
    } on PasswordUserException catch (e) {
      showErrorDialog(
          context: context, title: 'Erro - Senha', content: e.toString());
    }
  }
}
