import 'package:fluent_ui/fluent_ui.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return NavigationView(
      appBar: const NavigationAppBar(
          title: Text('Arch Box Control'), automaticallyImplyLeading: false),
      pane: NavigationPane(
        displayMode: PaneDisplayMode.auto,
        header: const Text('Menu'),
        selected: _currentPage,
        onChanged: (i) => setState(() {
          _currentPage = i;          
        }),
      ),
    );
  }
}
