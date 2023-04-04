import 'package:fluent_ui/fluent_ui.dart';

class ConfigUserAdm extends StatefulWidget {
  const ConfigUserAdm({super.key});

  @override
  State<ConfigUserAdm> createState() => _ConfigUserAdmState();
}

class _ConfigUserAdmState extends State<ConfigUserAdm> {
  final SizedBox _vSpacer = const SizedBox(height: 20);
  final SizedBox _hSpacer = const SizedBox(width: 20);
  @override
  Widget build(BuildContext context) {
    return ScaffoldPage(
      content: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(8),
            child: Column(
              children: [
                 Text(
                  'Configuração da Base de Dados',
                  softWrap: true,
                  style: TextStyle(
                    color: Colors.blue.dark,
                    fontSize: 24,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
