import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pharmacy/features/settings/ui/settings_screen.dart';

import '../../../../core/common_widgets/pharmacy_app_bar.dart';
import '../../../../core/routes/routes.dart';
import '../../../../core/themes/text_styles.dart';
import '../../../../gen/assets.gen.dart';
import '../../../../generated/l10n.dart';
import '../../../cart/ui/cart_screen.dart';
import '../../../home/ui/home/screens/home_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  // Track the current index of the selected tab
  int _currentIndex = 0;

  // List of screens/widgets corresponding to each tab
  final List<Widget> _screens = [
    const HomeScreen(),
    const CartScreen(),
    const SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PharmacyAppBar(
          searchEnabled: false,
          backEnabled: false,
          onSearchTap: () => Navigator.pushNamed(context, Routes.searchScreen),
          child: Text(
            S.of(context).morning_welcome_message,
            style:  TextStyles.welcomeText,
          ),
        ),
        body: IndexedStack(
          index: _currentIndex,
          children: _screens,
        ),
        bottomNavigationBar: ClipRRect(
            borderRadius: const BorderRadiusDirectional.only(
                topStart: Radius.circular(20), topEnd: Radius.circular(20)),
            child: NavigationBarTheme(
              data: NavigationBarThemeData(
                labelTextStyle: WidgetStateProperty.resolveWith<TextStyle>(
                  (Set<WidgetState> states) {
                      return TextStyles.bottomNavLabel;
                  },
                ),
              ),
              child: NavigationBar(
                selectedIndex: _currentIndex,
                onDestinationSelected: (value) {
                  setState(() {
                    _currentIndex = value;
                  });
                },
                destinations: [
                  NavigationDestination(
                    icon: Assets.images.homeUnselected.svg(),
                    label: S.of(context).home_item,
                    selectedIcon: Assets.images.homeSelected.svg(),
                    tooltip: S.of(context).home_item,
                  ),
                  NavigationDestination(
                    icon: Assets.images.cartUnselected.svg(),
                    label: S.of(context).cart_item,
                    selectedIcon: Assets.images.cartSelected.svg(),
                    tooltip: S.of(context).cart_item,
                  ),
                  NavigationDestination(
                    icon: Assets.images.settingsUnselected.svg(),
                    label: S.of(context).settings_item,
                    selectedIcon: Assets.images.settingsSelected.svg(),
                    tooltip: S.of(context).settings_item,
                  ),
                ],
                height: 90.h,
                indicatorColor: Colors.blue,
                backgroundColor: Colors.blue[100],
              ),
            )));
  }
}
