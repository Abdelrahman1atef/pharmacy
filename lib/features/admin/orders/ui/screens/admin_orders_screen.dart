import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmacy/features/admin/main/ui/widgets/admin_scaffold.dart';
import 'package:pharmacy/features/admin/orders/logic/admin_orders_cubit.dart';
import 'package:pharmacy/features/admin/orders/logic/admin_orders_state.dart';
import 'package:pharmacy/core/models/order/admin/admin_order_model.dart';
import 'package:pharmacy/core/enum/order_status.dart';
import 'package:pharmacy/generated/l10n.dart';
import '../widgets/admin_order_card.dart';
import '../widgets/order_status_filter.dart';
import '../../logic/order_filter_cubit.dart';
import '../../logic/order_filter_state.dart';

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
              success: (data, _) {
                AdminOrderResponse orders = data;
                
                return BlocBuilder<OrderFilterCubit, OrderFilterState>(
                  builder: (context, filterState) {
                    final currentFilter = filterState.when(
                      initial: () => null,
                      filtered: (status) => status,
                    );
                    
                    List<AdminOrderModel> filteredOrders = orders.results;
                    
                    // Apply filter if one is selected
                    if (currentFilter != null) {
                      filteredOrders = orders.results
                          .where((order) => order.status == currentFilter)
                          .toList();
                    }
                    
                    if (filteredOrders.isEmpty) {
                      return Column(
                        children: [
                          const OrderStatusFilter(),
                          Expanded(
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.inbox_outlined,
                                    size: 64,
                                    color: Colors.grey,
                                  ),
                                  const SizedBox(height: 16),
                                  Text(
                                    currentFilter != null 
                                        ? "No ${currentFilter.getLocalizedDisplayName(S.of(context))} orders found"
                                        : "No orders found",
                                    style: const TextStyle(
                                      fontSize: 18,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      );
                    }
                    
                    return Column(
                      children: [
                        const OrderStatusFilter(),
                        Expanded(
                          child: ListView.builder(
                            itemCount: filteredOrders.length,
                            itemBuilder: (BuildContext context, int index) {
                              return AdminOrderCard(order: filteredOrders[index]);
                            },
                          ),
                        ),
                      ],
                    );
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
