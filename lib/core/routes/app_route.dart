import 'package:flutter/material.dart';
import 'package:pharmacy/core/routes/routes.dart';
import 'package:pharmacy/features/details/ui/DetailsScreen.dart';

import '../../features/main/presentation/screens/main_screen.dart';
import '../../features/search/ui/screens/search_screen.dart';

class AppRouter {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.main:
        return MaterialPageRoute(builder: (_) => const MainScreen());
      case Routes.searchScreen:
        return MaterialPageRoute(
            builder: (context) => const SearchScreen(), settings: settings);
      case Routes.productDetail:
        return MaterialPageRoute(
            builder: (context) => DetailScreen(settings.arguments as int));
      default:
        return _undefineRoute();
    }
  }

  static Route<dynamic> _undefineRoute() {
    return MaterialPageRoute(
      builder: (context) => const Scaffold(
        body: Text("No route found"),
      ),
    );
  }
}
