import 'package:flutter/material.dart';

import 'view/pages/login.dart';

class AppRouter {
  const AppRouter();
  Route onGenerateRoute(settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
            settings: settings, builder: (_) => const Login());
      // case '/users':
      //   return MaterialPageRoute(
      //       settings: settings, builder: (_) => const Users());
      // case '/comps':
      //   return MaterialPageRoute(
      //       settings: settings, builder: (_) => const Competencies());
      default:
        throw ErrorDescription('Unknown route name: ${settings.name}');
    }
  }
}
