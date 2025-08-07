import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pharmacy/core/common_widgets/custom_snackbar.dart';
import 'package:pharmacy/core/common_widgets/pharmacy_app_bar.dart';
import 'package:pharmacy/core/models/order/customer/customer_order_model.dart';
import 'package:pharmacy/features/cart/logic/order/order_cubit.dart';
import 'package:pharmacy/features/cart/logic/order/order_state.dart';
import 'package:pharmacy/features/user_orders/logic/user_orders_state.dart';
import '../../logic/user_orders_cubit.dart';
import '../widgets/order_card_item.dart';
import '../widgets/orders_empty_widget.dart';

class UserOrdersScreen extends StatefulWidget {
  const UserOrdersScreen({super.key});

  @override
  State<UserOrdersScreen> createState() => _UserOrdersScreenState();
}

class _UserOrdersScreenState extends State<UserOrdersScreen> {
  Future<void> _onRefresh(BuildContext context) async {
    await Future.wait([
      Future(() => context.read<UserOrdersCubit>().getCustomerOrders()),
    ]);
  }
  @override
  void initState() {
    context.read<UserOrdersCubit>().getCustomerOrders();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        // Listen to OrderCubit state changes (for reorder actions)
        BlocListener<OrderCubit, OrderState>(
          listener: (context, state) {
            state.maybeWhen(
              loading: () {
                CustomSnackBar.showInfo(context, "Processing your reorder...");
              },
              success: (data) {
                CustomSnackBar.showSuccess(context, "Reorder placed successfully! Order ID: ${data.message}");
              },
              error: (e) {
                CustomSnackBar.showError(context, e.message);
              },
              orElse: () {},
            );
          },
        ),
      ],
      child: Scaffold(
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
                CustomerOrderResponse orders = data;
                
                if (orders.results.isEmpty) {
                  return const OrdersEmpty();
                }
                
                return Padding(
                  padding:  EdgeInsetsDirectional.only(bottom: 30.h),
                  child: ListView.builder(
                    itemCount: orders.results.length,
                    itemBuilder: (BuildContext context, int index) {
                      return OrderCardItem(
                        orderInfo: orders.results[index],
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
      ),
    );
  }
}