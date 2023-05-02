import 'package:arch_box_control/screens/components/dialogs.dart';
import 'package:arch_box_control/screens/controllers/config_url_controller.dart';
import 'package:arch_box_control/screens/login.dart';
import 'package:arch_box_control/services/config_db_service.dart';
import 'package:easy_localization/easy_localization.dart' as easy;
import 'package:fluent_ui/fluent_ui.dart';
import 'package:get/get.dart';

// @override
// void initState() {
//   super.initState();
//   if (ConfigDbService.dbUrlFound()) {
//     _urlConnController.text = ConfigDbService.getDbUrl();
//   }
// }

class ConfigUrlDb extends StatelessWidget {
  const ConfigUrlDb({super.key});
  final SizedBox _vSpacer = const SizedBox(height: 20);

  @override
  Widget build(BuildContext context) {
    final ConfigUrlDbController controller = Get.put(ConfigUrlDbController());

    if (ConfigDbService.dbUrlFound()) {
      controller.urlConnController.text = ConfigDbService.getDbUrl();
    }

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
                  easy.tr('database_configuration'),
                  softWrap: true,
                  style: TextStyle(
                    color: Colors.blue.dark,
                    fontSize: 24,
                  ),
                ),
                _vSpacer,
                _subTitle(easy.tr('database_connection_url')),
                SelectableText.rich(
                  TextSpan(
                    text: easy.tr('db_config_ln_01'),
                    children: [
                      TextSpan(
                          text: 'ArchBoxControl ',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.blue.dark)),
                      TextSpan(text: easy.tr('db_config_ln_01a')),
                      TextSpan(
                        text: easy.tr('db_config_ln_01b'),
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
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
                      controller: controller.urlConnController,
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
                          String urlConn = controller.urlConnController.text;
                          if (urlConn.isEmpty || urlConn == '') {
                            showErrorDialog(
                                context: context,
                                title: 'Erro - URL de Conexão',
                                content:
                                    'A URL de conexão com a base de dados não pode estar em branco! Favor verificar.');
                          } else {
                            ConfigDbService.saveConnection(
                                controller.urlConnController.text);
                            Navigator.push(
                                context,
                                FluentPageRoute(
                                    builder: (context) => const Login()));
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
}
