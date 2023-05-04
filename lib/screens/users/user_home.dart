import 'package:easy_localization/easy_localization.dart' as easy;
import 'package:fluent_ui/fluent_ui.dart' ;

class UserHomeScreen extends StatelessWidget {
  const UserHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage.scrollable(
      header: PageHeader(
        title: Text(easy.plural('user', 3), style: TextStyle(color: Colors.blue.dark)),
      ),
      children: [],
    );
  }
}
