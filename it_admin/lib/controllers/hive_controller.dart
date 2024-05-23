import 'package:hive_flutter/hive_flutter.dart';

class HiveController {
  static Future<void> initHive() async {
    await Hive.initFlutter();
    // Hive.registerAdapter(CompetencyAdapter());
    await Hive.openBox('settings');
    await Hive.openBox('user');

    Hive.box('user').put('login', 'admin');
    Hive.box('user').put('password', '123mnO!1');
    // await Hive.openBox<Competency>('competencies');
  }
}
