import 'package:arch_box_control/screens/components/general.dart';
import 'package:arch_box_control/screens/controllers/user_adm_controller.dart';
import 'package:arch_box_control/services/user_service.dart';
import 'package:email_validator/email_validator.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:get/get.dart';

class UserAdm extends StatelessWidget {
  const UserAdm({Key? key}) : super(key: key);
  final SizedBox _vSpacer = const SizedBox(height: 20);

  @override
  Widget build(BuildContext context) {
    final UserAdmController controller = Get.put(UserAdmController());
    final UserService userService = Get.put(UserService());
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
                subTitle('Usuário Administrador'),
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
                      controller: controller.nameController,
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
                      controller: controller.emailController,
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
                      controller: controller.passwordController,
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
                    String name = controller.nameController.text;
                    String email = controller.emailController.text;
                    String password = controller.passwordController.text;
                    await userService.saveUserAdm(
                        context: context,
                        name: name,
                        email: email,
                        password: password);
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
}
