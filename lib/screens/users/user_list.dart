import 'package:easy_localization/easy_localization.dart' as easy;
import 'package:fluent_ui/fluent_ui.dart';

class UserListScreen extends StatelessWidget {
  const UserListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<CommandBarItem> commandItens = [
      CommandBarButton(
          icon: const Icon(FluentIcons.list),
          onPressed: () {},
          label: const Text('Listar'))
    ];

    return ScaffoldPage.scrollable(
      header: PageHeader(
        title: Text(
          easy.tr('user_list'),
        ),
      ),
      children: [
        Card(
          child: CommandBar(
            overflowBehavior: CommandBarOverflowBehavior.wrap,
            compactBreakpointWidth: 600,
            primaryItems: commandItens,
          ),
        ),
      ],
    );
  }
}
