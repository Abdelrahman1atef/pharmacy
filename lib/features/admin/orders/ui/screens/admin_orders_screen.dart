import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmacy/features/admin/main/ui/widgets/admin_scaffold.dart';
import 'package:pharmacy/features/admin/orders/logic/admin_orders_cubit.dart';
import 'package:pharmacy/features/admin/orders/logic/admin_orders_state.dart';

import '../../../../../core/models/order/admin/admin_order_model.dart';
import '../../../../../generated/l10n.dart';

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
                List<AdminOrderModel> order = data;
                return ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (BuildContext context, int index) {
                      return _cardItem(order, index, context);
                    });
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

Widget _cardItem(order, index, context) {
  AdminOrderModel orderInfo = order[index];
  int orderNum = order[index].items!.length;
  return Card(
    margin: const EdgeInsets.all(12),
    child: ListTile(
      leading: Text(orderInfo.id.toString()),
      subtitle: Text(orderInfo.totalPrice.toString()),
      trailing: Text(orderInfo.status.name),
      onTap: () => _showFloatingOrderDetails(context, orderInfo),
      title: Text(
          "${order[index].items!.length.toString()} ${orderNum == 1 ? S.of(context).product : S.of(context).ofProducts}"),
    ),
  );
}

void _showFloatingOrderDetails(
    BuildContext context, AdminOrderModel orderInfo) {
  showGeneralDialog(
    context: context,
    barrierDismissible: true,
    barrierLabel: 'OrderDetails',
    barrierColor: Colors.black54,
    // Or Colors.transparent if no dim
    transitionDuration: const Duration(milliseconds: 300),
    pageBuilder: (context, animation, secondaryAnimation) {
      return Center(
        child: Container(
          margin: const EdgeInsets.all(16),
          padding: const EdgeInsets.all(16),
          constraints: const BoxConstraints(
            maxWidth: 500,
            maxHeight: 800,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: const [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10,
                spreadRadius: 2,
              ),
            ],
          ),
          child: Material(
            color: Colors.transparent,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Order #${orderInfo.id}",
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                Expanded(
                  child: ListView(
                    children: [
                      _customerInfo(orderInfo, context),
                      const Divider(),
                      SizedBox(
                        width: double.infinity,
                        height: 520,
                        child: ListView.separated(
                          separatorBuilder: (context, index) => Divider(),
                          itemCount: orderInfo.items!.length,
                          itemBuilder: (context, index) => Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("${S.of(context).productId}: ${orderInfo.items![index].productId}"),
                              Text("${S.of(context).nameAr}: ${orderInfo.items![index].nameAr}"),
                              Text("${S.of(context).nameEn}: ${orderInfo.items![index].nameEn}"),
                              Text("${S.of(context).unitType}: ${orderInfo.items![index].unitType}"),
                              Text("${S.of(context).quantity}: ${orderInfo.items![index].quantity.toString()}"),
                              Text("${S.of(context).itemTotal}: ${orderInfo.items![index].itemTotal}"),
                            ],
                          ),
                        ),
                      )
                      // _orderInfo(orderInfo, context),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text("Close"),
                  ),
                )
              ],
            ),
          ),
        ),
      );
    },
    transitionBuilder: (context, animation, secondaryAnimation, child) {
      return FadeTransition(
        opacity: animation,
        child: ScaleTransition(
          scale: CurvedAnimation(parent: animation, curve: Curves.easeOutBack),
          child: child,
        ),
      );
    },
  );
}

_orderInfo(AdminOrderModel orderInfo, BuildContext context) {
  return ListView.builder(
    itemCount: orderInfo.items?.length,
    itemBuilder: (context, index) => Text(orderInfo.items![index].productId),
  );
}

_customerInfo(AdminOrderModel orderInfo, BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text("${S.of(context).CustomerId}: ${orderInfo.id}"),
      Text(
          "${S.of(context).CustomerName}: ${orderInfo.firstName} ${orderInfo.lastName}"),
      Text("${S.of(context).CustomerEmail}: ${orderInfo.userEmail}"),
      Text("${S.of(context).CustomerPhone}: ${orderInfo.userPhone}"),
    ],
  );
}
