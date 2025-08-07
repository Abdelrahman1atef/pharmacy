import 'package:flutter/material.dart';
import 'package:pharmacy/core/models/order/admin/admin_order_model.dart';
import 'package:pharmacy/generated/l10n.dart';
import 'admin_order_details.dart';

class AdminOrderCard extends StatelessWidget {
  final AdminOrderModel order;
  const AdminOrderCard({required this.order, super.key});

  Color _statusColor(BuildContext context) {
    switch (order.status?.name) {
      case 'delivered':
        return Colors.green[100]!;
      case 'pending':
        return Colors.orange[100]!;
      case 'cancelled':
        return Colors.red[100]!;
      case 'preparing':
        return Colors.blue[100]!;
      case 'shipped':
        return Colors.purple[100]!;
      default:
        return Theme.of(context).cardColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: _statusColor(context),
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      elevation: 3,
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        title: Text(
          '${S.of(context).orderNum}${order.id}',
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('${S.of(context).CustomerName}: ${order.fullName}'),
            Text('${S.of(context).total}: ${order.totalPrice}'),
            Row(
              children: [
                const Icon(Icons.info_outline, size: 16),
                const SizedBox(width: 4),
                Text('${S.of(context).orderStatus}: ${order.getStatusText(context)}'),
              ],
            ),
            if (order.hasLocation)
              Row(
                children: [
                  const Icon(Icons.location_on, size: 16, color: Colors.red),
                  const SizedBox(width: 4),
                  Expanded(
                    child: Text(
                      order.fullAddress,
                      style: const TextStyle(fontSize: 12),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            if (!order.isHomeDelivery! && order.pharmacyName != null)
              Row(
                children: [
                  const Icon(Icons.local_pharmacy, size: 16, color: Colors.blue),
                  const SizedBox(width: 4),
                  Expanded(
                    child: Text(
                      '${S.of(context).pharmacyPickup}: ${order.pharmacyName}',
                      style: const TextStyle(fontSize: 12),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
          ],
        ),
        trailing: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.arrow_forward_ios, size: 18),
          ],
        ),
        onTap: () => showDialog(
          context: context,
          builder: (_) => AdminOrderDetails(order: order),
        ),
      ),
    );
  }
} 