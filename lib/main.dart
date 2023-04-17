import 'dart:io';

import 'package:arch_box_control/screens/config_url_db.dart';
import 'package:arch_box_control/screens/login.dart';
import 'package:arch_box_control/services/config_db_service.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:system_theme/system_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final Directory appSupportDirectory = await getApplicationSupportDirectory();
  final String dataDir = appSupportDirectory.path;
  await SystemTheme.accentColor.load();
  await Hive.initFlutter();
  await Hive.openBox('dbSettings', path: dataDir);
  await Hive.openBox('userInfo', path: dataDir);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final bool dbUrlFound = ConfigDbService.dbUrlFound();

  @override
  Widget build(BuildContext context) {
    return FluentApp(
      debugShowCheckedModeBanner: false,
      title: 'ArchBoxControl',
      home: dbUrlFound ? const Login() : const ConfigUrlDb(),
      theme: FluentThemeData(
        scaffoldBackgroundColor: Colors.white,
        accentColor: SystemTheme.accentColor.accent.toAccentColor(),
      ),
    );
  }
}
