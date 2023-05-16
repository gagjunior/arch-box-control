import 'package:arch_box_control/screens/home/home.dart';
import 'package:arch_box_control/screens/users/new_user.dart';
import 'package:arch_box_control/screens/users/user_list.dart';
import 'package:easy_localization/easy_localization.dart' as easy;
import 'package:fluent_ui/fluent_ui.dart';

class UserHomeScreen extends StatelessWidget {
  const UserHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //UsersController controller = Get.put(UsersController());

    return ScaffoldPage.scrollable(
      header: PageHeader(
        title: Text(easy.plural('user', 3),
            style: TextStyle(color: Colors.blue.dark)),
      ),
      children: [
        Button(
          onPressed: () {},
          child: Row(
            children: [
              Text('Listar'),
              Expanded(child: Row()),
              IconButton(
                  icon: Icon(FluentIcons.list),
                  onPressed: () {
                    Navigator.of(context).push(FluentPageRoute(
                        builder: (context) => UserListScreen()));
                  })
            ],
          ),
        ),
        Row(
          children: [
            Text('Adicionar'),
            IconButton(
                icon: Icon(FluentIcons.list),
                onPressed: () {
                  Navigator.of(context).push(
                      FluentPageRoute(builder: (context) => NewUserScreen()));
                })
          ],
        )
      ],
    );
  }
}
