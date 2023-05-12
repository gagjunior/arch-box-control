import 'package:arch_box_control/screens/users/user_home.dart';
import 'package:arch_box_control/screens/welcome/welcome.dart';
import 'package:easy_localization/easy_localization.dart' as easy;
import 'package:fluent_ui/fluent_ui.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart' as icons;
import 'package:get/get.dart';

class HomeController extends GetxController {
  var currentPage = 0.obs;

  final List<NavigationPaneItem> items = [
    PaneItem(
      icon: Icon(
        icons.FluentIcons.home_16_filled,
        color: Colors.blue.dark,
      ),
      title: Text(easy.tr('home')),
      body: const WelcomeScreen(),
    ),
    PaneItemSeparator(color: Colors.blue.lighter),
    PaneItem(
      icon: Icon(
        icons.FluentIcons.people_16_filled,
        color: Colors.blue.dark,
      ),
      title: Text(easy.plural('user', 3)),
      body: const UserHomeScreen(),
    ),
  ];
}
