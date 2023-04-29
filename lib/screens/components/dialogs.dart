import 'package:easy_localization/easy_localization.dart' as easy;
import 'package:fluent_ui/fluent_ui.dart';

Future<void> showErrorDialog(
    {required BuildContext context,
    required String title,
    required String content}) async {
  await showDialog(
    context: context,
    builder: (context) => ContentDialog(
      title: Text(title),
      content: Text(content),
      style: ContentDialogThemeData(
        titleStyle: TextStyle(color: Colors.red.dark),
      ),
      actions: [
        FilledButton(
          child: Text(easy.tr('back')),
          onPressed: () => Navigator.pop(context),
        ),
      ],
    ),
  );
}
