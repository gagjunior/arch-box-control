import 'package:arch_box_control/data/services/config_db_service.dart';
import 'package:arch_box_control/data/services/user_service.dart';
import 'package:arch_box_control/screens/config_user_adm.dart';
import 'package:arch_box_control/screens/login.dart';
import 'package:email_validator/email_validator.dart';
import 'package:fluent_ui/fluent_ui.dart';

class ConfigUrlDb extends StatefulWidget {
  const ConfigUrlDb({super.key});

  @override
  State<ConfigUrlDb> createState() => _ConfigUrlDbState();
}

class _ConfigUrlDbState extends State<ConfigUrlDb> {
  final SizedBox _vSpacer = const SizedBox(height: 20);
  final SizedBox _hSpacer = const SizedBox(width: 20);
  final TextEditingController _urlConnController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final UserService _userService = UserService();
  bool _urlDbEnable = true;
  bool _enableNameField = false;
  bool _enableEmailField = false;
  bool _enablePasswordField = false;
  bool _enableSaveUser = false;
  bool _disableEditUrlDb = true;
  bool _disableSaveUrlDb = false;

  @override
  void initState() {
    super.initState();
    if (ConfigDbService.dbUrlFound()) {
      _urlConnController.text = ConfigDbService.getDbUrl();
      _urlDbEnable = false;
      _disableEditUrlDb = false;
      _disableSaveUrlDb = true;
      _enableNameField = true;
      _enableEmailField = true;
      _enablePasswordField = true;
      _enableSaveUser = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage(
      content: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Configuração da Base de Dados',
                  softWrap: true,
                  style: TextStyle(
                    color: Colors.blue.dark,
                    fontSize: 24,
                  ),
                ),
                _vSpacer,
                _subTitle('Banco de Dados'),
                SelectableText.rich(
                  TextSpan(
                    text: 'O aplicativo ',
                    children: [
                      TextSpan(
                          text: 'ArchBoxControl ',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.blue.dark)),
                      const TextSpan(text: 'utiliza como base de dados o '),
                      const TextSpan(
                          text: 'MongoDb.',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      const TextSpan(
                          text: '\nVocê pode configurar um banco de dados '),
                      const TextSpan(
                        text: 'Local ',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const TextSpan(text: 'ou em nuvem com o '),
                      const TextSpan(
                        text: 'MongoDB Atlas. ',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const TextSpan(
                          text:
                              '\nPara isso, é só informar a URL de conexão no campo abaixo.'),
                    ],
                  ),
                ),
                _vSpacer,
                ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 600),
                  child: InfoLabel(
                    label: 'URL de conexão',
                    child: TextFormBox(
                      controller: _urlConnController,
                      enabled: _urlDbEnable,
                      autofocus: true,
                      placeholder: 'mongodb://localhost:27017',
                      autovalidateMode: AutovalidateMode.always,
                      validator: (text) {
                        if (text == null || text.isEmpty) {
                          return 'É obrigatório digitar a URL de conexão com o banco de dados';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: 500),
                  child: Row(
                    children: [
                      FilledButton(
                        style: ButtonStyle(
                          padding: ButtonState.all(const EdgeInsets.all(8)),
                        ),
                        onPressed: _disableSaveUrlDb
                            ? null
                            : () {
                                String urlConn = _urlConnController.text;
                                if (urlConn.isEmpty || urlConn == '') {
                                  showContentDialog(context);
                                } else {
                                  String urlconn = _urlConnController.text;
                                  String emailUserAdm = _emailController.text;
                                  ConfigDbService.saveConnection(urlconn, emailUserAdm);
                                  setState(() {
                                    _urlConnController.text =
                                        ConfigDbService.getDbUrl();
                                    _urlDbEnable = false;
                                    _disableEditUrlDb = false;
                                    _disableSaveUrlDb = true;
                                    _enableEmailField = true;
                                  _enableNameField = true;
                                  _enablePasswordField = true;
                                  _enableSaveUser = true;
                                  });
                                }
                              },
                        child: const Text('Salvar Conexão'),
                      ),
                      _hSpacer,
                      FilledButton(
                        style: ButtonStyle(
                          padding: ButtonState.all(const EdgeInsets.all(8)),
                        ),
                        onPressed: _disableEditUrlDb
                            ? null
                            : () {
                                setState(() {
                                  _urlConnController.text =
                                      ConfigDbService.getDbUrl();
                                  _urlDbEnable = true;
                                  _disableSaveUrlDb = false;
                                  _disableEditUrlDb = true;
                                  _enableEmailField = false;
                                  _enableNameField = false;
                                  _enablePasswordField = false;
                                  _enableSaveUser = false;
                                });
                              },
                        child: const Text('Editar Conexão'),
                      ),
                    ],
                  ),
                ),
                _vSpacer,
                const SelectableText(
                  'Caso seja necessário conectar com o MongoDB hospedado em outro serviço de nuvem, favor contactar o suporte.',
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
                      enabled: _enableNameField,
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
                      enabled: _enableEmailField,
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
                      enabled: _enablePasswordField,
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
                const SizedBox(height: 10),
                FilledButton(
                  style: ButtonStyle(
                    padding: ButtonState.all(const EdgeInsets.all(8)),
                  ),
                  onPressed: !_enableSaveUser ? null : () {
                    String name = _nameController.text;
                    String email = _emailController.text;
                    String password = _passwordController.text;
                    _userService.saveUser(
                        name: name, email: email, password: password);
                  },
                  child: const Text('Salvar Usuário'),
                ),
                _vSpacer,
                const SelectableText(
                    'Após o primeiro acesso você pode preencher o cadastro completo deste usuário'),
                _vSpacer,
                ConstrainedBox(
                  constraints: const BoxConstraints(minWidth: 500),
                  child: FilledButton(
                    style: ButtonStyle(
                      backgroundColor: ButtonState.all(Colors.teal),
                      padding: ButtonState.all(const EdgeInsets.all(8)),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        FluentPageRoute(
                          builder: (context) => const ConfigUserAdm(),
                        ),
                      );
                    },
                    child: const Text('Acessar Tela de Login'),
                  ),
                ),
                _vSpacer
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

  void showContentDialog(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (context) => ContentDialog(
        title: const Text('Erro - URL de Conexão'),
        content: const Text(
          'A URL de conexão com a base de dados não pode estar em branco! Favor verificar.',
        ),
        actions: [
          FilledButton(
            child: const Text('Voltar'),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
    setState(() {});
  }
}
