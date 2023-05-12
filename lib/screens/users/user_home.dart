import 'package:arch_box_control/screens/users/user_list.dart';
import 'package:easy_localization/easy_localization.dart' as easy;
import 'package:fluent_ui/fluent_ui.dart';

class UserHomeScreen extends StatelessWidget {
  const UserHomeScreen({Key? key}) : super(key: key);
  final SizedBox _vSpacer = const SizedBox(height: 10);

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage.scrollable(
      header: PageHeader(
        title: Text(easy.plural('user', 3),
            style: TextStyle(color: Colors.blue.dark)),
      ),
      children: [
        Button(
          style: ButtonStyle(
            elevation: ButtonState.all(2),
          ),
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Text(
              easy.tr('list_users'),
              textAlign: TextAlign.left,
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          onPressed: () {
            Navigator.push(context,
                FluentPageRoute(builder: (context) => UserListScreen()));
          },
        ),
        _vSpacer,
        Button(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(easy.tr('register_user'), textAlign: TextAlign.left),
          ),
          onPressed: () {},
        ),
      ],
    );
  }
}
