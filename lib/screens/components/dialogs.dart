import 'package:easy_localization/easy_localization.dart' as easy;
import 'package:fluent_ui/fluent_ui.dart';

Future<void> showErrorDialog(
    {required BuildContext context,
    required String title,
    required String content}) async {
  await showDialog(
    context: context,
    builder: (context) => ContentDialog(
      title: Text(
        title,
        style: TextStyle(
          fontSize: 24,
          color: Colors.red.dark,
        ),
      ),
      content: Text(
        content,
        style: const TextStyle(
          fontSize: 16,
        ),
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
