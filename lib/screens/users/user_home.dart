import 'package:easy_localization/easy_localization.dart' as easy;
import 'package:fluent_ui/fluent_ui.dart';

class UserHomeScreen extends StatelessWidget {
  const UserHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const actions = [
      'Adicionar',
      'Listar',
    ];
    const icons = [FluentIcons.add, FluentIcons.list];
    const subtitles = ['Adiconar novos usuários', 'Listar todos os usuários'];

    return ScaffoldPage(
      header: PageHeader(
        title: Text(easy.plural('user', 3),
            style: TextStyle(color: Colors.blue.dark)),
      ),
      content: ListView.builder(
        itemCount: actions.length,
        itemBuilder: (context, index) {
          final action = actions[index];
          return Padding(
            padding: const EdgeInsets.all(6.0),
            child: ListTile.selectable(
              selectionMode: ListTileSelectionMode.single,
              onPressed: () {},
              leading: CircleAvatar(
                child: Icon(icons[index]),
              ),
              title: Text(action),
              subtitle: Text(subtitles[index]),
            ),
          );
        },
      ),
    );
  }
}
