import 'dart:io';

import 'package:arch_box_control/screens/database_config.dart';
import 'package:arch_box_control/screens/login.dart';
import 'package:arch_box_control/services/db_config_service.dart';
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

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final bool dbUrlFound = DbConfigService.dbUrlFound();

  @override
  Widget build(BuildContext context) {
    return FluentApp(
      debugShowCheckedModeBanner: false,
      title: 'ArchBoxControl',
      home: const DataBaseConfig(), //dbUrlFound ? const Login() : const DataBaseConfig(),
      theme: FluentThemeData(
        scaffoldBackgroundColor: Colors.white,
        accentColor: SystemTheme.accentColor.accent.toAccentColor(),
      ),
    );
  }
}
