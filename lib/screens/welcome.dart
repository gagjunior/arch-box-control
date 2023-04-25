import 'package:arch_box_control/languages/language.dart';
import 'package:arch_box_control/services/user_service.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:get/get.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  Map<String, dynamic> loggedUser = UserService.getLoggedUserInfo();
  String name = '';
  String email = '';
  String loggedIn = '';

  

  @override
  void initState() {
    super.initState();
    name = loggedUser['name'].toString();
    email = loggedUser['email'].toString();
    loggedIn = loggedUser['loggedIn'].toString();
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage.scrollable(
      header: PageHeader(
        title: Text('welcome'.tr, style: TextStyle(color: Colors.blue.dark)),
      ),
      children: [
        Text('${'user'.tr}: $name'),
        Text('E-mail: $email'),
        Text('${'loggedIn'.tr}: $loggedIn'),
      
      ],
    );
  }
}
