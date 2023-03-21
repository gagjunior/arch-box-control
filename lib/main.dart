//import 'package:mongo_dart/mongo_dart.dart' as mongodb;
import 'package:arch_box_control/screens/database_config.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:system_theme/system_theme.dart';

/*
    var db = await mongodb.Db.create(
      'mongodb+srv://gilberto_junior:NvidiaCoreI01@archboxcontrol.vpeklbe.mongodb.net/ArchBoxControl?retryWrites=true&w=majority');
  await db.open();

 var db = await mongodb.Db.create('mongodb://localhost:27017');
  await db.open();
  print(db.isConnected);
  print(db.state);
  print(db.databaseName);
*/

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemTheme.accentColor.load();
  await Hive.initFlutter();
  await Hive.openBox('dbSettings');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FluentApp(
      debugShowCheckedModeBanner: false,
      title: 'ArchBoxControl',
      home: const DataBaseConfig(),
      theme: FluentThemeData(
          accentColor: SystemTheme.accentColor.accent.toAccentColor(),
          scaffoldBackgroundColor: Colors.white),
    );
  }
}
