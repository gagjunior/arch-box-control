import 'package:arch_box_control/exceptions/user_adm_exception.dart';
import 'package:arch_box_control/screens/login.dart';
import 'package:arch_box_control/services/user_service.dart';
import 'package:email_validator/email_validator.dart';
import 'package:fluent_ui/fluent_ui.dart';

class ConfigUserAdm extends StatefulWidget {
  const ConfigUserAdm({super.key});

  @override
  State<ConfigUserAdm> createState() => _ConfigUserAdmState();
}

class _ConfigUserAdmState extends State<ConfigUserAdm> {
  final SizedBox _vSpacer = const SizedBox(height: 20);

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  final UserService _userService = UserService();

  @override
  Widget build(BuildContext context) {
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
                  'Configuração da Base de Dados',
                  softWrap: true,
                  style: TextStyle(
                    color: Colors.blue.dark,
                    fontSize: 24,
                  ),
                ),
                _vSpacer,
                _subTitle('Usuário Administrador'),
                const SelectableText.rich(
                  TextSpan(
                    text: 'É obrigatório cadastrar um ',
                    children: [
                      TextSpan(
                          text: 'usuário administrador ',
                          style: TextStyle(fontWeight: FontWeight.w600)),
                      TextSpan(text: 'para o primeiro acesso ao aplicativo.'),
                      TextSpan(
                          text:
                              '\nVocê pode realizar o cadastro preenchendo os campos abaixo:')
                    ],
                  ),
                ),
                _vSpacer,
                ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 600),
                  child: InfoLabel(
                    label: 'Nome completo:',
                    child: TextFormBox(
                      controller: _nameController,
                      autovalidateMode: AutovalidateMode.always,
                      validator: (text) {
                        if (text == null || text.isEmpty) {
                          return 'O campo "Nome completo" é obrigatório';
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
                      controller: _emailController,
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
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 600),
                  child: InfoLabel(
                    label: 'Senha:',
                    child: TextFormBox(
                      controller: _passwordController,
                      obscureText: true,
                      obscuringCharacter: '◉',
                      autovalidateMode: AutovalidateMode.always,
                      validator: (text) {
                        if (text == null || text.isEmpty) {
                          return 'O campo "Senha" é obrigatório';
                        }
                        if (text.length < 8 || text.length > 12) {
                          return 'A senha deve conter entre 8 e 12 caracteres';
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
                    String name = _nameController.text;
                    String email = _emailController.text;
                    String password = _passwordController.text;
                    await _saveUserAdm(
                        name: name, email: email, password: password);
                  },
                  child: const Text('Salvar Usuário'),
                ),
                _vSpacer,
                const SelectableText(
                  'Após o primeiro acesso você pode preencher o cadastro completo deste usuário',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _subTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 16,
        fontStyle: FontStyle.italic,
      ),
    );
  }

  Future<bool> _isUserDataValid({
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

  Future<void> _saveUserAdm(
      {required String name,
      required String email,
      required String password}) async {
    const String profile = 'admin';
    try {
      await _isUserDataValid(name: name, email: email, password: password)
          .then((value) => {
                if (value)
                  {
                    _userService
                        .saveNewUser(
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
                      _showErrorDialog(
                          title: 'Erro - Usuário', content: error.toString());
                    })
                  }
              });
    } on NameUserException catch (e) {
      _showErrorDialog(title: 'Erro - Nome Usuário', content: e.toString());
    } on EmailUserException catch (e) {
      _showErrorDialog(title: 'Erro - Email', content: e.toString());
    } on PasswordUserException catch (e) {
      _showErrorDialog(title: 'Erro - Senha', content: e.toString());
    }
  }

  void _showErrorDialog(
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
