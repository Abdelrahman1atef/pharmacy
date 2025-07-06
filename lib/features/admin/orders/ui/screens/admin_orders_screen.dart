import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmacy/features/admin/main/ui/widgets/admin_scaffold.dart';
import 'package:pharmacy/features/admin/orders/logic/admin_orders_cubit.dart';
import 'package:pharmacy/features/admin/orders/logic/admin_orders_state.dart';
import 'package:pharmacy/core/models/order/admin/admin_order_model.dart';
import '../widgets/admin_order_card.dart';

class AdminOrdersScreen extends StatelessWidget {
  const AdminOrdersScreen({super.key});

  Future<void> _onRefresh(BuildContext context) async {
    await Future.wait([
      Future(() => context.read<AdminOrdersCubit>().getAdminOrders()),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return AdminScaffold(
      body: RefreshIndicator(
        onRefresh: () => _onRefresh(context),
        child: BlocBuilder<AdminOrdersCubit, AdminOrdersState>(
          builder: (context, state) {
            return state.maybeWhen(
              loading: () => const Center(
                child: CircularProgressIndicator(),
              ),
              success: (data) {
                List<AdminOrderModel> orders = data;
                if (orders.isEmpty) {
                  return const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.inbox_outlined,
                          size: 64,
                          color: Colors.grey,
                        ),
                        SizedBox(height: 16),
                        Text(
                          "No orders found",
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  );
                }
                return ListView.builder(
                  itemCount: orders.length,
                    itemBuilder: (BuildContext context, int index) {
                    return AdminOrderCard(order: orders[index]);
                  },
                );
              },
              orElse: () => const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.error_outline,
                      size: 64,
                      color: Colors.grey,
                    ),
                    SizedBox(height: 16),
                    Text(
                      "Something went wrong",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
