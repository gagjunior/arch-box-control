import 'package:arch_box_control/exceptions/user_exception.dart';
import 'package:arch_box_control/screens/config/config_user_adm.dart';
import 'package:arch_box_control/screens/home.dart';
import 'package:arch_box_control/services/user_service.dart';
import 'package:email_validator/email_validator.dart';
import 'package:fluent_ui/fluent_ui.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final UserService _userService = UserService();

  @override
  void initState() {
    super.initState();
    _userService.findUsersByProfile('admin').then((value) => {
          if (value.isEmpty)
            {
              Navigator.push(context,
                  FluentPageRoute(builder: (context) => const ConfigUserAdm()))
            }
        });
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage.scrollable(
      children: [
        const SizedBox(height: 30),
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
                    controller: _emailController,
                    prefix: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Icon(FluentIcons.mail),
                    ),
                    placeholder: 'exemplo@gmail.com',
                    autovalidateMode: AutovalidateMode.always,
                    validator: (text) {
                      if (text == null || text.isEmpty) {
                        return 'O campo "E-mail" é obrigatório';
                      }
                      if (!EmailValidator.validate(text)) {
                        return 'E-mail digitado não é válido';
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
                  label: 'Senha',
                  isHeader: true,
                  child: PasswordBox(
                    revealMode: PasswordRevealMode.peekAlways,
                    controller: _passwordController,
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
                  String email = _emailController.text;
                  String password = _passwordController.text;

                  await _validateData(email: email, password: password)
                      .then((isValid) async {
                    if (isValid) {
                      try {
                        await _login(email: email, password: password)
                            .then((value) => {
                                  Navigator.push(
                                    context,
                                    FluentPageRoute(
                                      builder: (context) => const Home(),
                                    ),
                                  )
                                });
                      } on NotFoundUserException catch (e) {
                        _showErrorDialog(
                            title: 'Erro - E-mail', content: e.toString());
                      } on PasswordUserException catch (e) {
                        _showErrorDialog(
                            title: 'Erro - Senha', content: e.toString());
                      }
                    }
                  });
                },
              ),
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _login({required String email, required String password}) async {
    await _userService.findUserByEmail(email: email).then((user) async => {
          if (user == null)
            {
              throw NotFoundUserException(
                  'Usuário com o e-mail: $email não cadastrado')
            },
          if (user.password != password)
            {throw PasswordUserException('Senha incorreta!')},
          await _userService.saveLoggedInUser(user)
        });
  }

  Future<bool> _validateData(
      {required String email, required String password}) async {
    if (email.isEmpty) {
      await _showErrorDialog(
          title: 'Erro - E-mail', content: 'O campo e-mail é obrigatório');
      return false;
    }
    if (password.isEmpty) {
      await _showErrorDialog(
          title: 'Erro - Senha', content: 'O campo senha é obrigatório');
      return false;
    }

    return true;
  }

  Future<void> _showErrorDialog(
      {required String title, required String content}) async {
    await showDialog(
      context: context,
      builder: (context) => ContentDialog(
        title: Text(title),
        content: Text(content),
        actions: [
          FilledButton(
            child: const Text('Voltar'),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }
}
