import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pharmacy/features/main/logic/main_cubit.dart';
import 'package:pharmacy/features/settings/ui/settings_screen.dart';

import '../../../../core/common_widgets/pharmacy_app_bar.dart';
import '../../../../core/routes/routes.dart';
import '../../../../core/themes/text/text_styles.dart';
import '../../../../gen/assets.gen.dart';
import '../../../../generated/l10n.dart';
import '../../../cart/ui/screen/cart_screen.dart';
import '../../../home/ui/home/screens/home_screen.dart';

class MainScreen extends StatelessWidget {

   MainScreen({super.key});

  // List of screens/widgets corresponding to each tab
  final List<Widget> _screens = [
    const HomeScreen(),
    const CartScreen(),
    const SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainCubit, int>(
  builder: (context, currentIndex) {
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
          index: currentIndex,
          children: _screens,
        ),
        bottomNavigationBar: NavigationBarTheme(
          data: NavigationBarThemeData(
            labelTextStyle: WidgetStateProperty.resolveWith<TextStyle>(
              (Set<WidgetState> states) {
                  return TextStyles.bottomNavLabel;
              },
            ),
          ),
          child: NavigationBar(
            selectedIndex: currentIndex,
            onDestinationSelected: (index) {
              BlocProvider.of<MainCubit>(context).selectTab(index);
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
                icon: Assets.images.moreSelected.svg(),
                label: S.of(context).more_item,
                selectedIcon: Assets.images.moreSelected.svg(),
                tooltip: S.of(context).more_item,
              ),
              // NavigationDestination(
              //   icon: Assets.images.userUnselected.svg(),
              //   label: S.of(context).user_item,
              //   selectedIcon: Assets.images.userSelected.svg(),
              //   tooltip: S.of(context).user_item,
              // ),
            ],
            height: 70.h,
            indicatorColor: Colors.blue,
            backgroundColor: Colors.blue[200],
            elevation: 5,
          ),
        ));
  },
);
  }
}
