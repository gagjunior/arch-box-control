import 'package:arch_box_control/screens/users/user_home.dart';
import 'package:arch_box_control/screens/welcome/welcome.dart';
import 'package:easy_localization/easy_localization.dart';
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
      appBar: const NavigationAppBar(),
      transitionBuilder: (child, animation) =>
          HorizontalSlidePageTransition(animation: animation, child: child),
      pane: NavigationPane(
        displayMode: PaneDisplayMode.compact,
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
      title: Text('home'.tr()),
      body: const WelcomeScreen(),
    ),
    PaneItemSeparator(color: Colors.blue.lighter),
    PaneItem(
      icon: Icon(
        icons.FluentIcons.people_16_filled,
        color: Colors.blue.dark,
      ),
      title: Text('user'.plural(3)),
      body: const UserHomeScreen(),
    ),
  ];
}
