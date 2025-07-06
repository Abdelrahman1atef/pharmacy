import 'package:flutter/material.dart';
import 'package:pharmacy/features/admin/dashboard/data/models/dashboard_response.dart';
import 'package:pharmacy/core/themes/theme_mode/colors.dart';
import 'package:pharmacy/generated/l10n.dart';

class OrderStatusWidget extends StatelessWidget {
  final OrderStatusDistribution status;

  const OrderStatusWidget({
    super.key,
    required this.status,
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
                const Icon(Icons.assignment, color: AppColors.primary),
                const SizedBox(width: 8),
                Text(
                  S.of(context).orderStatusDistribution,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            _buildStatusItem(S.of(context).pending, status.pending, Colors.orange),
            _buildStatusItem(S.of(context).preparing, status.preparing, Colors.blue),
            _buildStatusItem(S.of(context).shipped, status.shipped, Colors.purple),
            _buildStatusItem(S.of(context).delivered, status.delivered, Colors.green),
            _buildStatusItem(S.of(context).cancelled, status.cancelled, Colors.red),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusItem(String status, int count, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Container(
            width: 12,
            height: 12,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(6),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              status,
              style: const TextStyle(fontSize: 16),
            ),
          ),
          Text(
            count.toString(),
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
} 