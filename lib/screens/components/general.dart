import 'package:fluent_ui/fluent_ui.dart';

Widget subTitle(String title) {
  return Text(
    title,
    style: const TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: 16,
      fontStyle: FontStyle.italic,
    ),
  );
}

Widget dataBaseError(String error) {
  return ScaffoldPage.withPadding(
    header: PageHeader(
      title: Text(
        'Data Base Error',
        style: TextStyle(
          color: Colors.red.dark,
        ),
      ),
    ),
    content: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          error,
          style: TextStyle(fontSize: 18),
        ),
      ],
    ),
  );
}
