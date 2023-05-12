import 'package:arch_box_control/screens/welcome/welcome_controller.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:easy_localization/easy_localization.dart' as easy;
import 'package:fluent_ui/fluent_ui.dart';
import 'package:get/get.dart';

class WelcomeScreen extends StatelessWidget {
  
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final WelcomeCrontroller controller = Get.put(WelcomeCrontroller());
    String name = controller.loggedUser['name'].toString();
    String email = controller.loggedUser['email'].toString();
    String loggedIn = controller.loggedUser['loggedIn'].toString();

    return ScaffoldPage.scrollable(
      header: PageHeader(
        title:
            Text(easy.tr('welcome'), style: TextStyle(color: Colors.blue.dark)),
      ),
      children: [
        Text('${'user'.plural(0)}: $name'),
        Text('E-mail: $email'),
        Text('${easy.tr('loggedIn')}: $loggedIn'),
      ],
    );
  }
}
