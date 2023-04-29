import 'package:arch_box_control/exceptions/user_exception.dart';
import 'package:arch_box_control/screens/components/dialogs.dart';
import 'package:arch_box_control/screens/controllers/login_controller.dart';
import 'package:arch_box_control/screens/home.dart';
import 'package:easy_localization/easy_localization.dart' as easy;
import 'package:fluent_ui/fluent_ui.dart';
import 'package:get/get.dart';

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final LoginController controller = Get.put(LoginController());

    controller.findUserAdm(context);

    return ScaffoldPage.scrollable(
      children: [
        const SizedBox(height: 40),
        const FlutterLogo(
          size: 100,
        ),
        const SizedBox(height: 30),
        const Center(
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'Login',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        const SizedBox(height: 30),
        Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 400),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: InfoLabel(
                  label: 'E-mail',
                  isHeader: true,
                  child: TextFormBox(
                    controller: controller.emailController,
                    prefix: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Icon(FluentIcons.mail),
                    ),
                    placeholder: 'exemplo@gmail.com',
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (text) {
                      if (text == null || text.isEmpty) {
                        return easy.tr('email_required');
                      }
                      if (!GetUtils.isEmail(text)) {
                        return easy.tr('email_not_valid');
                      }
                      return null;
                    },
                  )),
            ),
          ),
        ),
        const SizedBox(height: 20),
        Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 400),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: InfoLabel(
                  label: easy.tr('password'),
                  isHeader: true,
                  child: PasswordBox(
                    revealMode: PasswordRevealMode.peekAlways,
                    controller: controller.passwordController,
                    obscuringCharacter: '◉',
                    leadingIcon: const Padding(
                      padding: EdgeInsets.all(8),
                      child: Icon(FluentIcons.password_field),
                    ),
                  )),
            ),
          ),
        ),
        const SizedBox(height: 20),
        Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 350),
            child: SizedBox(
              width: double.infinity,
              child: FilledButton(
                style: ButtonStyle(
                  padding:
                      ButtonState.all(const EdgeInsets.fromLTRB(0, 10, 0, 10)),
                ),
                child: const Text(
                  'Login',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                onPressed: () async {
                  String email = controller.emailController.text;
                  String password = controller.passwordController.text;

                  await controller
                      .validateData(
                          context: context, email: email, password: password)
                      .then((isValid) async {
                    if (isValid) {
                      try {
                        await controller
                            .login(email: email, password: password)
                            .then((value) => {
                                  Navigator.push(
                                    context,
                                    FluentPageRoute(
                                      builder: (context) => const Home(),
                                    ),
                                  )
                                });
                      } on NotFoundUserException catch (e) {
                        showErrorDialog(
                            context: context,
                            title: 'E-mail',
                            content: e.toString());
                      } on PasswordUserException catch (e) {
                        showErrorDialog(
                            context: context,
                            title: easy.tr('password'),
                            content: e.toString());
                      }
                    }
                  });
                },
              ),
            ),
          ),
        ),
        const SizedBox(height: 50),
        Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 400),
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: InfoLabel(
                label: easy.tr('language'),
                child: Obx(
                  () => ComboBox<Locale>(
                    isExpanded: true,
                    value: context.locale.obs.value,
                    items:
                        context.supportedLocales.map<ComboBoxItem<Locale>>((e) {
                      return ComboBoxItem<Locale>(
                        value: e,
                        child: Text(easy.tr(e.toString())),
                      );
                    }).toList(),
                    onChanged: (lang) {
                      context.setLocale(lang!);
                    },
                    placeholder: Text(easy.tr(context.locale.toString())),
                  ),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
