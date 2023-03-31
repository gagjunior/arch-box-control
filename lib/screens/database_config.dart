import 'package:arch_box_control/data/models/user_model.dart';
import 'package:arch_box_control/data/repositories/user_repository.dart';
import 'package:arch_box_control/screens/login.dart';
import 'package:arch_box_control/services/db_config_service.dart';
import 'package:email_validator/email_validator.dart';
import 'package:fluent_ui/fluent_ui.dart';

class DataBaseConfig extends StatefulWidget {
  const DataBaseConfig({super.key});

  @override
  State<DataBaseConfig> createState() => _DataBaseConfigState();
}

class _DataBaseConfigState extends State<DataBaseConfig> {
  final SizedBox _vSpacer = const SizedBox(height: 20);
  final SizedBox _hSpacer = const SizedBox(width: 20);
  final TextEditingController _urlConnController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _urlDbEnable = true;
  bool _disableEditUrlDb = true;
  bool _disableSaveUrlDb = false;
  UserRepository userRepository = UserRepository();

  @override
  void initState() {
    super.initState();
    if (DbConfigService.dbUrlFound()) {
      _urlConnController.text = DbConfigService.getDbUrl();
      _urlDbEnable = false;
      _disableEditUrlDb = false;
      _disableSaveUrlDb = true;
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
                      autovalidateMode: AutovalidateMode.onUserInteraction,
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
                                debugPrint(
                                    'Url connection: ${_urlConnController.text}');
                                DbConfigService.saveConnection(
                                    _urlConnController.text);
                                setState(() {
                                  _urlConnController.text =
                                      DbConfigService.getDbUrl();
                                  _urlDbEnable = false;
                                  _disableEditUrlDb = false;
                                  _disableSaveUrlDb = true;
                                });
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
                                      DbConfigService.getDbUrl();
                                  _urlDbEnable = true;
                                  _disableSaveUrlDb = false;
                                  _disableEditUrlDb = true;
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
                    label: 'E-mail',
                    child: TextFormBox(
                      controller: _emailController,
                      placeholder: 'exemplo@gmail.com',
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (text) {
                        if (text == null || text.isEmpty) {
                          return 'O campo "e-mail" é obrigatório';
                        }
                        if (!EmailValidator.validate(text)) {
                          return 'E-mail digitado não é válido';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 600),
                  child: InfoLabel(
                    label: 'Senha',
                    child: TextFormBox(
                      controller: _passwordController,
                      obscureText: true,
                      obscuringCharacter: '◉',
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (text) {
                        if (text == null || text.isEmpty) {
                          return 'O campo "senha" é obrigatório';
                        }
                        if (text.length < 8 || text.length > 12) {
                          return 'A senha deve conter entre 8 e 12 caracteres';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                FilledButton(
                  style: ButtonStyle(
                    padding: ButtonState.all(const EdgeInsets.all(8)),
                  ),
                  onPressed: () {
                    UserModel user = UserModel('Admin', _emailController.text,
                        _passwordController.text);
                    userRepository.saveUser(user);
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
                          builder: (context) => const Login(),
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
}
