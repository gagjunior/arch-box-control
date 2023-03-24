import 'package:arch_box_control/services/config_db_service.dart';
import 'package:fluent_ui/fluent_ui.dart';

class DataBaseConfig extends StatefulWidget {
  const DataBaseConfig({super.key});

  @override
  State<DataBaseConfig> createState() => _DataBaseConfigState();
}

class _DataBaseConfigState extends State<DataBaseConfig> {
  final FontWeight _titleLabel = FontWeight.w600;
  final TextEditingController _urlConnControler = TextEditingController();

  @override
  void initState() {
    super.initState();
    _urlConnControler.text = ConfigDbService.databaseConnectionUrl();
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage(
      content: Center(
        heightFactor: 1.5,
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //const SizedBox(height: 20),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Configuração da Base de Dados',
                  softWrap: true,
                  style: TextStyle(
                    color: Colors.blue.dark,
                    fontSize: 24,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Flexible(
              flex: 2,
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 500),
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: InfoLabel(
                    label: 'Banco de Dados',
                    labelStyle: TextStyle(fontWeight: _titleLabel),
                    child: SelectableText.rich(
                      TextSpan(
                          text: 'O aplicativo ',
                          style: DefaultTextStyle.of(context).style,
                          children: [
                            TextSpan(
                                text: 'ArchBoxControl ',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue.dark)),
                            TextSpan(
                                text: 'utiliza como base de dados o ',
                                style: DefaultTextStyle.of(context).style),
                            const TextSpan(
                                text: 'MongoDb.',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            TextSpan(
                                text:
                                    '\n\nVocê pode configurar um banco de dados ',
                                style: DefaultTextStyle.of(context).style),
                            const TextSpan(
                                text: 'Local ',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            TextSpan(
                                text: 'ou em nuvem com o ',
                                style: DefaultTextStyle.of(context).style),
                            const TextSpan(
                                text: 'MongoDB Atlas. ',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            TextSpan(
                                text:
                                    '\n\nPara isso, é só informar a URL de conexão no campo abaixo.',
                                style: DefaultTextStyle.of(context).style),
                          ]),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Flexible(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 500),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InfoLabel(
                    label: 'URL de Conexão com a Base de Dados',
                    labelStyle: TextStyle(fontWeight: _titleLabel),
                    child: TextBox(
                      controller: _urlConnControler,
                      placeholder: 'mongodb://localhost:27017',
                      autofocus: true,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: FilledButton(
                child: const Text('Salvar Conexão'),
                onPressed: () {
                  debugPrint('Url connection: ${_urlConnControler.text}');
                  ConfigDbService.saveConnection(_urlConnControler.text);
                },
              ),
            ),
            const SizedBox(height: 20),
            Flexible(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 500),
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: SelectableText(
                      'Caso seja necessário configurar o aplicativo para conectar com o MongoDB hospedado em outro serviço de nuvem, favor contactar o suporte'),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
