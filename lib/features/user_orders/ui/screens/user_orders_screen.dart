import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pharmacy/core/common_widgets/pharmacy_app_bar.dart';
import 'package:pharmacy/core/models/order/customer/customer_order_model.dart';
import 'package:pharmacy/features/admin/main/ui/widgets/admin_scaffold.dart';
import 'package:pharmacy/features/user_orders/logic/user_orders_state.dart';
import '../../logic/user_orders_cubit.dart';
import '../widgets/order_card_item.dart';

class UserOrdersScreen extends StatelessWidget {
  const UserOrdersScreen({super.key});

  Future<void> _onRefresh(BuildContext context) async {
    await Future.wait([
      Future(() => context.read<UserOrdersCubit>().getCustomerOrders()),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    // context.read<UserOrdersCubit>().getCustomerOrders();
    return Scaffold(
      appBar: const PharmacyAppBar(),
      body: RefreshIndicator(
        onRefresh: () => _onRefresh(context),
        child: BlocBuilder<UserOrdersCubit, UserOrdersState>(
          builder: (context, state) {
            return state.maybeWhen(
              loading: () => const Center(
                child: CircularProgressIndicator(),
              ),
              success: (data) {
                List<CustomerOrderModel> orders = data;
                return Padding(
                  padding:  EdgeInsetsDirectional.only(bottom: 30.h),
                  child: ListView.builder(
                    itemCount: orders.length,
                    itemBuilder: (BuildContext context, int index) {
                      return OrderCardItem(
                        orderInfo: orders[index],
                      );
                    },
                  ),
                );
              },
              orElse: () {
                return const SizedBox(
                  height: 25,
                  width: 25,
                );
              },
            );
          },
        ),
      ),
    );
  }
}