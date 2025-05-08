import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmacy/app_config_provider/logic/auth/logic/auth_cubit.dart';
import 'package:pharmacy/app_config_provider/logic/auth/logic/auth_state.dart';
import 'package:pharmacy/core/common_widgets/pharmacy_app_bar.dart';
import 'package:pharmacy/core/routes/routes.dart';
import 'package:pharmacy/gen/assets.gen.dart';
import '../../model/admin_panel_item.dart';

class MainAdminScreen extends StatelessWidget {
  MainAdminScreen({super.key});

  final List<AdminPanelItem> _adminItems = [
    AdminPanelItem(title: 'Orders',svgImage: Assets.images.ordersItem.svg(), route: Routes.adminOrders),
    AdminPanelItem(title: 'Users',svgImage: Assets.images.usersItem.svg(), route: Routes.adminUsers),
    AdminPanelItem(title: 'Dashboard',svgImage: Assets.images.dashboardItem.svg(), route: Routes.adminDashboard),
    AdminPanelItem(title: 'Reports',svgImage: Assets.images.reportItem.svg(), route: Routes.adminReports),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        return state.maybeWhen(
          orElse: () => Text("Error"),
          authenticated: (user) =>
              Scaffold(
                appBar: const PharmacyAppBar(
                  isGeneralLayout: false,
                  heightFactor: 1.1,
                ),
                body: SafeArea(child: Center(
                  child:Padding(
                    padding: const EdgeInsetsDirectional.all(10.0),
                    child: _adminControlPanel(),
                  ),
                )),
              ),
        );
      },
    );
  }

  Widget _adminControlPanel() {
    return GridView.builder(
      itemCount: _adminItems.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
      ),
      itemBuilder: (BuildContext context, int index) {
        final item = _adminItems[index];
        return InkWell(
          onTap: () => Navigator.pushNamed(context, item.route,),
          child: Card(
            elevation: 15,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                      width: 50,
                      height: 50,
                      child: item.svgImage),
                  Text(
                    item.title,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

}
