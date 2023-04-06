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
  final SizedBox _hSpacer = const SizedBox(width: 20);

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  bool _enableNameField = false;
  bool _enableEmailField = false;
  bool _enablePasswordField = false;
  bool _enableSaveUser = false;

  final UserService _userService = UserService();

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage(
      content: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(8),
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
                  onPressed: () {
                    String name = _nameController.text;
                    String email = _emailController.text;
                    String password = _passwordController.text;
                    const String profile = 'admin';
                    _userService.saveNewUser(
                        name: name,
                        email: email,
                        password: password,
                        profile: profile);
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
}
