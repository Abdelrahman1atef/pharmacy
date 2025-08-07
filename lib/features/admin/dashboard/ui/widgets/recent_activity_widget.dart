import 'package:flutter/material.dart';
import 'package:pharmacy/core/enum/order_status.dart';
import 'package:pharmacy/features/admin/dashboard/data/models/dashboard_response.dart';
import 'package:pharmacy/core/themes/theme_mode/colors.dart';
import 'package:pharmacy/generated/l10n.dart';

class RecentActivityWidget extends StatelessWidget {
  final RecentActivity activity;

  const RecentActivityWidget({
    super.key,
    required this.activity,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.history, color: AppColors.primary),
                const SizedBox(width: 8),
                Text(
                  S.of(context).recentActivity,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            ...activity.recentOrders.take(5).map((order) => 
              _buildOrderItem(context, order)
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderItem(BuildContext context, RecentOrder order) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Container(
            width: 40,      
            height: 40,
            decoration: BoxDecoration(
              color: order.status.getStatusColor(),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Icon(
              Icons.shopping_cart,
              color: Colors.white,
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  order.customerName,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  S.of(context).orderNumber(order.orderId.toString()),
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '\$${order.totalAmount.toStringAsFixed(2)}',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              Text(
                order.getStatusText (context),
                style: TextStyle(
                  fontSize: 10,
                  color: order.status.getStatusColor(),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
} 