import 'package:arch_box_control/screens/login.dart';
import 'package:arch_box_control/services/db_config_service.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';

class DataBaseConfig extends StatefulWidget {
  const DataBaseConfig({super.key});

  @override
  State<DataBaseConfig> createState() => _DataBaseConfigState();
}

class _DataBaseConfigState extends State<DataBaseConfig> {
  final SizedBox _vSpacer = const SizedBox(height: 20);
  final TextEditingController _urlConnController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _urlConnController.text = DbConfigService.getDbUrl();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 40),
                Text(
                  'Configuração da Base de Dados',
                  softWrap: true,
                  style: TextStyle(
                    color: Colors.blue[600],
                    fontSize: 24,
                  ),
                ),
                _vSpacer,
                _subTitle('Banco de Dados'),
                SelectableText.rich(
                  TextSpan(
                    text: '\nO aplicativo ',
                    children: [
                      TextSpan(
                          text: 'ArchBoxControl ',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.blue[600])),
                      const TextSpan(text: 'utiliza como base de dados o '),
                      const TextSpan(
                          text: 'MongoDb.',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      const TextSpan(
                          text: '\n\nVocê pode configurar um banco de dados '),
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
                              '\n\nPara isso, é só informar a URL de conexão no campo abaixo.'),
                    ],
                  ),
                ),
                _vSpacer,
                ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 600),
                  child: TextFormField(
                    controller: _urlConnController,
                    autofocus: true,
                    decoration: const InputDecoration(
                      labelText: 'URL de conexão',
                      hintText: 'mongodb://localhost:27017',
                    ),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (text) {
                      if (text == null || text.isEmpty) {
                        return 'É obrigatório digitar a URL de conexão com o banco de dados';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  style: ButtonStyle(
                      padding: MaterialStateProperty.all(EdgeInsets.all(10)),
                      backgroundColor:
                          MaterialStatePropertyAll(Colors.blue[600])),
                  child: const Padding(
                    padding: EdgeInsets.all(4.0),
                    child: Text('Salvar Conexão'),
                  ),
                  onPressed: () {
                    debugPrint('Url connection: ${_urlConnController.text}');
                    DbConfigService.saveConnection(_urlConnController.text);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Login(),
                      ),
                    );
                  },
                ),
                _vSpacer,
                const SelectableText(
                  'Caso seja necessário conectar com o MongoDB hospedado em outro serviço de nuvem, favor contactar o suporte.',
                ),
                _vSpacer,
                _subTitle('Usuário Administrador'),
                const SelectableText.rich(
                  TextSpan(
                    text: '\nÉ obrigatório cadastrar um ',
                    children: [
                      TextSpan(
                          text: 'usuário administrador ',
                          style: TextStyle(fontWeight: FontWeight.w600)),
                      TextSpan(text: 'para o primeiro acesso ao aplicativo.'),
                      TextSpan(
                          text:
                              '\n\nVocê pode realizar o cadastro preenchendo os campos abaixo:')
                    ],
                  ),
                ),
                _vSpacer,
                ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 600),
                  child: TextFormField(

                    controller: _emailController,
                    decoration: const InputDecoration(
                      labelText: 'E-mail',
                      hintText: 'exemplo@gmail.com',
                    ),
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
                ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 600),
                  child: TextFormField(
                    controller: _passwordController,
                    obscureText: true,
                    obscuringCharacter: '◉',
                    decoration: const InputDecoration(
                      labelText: 'Senha',
                    ),
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
                const SizedBox(height: 10,),
                ElevatedButton(
                  style: ButtonStyle(
                      padding: MaterialStateProperty.all(EdgeInsets.all(10)),
                      backgroundColor:
                          MaterialStatePropertyAll(Colors.blue[600])),
                  child: const Padding(
                    padding: EdgeInsets.all(4.0),
                    child: Text('Salvar Usuário'),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Login(),
                      ),
                    );
                  },
                ),
                _vSpacer,
                ElevatedButton(
                  
                  child: const Text('Salvar Usuário'),
                  
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Login(),
                      ),
                    );
                  },
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
