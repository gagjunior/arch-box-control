import 'package:arch_box_control/screens/login.dart';
import 'package:arch_box_control/services/config_db_service.dart';
import 'package:arch_box_control/screens/config_user_adm.dart';
import 'package:arch_box_control/services/user_service.dart';
import 'package:fluent_ui/fluent_ui.dart';

class ConfigUrlDb extends StatefulWidget {
  const ConfigUrlDb({super.key});

  @override
  State<ConfigUrlDb> createState() => _ConfigUrlDbState();
}

class _ConfigUrlDbState extends State<ConfigUrlDb> {
  final SizedBox _vSpacer = const SizedBox(height: 20);
  final TextEditingController _urlConnController = TextEditingController();

  final UserService _userService = UserService();

  @override
  void initState() {
    super.initState();
    if (ConfigDbService.dbUrlFound()) {
      _urlConnController.text = ConfigDbService.getDbUrl();
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
                _subTitle('URL de Conexão Banco de Dados'),
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
                _vSpacer,
                ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 500),
                  child: Row(
                    children: [
                      FilledButton(
                        style: ButtonStyle(
                          padding: ButtonState.all(const EdgeInsets.all(8)),
                        ),
                        onPressed: () async {
                          String urlConn = _urlConnController.text;
                          if (urlConn.isEmpty || urlConn == '') {
                            showContentDialog(context);
                          } else {
                            ConfigDbService.saveConnection(
                                _urlConnController.text);

                            await _userService
                                .findUsersByProfile('admin')
                                .then((value) {
                              if (value.isNotEmpty) {
                                Navigator.push(
                                  context,
                                  FluentPageRoute(
                                    builder: (context) => const Login(),
                                  ),
                                );
                              } else {
                                Navigator.push(
                                  context,
                                  FluentPageRoute(
                                    builder: (context) => const ConfigUserAdm(),
                                  ),
                                );
                              }
                            });
                          }
                        },
                        child: const Text('Salvar Conexão'),
                      ),
                    ],
                  ),
                ),
                _vSpacer,
                const SelectableText(
                  'Caso seja necessário conectar com o MongoDB hospedado em outro serviço de nuvem, \nfavor contactar o suporte.',
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
