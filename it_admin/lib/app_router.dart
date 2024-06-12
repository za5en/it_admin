import 'package:flutter/material.dart';
import 'package:it_admin/view/pages/auth.dart';
import 'package:it_admin/view/pages/comps/comps.dart';

import 'view/pages/users/users.dart';

class AppRouter {
  const AppRouter();
  Route onGenerateRoute(settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
            settings: settings, builder: (_) => const Auth());
      case '/users':
        return MaterialPageRoute(
            settings: settings, builder: (_) => const Users());
      case '/comps':
        return MaterialPageRoute(
            settings: settings, builder: (_) => const Comps());
      default:
        throw ErrorDescription('Unknown route name: ${settings.name}');
    }
  }
}
