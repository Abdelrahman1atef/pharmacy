import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmacy/app_config_provider/logic/auth/logic/auth_cubit.dart';
import 'package:pharmacy/app_config_provider/logic/auth/logic/auth_state.dart';
import 'package:pharmacy/core/common_widgets/pharmacy_app_bar.dart';
import 'package:pharmacy/core/routes/routes.dart';
import 'package:pharmacy/features/admin/orders/logic/admin_orders_cubit.dart';
import 'package:pharmacy/gen/assets.gen.dart';
import '../../model/admin_panel_item.dart';

class MainAdminScreen extends StatelessWidget {
  const MainAdminScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<AdminPanelItem> adminItems = [
      AdminPanelItem(
          title: 'Orders',
          svgImage: Assets.images.ordersItem.svg(),
          route: Routes.adminOrders
          ,function:() =>  context.read<AdminOrdersCubit>().getAdminOrders()
      ),
      AdminPanelItem(
          title: 'Users',
          svgImage: Assets.images.usersItem.svg(),
          route: Routes.adminUsers
          ,function:() =>  context.read<AdminOrdersCubit>()
      ),
      AdminPanelItem(
          title: 'Dashboard',
          svgImage: Assets.images.dashboardItem.svg(),
          route: Routes.adminDashboard
          ,function:() =>  context.read<AdminOrdersCubit>()
      ),
      AdminPanelItem(
          title: 'Reports',
          svgImage: Assets.images.reportItem.svg(),
          route: Routes.adminReports
          ,function:() =>  context.read<AdminOrdersCubit>()
      ),
    ];
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {

        return state.maybeWhen(
          orElse: () => const Text("Error"),
          authenticated: (user) => Scaffold(
            appBar: const PharmacyAppBar(
              isGeneralLayout: false,
              heightFactor: 1.1,
            ),
            body: SafeArea(
                child: Center(
              child: Padding(
                padding: const EdgeInsetsDirectional.all(10.0),
                child: _adminControlPanel(adminItems),
              ),
            )),
          ),
        );
      },
    );
  }

  Widget _adminControlPanel(adminItems) {
    return GridView.builder(
      itemCount: adminItems.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
      ),
      itemBuilder: (BuildContext context, int index) {
        final item = adminItems[index];
        return InkWell(
          onTap: () {
            item.function?.call();
            Navigator.pushNamed(
              context,
              item.route,
            );
          },
          child: Card(
            elevation: 15,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(width: 50, height: 50, child: item.svgImage),
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
