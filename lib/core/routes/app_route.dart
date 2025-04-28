import 'package:flutter/material.dart';
import 'package:pharmacy/core/models/category/category_response.dart';
import 'package:pharmacy/core/routes/routes.dart';
import 'package:pharmacy/features/details/ui/DetailsScreen.dart';
import 'package:pharmacy/features/items_list/ui/item_list_screen.dart';
import 'package:pharmacy/features/login&signup/ui/screen/signup_screen.dart';

import '../../features/login&signup/ui/screen/login_screen.dart';
import '../../features/main/presentation/screens/main_screen.dart';
import '../../features/search/ui/screens/search_screen.dart';

class AppRouter {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.main:
        return MaterialPageRoute(builder: (_) => MainScreen(key: mainPageKey,));
      case Routes.searchScreen:
        return MaterialPageRoute(
            builder: (context) => const SearchScreen(), settings: settings);
      case Routes.productDetail:
        return MaterialPageRoute(
            builder: (context) => DetailScreen(settings.arguments as int));
      case Routes.itemListScreen:
        return MaterialPageRoute(builder: (context) {
          final arguments = settings.arguments;

          if (arguments is CategoryResponse) {
            return ItemListScreen(
              widgetTitle: arguments.categoryNameAr ?? "",
              categoryId: arguments.categoryId,
            );
          } else if (arguments is String) {
            return ItemListScreen(
              widgetTitle: arguments,
              categoryId: null, // No category, fetch all
            );
          } else {
            return const Scaffold(
              body: Center(child: Text('Invalid arguments')),
            );
          }
        });
      case Routes.signUp:
        return MaterialPageRoute(builder: (_) =>  SignupScreen());
      case Routes.login:
        return MaterialPageRoute(builder: (_) =>   LoginScreen());
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
