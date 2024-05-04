import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:intl/intl_standalone.dart';
import 'package:it_admin/controllers/admin_controller.dart';
import 'package:it_admin/view/resources/color_themes.dart';

import 'app_router.dart';
import 'controllers/hive_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Intl.systemLocale = await findSystemLocale();
  await initializeDateFormatting();
  await HiveController.initHive();

  late AdminController adminController;
  bool isRegistered = Get.isRegistered<AdminController>();
  if (isRegistered) {
    adminController = Get.find<AdminController>();
  } else {
    adminController = Get.put(AdminController());
  }
  runApp(const ItAdminApp());
}

class ItAdminApp extends StatefulWidget {
  const ItAdminApp({super.key});

  @override
  State<ItAdminApp> createState() => _ItAdminAppState();
}

class _ItAdminAppState extends State<ItAdminApp> {
  final _appRouter = const AppRouter();

  @override
  void initState() {
    // SystemChrome.setPreferredOrientations(
    //   [
    //     DeviceOrientation.portraitUp,
    //     DeviceOrientation.portraitDown,
    //   ],
    // );
    // SystemChrome.setSystemUIOverlayStyle(
    //   SystemUiOverlayStyle.dark.copyWith(
    //     statusBarColor: Colors.transparent,
    //   ),
    // );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final settingsBox = Hive.box('settings');
    if (settingsBox.get('dark_theme') == null) {
      settingsBox.put('dark_theme',
          MediaQuery.of(context).platformBrightness == Brightness.dark);
    }

    // return MaterialApp(
    //   title: 'Flutter Demo',
    //   debugShowCheckedModeBanner: false,
    //   theme: ItAdminColorTheme.light,
    //   home: const MyHomePage(title: 'Flutter Demo Home Page'),
    // );

    return StreamBuilder<Object>(
      stream: settingsBox.watch(key: 'color_theme'),
      builder: (context, snapshot) {
        final initialRoute =
            settingsBox.get('initial_screen', defaultValue: '/');
        final theme = ItAdminColorTheme.light;
        return StreamBuilder<Object>(
          stream: settingsBox.watch(key: 'dark_theme'),
          builder: (context, snapshot) {
            return GetMaterialApp(
              onGenerateRoute: _appRouter.onGenerateRoute,
              debugShowCheckedModeBanner: false,
              initialRoute: initialRoute,
              theme: theme,
            );
          },
        );
      },
    );
  }
}

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key, required this.title});
//   final String title;

//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   int _counter = 0;

//   void _incrementCounter() {
//     setState(() {
//       _counter++;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Theme.of(context).colorScheme.inversePrimary,
//         title: Text(widget.title),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             const Text(
//               'You have pushed the button this many times:',
//             ),
//             Text(
//               '$_counter',
//               style: Theme.of(context).textTheme.headlineMedium,
//             ),
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _incrementCounter,
//         tooltip: 'Increment',
//         child: const Icon(Icons.add),
//       ),
//     );
//   }
// }
