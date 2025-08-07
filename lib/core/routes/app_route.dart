import 'package:flutter/material.dart';
import 'package:pharmacy/core/db/cart/model/product.dart';
import 'package:pharmacy/core/models/category/category_response.dart' as category_response;
import 'package:pharmacy/core/routes/routes.dart';
import 'package:pharmacy/core/routes/transition/transition_type.dart';
import 'package:pharmacy/features/admin/dashboard/ui/screens/dashboard_screen.dart';
import 'package:pharmacy/features/admin/orders/ui/screens/admin_orders_screen.dart';
import 'package:pharmacy/features/checkout/ui/screens/checkout_screen.dart';
import 'package:pharmacy/features/details/ui/DetailsScreen.dart';
import 'package:pharmacy/features/items_list/ui/item_list_screen.dart';
import 'package:pharmacy/features/items_list/logic/item_list_screen_cubit.dart';
import 'package:pharmacy/features/login&signup/ui/screen/otp_verification_screen.dart';
import 'package:pharmacy/features/login&signup/ui/screen/signup_screen.dart';
import 'package:pharmacy/features/splash/splash_screen.dart';
import 'package:pharmacy/features/user/ui/screens/user_screen.dart';

import '../../features/admin/main/ui/screens/main_admin_screen.dart';
import '../../features/admin/users/ui/screens/admin_users_screen.dart';
import '../../features/admin/users/ui/screens/admin_user_detail_screen.dart';
import '../../features/login&signup/ui/screen/login_screen.dart';
import '../../features/main/presentation/screens/main_screen.dart';
import '../../features/search/ui/screens/search_screen.dart';
import '../../features/user_orders/ui/screens/user_orders_screen.dart';

class AppRouter {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case Routes.main:
        return MaterialPageRoute(builder: (_) => MainScreen());
      case Routes.searchScreen:
        return MaterialPageRoute(
            builder: (context) => const SearchScreen(), settings: settings);
      case Routes.productDetail:
        return MaterialPageRoute(
            builder: (context) => DetailScreen(settings.arguments as int));
      case Routes.checkOutScreen:
        return MaterialPageRoute(
            builder: (context) => CheckoutScreen(
                  cartItems: settings.arguments as List<Product>,
                ));
      case Routes.itemListScreen:
        return MaterialPageRoute(builder: (context) {
          final arguments = settings.arguments;

          if (arguments is category_response.Results) {
            return ItemListScreen(
              widgetTitle: arguments.categoryNameAr ?? "",
              categoryId: arguments.categoryId,
            );
          } else if (arguments is String) {
            return ItemListScreen(
              widgetTitle: arguments,
              categoryId: null, // No category, fetch all
            );
          } else if (arguments is Map<String, dynamic>) {
            return ItemListScreen(
              widgetTitle: arguments['title'] as String,
              categoryId: arguments['categoryId'] as int?,
              fetchType: arguments['fetchType'] as FetchType?,
            );
          } else {
            return const Scaffold(
              body: Center(child: Text('Invalid arguments')),
            );
          }
        });
      case Routes.signUp:
        return MaterialPageRoute(builder: (_) => const SignupScreen());
        case Routes.otpValidation:
        return MaterialPageRoute(builder: (_) {
          final arguments = settings.arguments;
         return OtpVerificationScreen(email: arguments as String);
        });
      case Routes.login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case Routes.userScreen:
        return navigateWithAnimation(
          screen: const UserScreen(),
          transition: TransitionType.fade,
        );
      case Routes.userOrdersScreen:
        return navigateWithAnimation(
          screen: const UserOrdersScreen(),
          transition: TransitionType.fade,
        );
      case Routes.adminMain:
        return navigateWithAnimation(
          screen: const MainAdminScreen(),
          transition: TransitionType.scale,
        );
      case Routes.adminOrders:
        return navigateWithAnimation(
          screen: const AdminOrdersScreen(),
          transition: TransitionType.fade,
        );
      case Routes.adminUsers:
        return navigateWithAnimation(
          screen: const AdminUsersScreen(),
          transition: TransitionType.fade,
        );
      case Routes.adminUserDetail:
        return navigateWithAnimation(
          screen: AdminUserDetailScreen(
            userId: settings.arguments as int,
          ),
          transition: TransitionType.fade,
        );
      case Routes.adminDashboard:
        return navigateWithAnimation(
          screen: const DashboardScreen(),
          transition: TransitionType.fade,
        );
      case Routes.adminReports:
        return navigateWithAnimation(
          screen: const AdminUsersScreen(),
          transition: TransitionType.fade,
        );

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
