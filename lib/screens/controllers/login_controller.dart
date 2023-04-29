import 'package:arch_box_control/exceptions/user_exception.dart';
import 'package:arch_box_control/screens/components/dialogs.dart';
import 'package:arch_box_control/screens/config/config_user_adm.dart';
import 'package:arch_box_control/services/user_service.dart';
import 'package:easy_localization/easy_localization.dart' as easy;
import 'package:fluent_ui/fluent_ui.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final UserService service = Get.put(UserService());

  void findUserAdm(BuildContext context) {
    service.findUsersByProfile('admin').then((value) => {
          if (value.isEmpty)
            {
              Navigator.push(context,
                  FluentPageRoute(builder: (context) => const ConfigUserAdm()))
            }
        });
  }

  // Verifica usuário e senha
  Future<void> login({required String email, required String password}) async {
    await service.findUserByEmail(email: email).then((user) async => {
          if (user == null)
            {
              throw NotFoundUserException(
                  easy.tr('email_not_registered', args: [email]))
            },
          if (user.password != password)
            {throw PasswordUserException(easy.tr('password_not_valid'))},
          await service.saveLoggedInUser(user: user)
        });
  }

  // Valida os dados informados no login
  Future<bool> validateData(
      {required BuildContext context,
      required String email,
      required String password}) async {
    if (email.isEmpty) {
      await showErrorDialog(
          context: context,
          title: 'E-mail',
          content: easy.tr('email_required'));
      return false;
    }
    if (password.isEmpty) {
      await showErrorDialog(
          context: context,
          title: easy.tr('password'),
          content: easy.tr('password_required'));
      return false;
    }

    return true;
  }

  // Rx<Locale?> selectedLang = const Locale('pt', 'BR').obs;
  //
  // Locale? changeLang(Locale? locale) {
  //   selectedLang.value = locale;
  //   return selectedLang.value;
  // }
}
