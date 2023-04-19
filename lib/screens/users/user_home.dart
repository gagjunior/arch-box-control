import 'package:fluent_ui/fluent_ui.dart';

class UserHomeScreen extends StatefulWidget {
  const UserHomeScreen({super.key});

  @override
  State<UserHomeScreen> createState() => _UserHomeScreenState();
}

class _UserHomeScreenState extends State<UserHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return ScaffoldPage.scrollable(
      header: PageHeader(
        title: Text('Usuários', style: TextStyle(color: Colors.blue.dark)),
      ),
      children: [
        CommandBar(
          primaryItems: <CommandBarItem>[
            CommandBarButton(icon: Icon(FluentIcons.add), onPressed: null),
            CommandBarSeparator(),
          ],
        ),
      ],
    );
  }
}
