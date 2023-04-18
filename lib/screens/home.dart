import 'package:arch_box_control/screens/welcome.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart' as icons;

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
      transitionBuilder: (child, animation) =>
          HorizontalSlidePageTransition(animation: animation, child: child),
      appBar: const NavigationAppBar(
        title: Text('Arch Box Control'),
      ),
      pane: NavigationPane(
        displayMode: PaneDisplayMode.auto,
        header: const Text('Menu'),
        selected: _currentPage,
        onChanged: (i) => setState(() {
          _currentPage = i;
        }),
        items: _items,
      ),
    );
  }

  final List<NavigationPaneItem> _items = [
    PaneItem(
      icon: Icon(
        icons.FluentIcons.home_16_filled,
        color: Colors.blue.dark,
      ),
      title: const Text('Início'),
      body: WelcomeScreen(),
    ),
    PaneItemSeparator(color: Colors.blue.lighter),
  ];
}
