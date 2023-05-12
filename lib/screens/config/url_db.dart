import 'package:arch_box_control/screens/components/dialogs.dart';
import 'package:arch_box_control/screens/components/general.dart';
import 'package:arch_box_control/screens/config/controllers/url_db_controller.dart';
import 'package:arch_box_control/screens/login/login.dart';
import 'package:arch_box_control/services/config_db_service.dart';
import 'package:easy_localization/easy_localization.dart' as easy;
import 'package:fluent_ui/fluent_ui.dart';
import 'package:get/get.dart';

class UrlDb extends StatelessWidget {
  const UrlDb({super.key});

  final SizedBox _vSpacer = const SizedBox(height: 20);

  @override
  Widget build(BuildContext context) {
    final UrlDbController controller = Get.put(UrlDbController());

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
                subTitle(easy.tr('database_connection_url')),
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
                      TextSpan(text: easy.tr('db_config_ln_02a')),
                      const TextSpan(
                        text: 'Local ',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextSpan(text: easy.tr('db_config_ln_02b')),
                      const TextSpan(
                        text: 'MongoDB Atlas. ',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextSpan(text: easy.tr('db_config_ln_03a')),
                    ],
                  ),
                ),
                _vSpacer,
                ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 600),
                  child: InfoLabel(
                    label: easy.tr('connection_url'),
                    child: TextFormBox(
                      controller: controller.urlConnController,
                      autofocus: true,
                      placeholder: 'mongodb://localhost:27017',
                      autovalidateMode: AutovalidateMode.always,
                      validator: (text) {
                        if (text == null || text.isEmpty) {
                          return easy.tr('mandatory_url');
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
                              title: easy.tr('connection_url'),
                              content: easy.tr('empty_connection_url'),
                            );
                          } else {
                            ConfigDbService.saveConnection(
                                controller.urlConnController.text);
                            Navigator.push(
                                context,
                                FluentPageRoute(
                                    builder: (context) => const Login()));
                          }
                        },
                        child: Text(easy.tr('save_conn')),
                      ),
                    ],
                  ),
                ),
                _vSpacer,
                SelectableText(easy.tr('db_config_ln_04a')),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
