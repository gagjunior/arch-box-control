import 'package:arch_box_control/screens/home/home.dart';
import 'package:arch_box_control/screens/users/user_home.dart';
import 'package:fluent_ui/fluent_ui.dart';

class NewUserScreen extends StatelessWidget {
  const NewUserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage.scrollable(
      header: PageHeader(
        leading: IconButton(
            icon: Icon(FluentIcons.back),
            onPressed: () {
              Navigator.pop(context);
            }),
      ),
      children: [],
    );
  }
}
