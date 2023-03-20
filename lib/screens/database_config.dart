import 'package:fluent_ui/fluent_ui.dart';

class DataBaseConfig extends StatefulWidget {
  const DataBaseConfig({super.key});

  @override
  State<DataBaseConfig> createState() => _DataBaseConfigState();
}

class _DataBaseConfigState extends State<DataBaseConfig> {
  @override
  Widget build(BuildContext context) {
    return ScaffoldPage(
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 100),
          Center(
              child: Text(
            'Configuração da Base de Dados',
            softWrap: true,
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.w600,
              color: Colors.blue.dark,
            ),
          )),
          const SizedBox(height: 60),
          Center(
            child: InfoLabel(
                label: 'Url de conexão com o banco de dados',
                labelStyle: TextStyle(
                  fontSize: 16,
                ),
                child: const SizedBox(
                  width: 500,
                  child: TextBox(
                    placeholder: 'Exemplo: mongodb://localhost:27017',
                  ),
                )),
          )
        ],
      ),
    );
  }
}
