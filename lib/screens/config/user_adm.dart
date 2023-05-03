import 'package:arch_box_control/screens/components/general.dart';
import 'package:arch_box_control/screens/controllers/user_adm_controller.dart';
import 'package:arch_box_control/services/user_service.dart';
import 'package:arch_box_control/services/utils.dart';
import 'package:easy_localization/easy_localization.dart' as easy;
import 'package:email_validator/email_validator.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:get/get.dart';

class UserAdm extends StatelessWidget {
  const UserAdm({Key? key}) : super(key: key);
  final SizedBox _vSpacer = const SizedBox(height: 20);

  @override
  Widget build(BuildContext context) {
    final UserAdmController controller = Get.put(UserAdmController());
    final UserService userService = Get.put(UserService());
    return ScaffoldPage(
      content: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _vSpacer,
                Text(
                  easy.tr('database_configuration'),
                  softWrap: true,
                  style: TextStyle(
                    color: Colors.blue.dark,
                    fontSize: 24,
                  ),
                ),
                _vSpacer,
                subTitle(easy.tr('administrator_user').toTitleCase()),
                SelectableText.rich(
                  TextSpan(
                    text: easy.tr('user_adm_ln01a'),
                    children: [
                      TextSpan(
                          text: easy.tr('administrator_user'),
                          style: const TextStyle(fontWeight: FontWeight.w600)),
                      TextSpan(text: easy.tr('user_adm_ln01b')),
                      TextSpan(text: '\n${easy.tr("user_adm_ln2a")}')
                    ],
                  ),
                ),
                _vSpacer,
                ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 600),
                  child: InfoLabel(
                    label: easy.tr('full_name'),
                    child: TextFormBox(
                      controller: controller.nameController,
                      autovalidateMode: AutovalidateMode.always,
                      validator: (text) {
                        if (text == null || text.isEmpty) {
                          return easy.tr('field_required',
                              args: ['"${easy.tr('full_name')}"']);
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                _vSpacer,
                ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 600),
                  child: InfoLabel(
                    label: 'E-mail:',
                    child: TextFormBox(
                      controller: controller.emailController,
                      placeholder: 'exemplo@gmail.com',
                      autovalidateMode: AutovalidateMode.always,
                      validator: (text) {
                        if (text == null || text.isEmpty) {
                          return easy.tr('email_required');
                        }
                        if (!EmailValidator.validate(text)) {
                          return easy.tr('email_not_valid');
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 600),
                  child: InfoLabel(
                    label: easy.tr('password'),
                    child: TextFormBox(
                      controller: controller.passwordController,
                      obscureText: true,
                      obscuringCharacter: '◉',
                      autovalidateMode: AutovalidateMode.always,
                      validator: (text) {
                        if (text == null || text.isEmpty) {
                          return easy.tr('password_required');
                        }
                        if (text.length < 8 || text.length > 12) {
                          return easy.tr('password_validation');
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                _vSpacer,
                FilledButton(
                  style: ButtonStyle(
                    padding: ButtonState.all(const EdgeInsets.all(8)),
                  ),
                  onPressed: () async {
                    String name = controller.nameController.text;
                    String email = controller.emailController.text;
                    String password = controller.passwordController.text;
                    await userService.saveUserAdm(
                        context: context,
                        name: name,
                        email: email,
                        password: password);
                  },
                  child: Text(easy.tr('save_param',
                      args: ['${easy.tr(easy.plural('user', 0))}'])),
                ),
                _vSpacer,
                SelectableText(
                  easy.tr('user_adm_lst'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
