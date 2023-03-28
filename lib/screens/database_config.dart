import 'package:arch_box_control/screens/login.dart';
import 'package:arch_box_control/services/db_config_service.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:email_validator/email_validator.dart';

class DataBaseConfig extends StatefulWidget {
  const DataBaseConfig({super.key});

  @override
  State<DataBaseConfig> createState() => _DataBaseConfigState();
}

class _DataBaseConfigState extends State<DataBaseConfig> {
  final double _fontSizeTitleLabel = 16;
  final FontStyle _fontStyleTitleLabel = FontStyle.italic;
  final FontWeight _fontWeightTitleLabel = FontWeight.w600;
  final SizedBox _heightSpacer = const SizedBox(height: 20);
  final TextEditingController _urlConnController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _urlConnController.text = DbConfigService.getDbUrl();
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage.scrollable(
      children: [
        Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 40),
              Text(
                'Configuração da Base de Dados',
                softWrap: true,
                style: TextStyle(
                  color: Colors.blue.dark,
                  fontSize: 24,
                ),
              ),
              _heightSpacer,
              InfoLabel(
                label: 'Banco de Dados',
                labelStyle: TextStyle(
                  fontWeight: _fontWeightTitleLabel,
                  fontSize: _fontSizeTitleLabel,
                  fontStyle: _fontStyleTitleLabel,
                ),
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
                            text: '\n\nVocê pode configurar um banco de dados ',
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
              _heightSpacer,
              InfoLabel(
                label: 'URL de Conexão com a Base de Dados',
                labelStyle: TextStyle(color: Colors.blue.light),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 600),
                  child: TextBox(
                    controller: _urlConnController,
                    placeholder: 'mongodb://localhost:27017',
                    autofocus: true,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 300),
                child: Row(
                  children: [
                    FilledButton(
                      child: const Padding(
                        padding: EdgeInsets.all(6.0),
                        child: Text('Salvar Conexão'),
                      ),
                      onPressed: () {
                        debugPrint('Url connection: ${_urlConnController.text}');
                        DbConfigService.saveConnection(_urlConnController.text);
                        Navigator.push(
                          context,
                          FluentPageRoute(
                            builder: (context) => const Login(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
              _heightSpacer,
              const SelectableText(
                'Caso seja necessário configurar o aplicativo para conectar com o MongoDB hospedado em outro serviço de nuvem, favor contactar o suporte',
              ),
              _heightSpacer,
              InfoLabel(
                label: 'Usuário Administrador',
                labelStyle: TextStyle(
                    fontWeight: _fontWeightTitleLabel,
                    fontSize: _fontSizeTitleLabel,
                    fontStyle: _fontStyleTitleLabel),
              ),
              SelectableText.rich(
                TextSpan(
                    text: 'É obrigatório cadastrar um ',
                    style: DefaultTextStyle.of(context).style,
                    children: [
                      TextSpan(
                          text: 'usuário administrador ',
                          style: TextStyle(fontWeight: FontWeight.w600)),
                      TextSpan(
                          text: 'para o primeiro acesso ao aplicativo.',
                          style: DefaultTextStyle.of(context).style),
                      TextSpan(
                          text:
                              '\n\nVocê pode realizar o cadastro preenchendo os campos abaixo.')
                    ]),
              ),
              _heightSpacer,
              InfoLabel(
                label: 'E-mail',
                labelStyle: TextStyle(color: Colors.blue.light),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 600),
                  child: TextFormBox(
                    controller: _emailController,
                    placeholder: 'exemplo@gmail.com',
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (text) {
                      if (text == null || text.isEmpty) {
                        return 'Digite um e-mail';
                      }
                      if (!EmailValidator.validate(text)) {
                        return 'E-mail não é válido';
                      }
                      return null;
                    },                                   
                  ),
                ),
              ),
              _heightSpacer,
              InfoLabel(
                label: 'Senha',
                labelStyle: TextStyle(color: Colors.blue.light),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 600),
                  child: TextFormBox(
                    controller: _emailController,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (text) {
                      if (text == null || text.isEmpty) {
                        return 'Digite a senha';
                      }
                      if (text.length < 8 || text.length > 12) {
                        return 'A senha deve estar entre 8 e 12 caracteres';
                      }
                      return null;
                    },                                   
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
