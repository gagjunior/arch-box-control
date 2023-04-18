import 'package:arch_box_control/services/user_service.dart';
import 'package:fluent_ui/fluent_ui.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  Map<String, dynamic> loggedUser = UserService.getLoggedUserInfo();
  String name = '';
  String email = '';

  @override
  void initState() {
    super.initState();
    name = loggedUser['name'].toString();
    email = loggedUser['email'].toString();
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage.scrollable(
      header: const PageHeader(
        title: Text('Bem Vindo!'),
      ),
      children: [
        Row(
          children: [Text('Usuário: $name')],
        ),
        Row(
          children: [Text('E-mail: $email')],
        ),
        Row(
          children: [
            Card(
              child: Text('Card 1'),
            ),
            Card(
              child: Text('Card 2'),
            ),
          ],
        )
      ],
    );
  }
}
