import 'package:flutter/material.dart';
import 'package:pharmacy/features/admin/dashboard/data/models/dashboard_response.dart';
import 'package:pharmacy/core/themes/theme_mode/colors.dart';
import 'package:pharmacy/generated/l10n.dart';

class SalesOverviewWidget extends StatelessWidget {
  final SalesOverview sales;

  const SalesOverviewWidget({
    super.key,
    required this.sales,
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
                const Icon(Icons.trending_up, color: AppColors.primary),
                const SizedBox(width: 8),
                Text(
                  S.of(context).salesOverview,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: _buildSalesMetric(
                    context,
                    S.of(context).totalOrders,
                    sales.totalOrders.toString(),
                    Icons.shopping_cart,
                  ),
                ),
                Expanded(
                  child: _buildSalesMetric(
                    context,
                    S.of(context).totalRevenue,
                    '\$${sales.totalRevenue.toStringAsFixed(2)}',
                    Icons.attach_money,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _buildSalesMetric(
                    context,
                    S.of(context).recentOrders,
                    sales.recentOrdersCount.toString(),
                    Icons.recent_actors,
                  ),
                ),
                Expanded(
                  child: _buildSalesMetric(
                    context,
                    S.of(context).avgOrderValue,
                    '\$${sales.avgOrderValue.toStringAsFixed(2)}',
                    Icons.analytics,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSalesMetric(BuildContext context, String label, String value, IconData icon) {
    return Column(
      children: [
        Icon(icon, size: 24, color: AppColors.primary),
        const SizedBox(height: 8),
        Text(
          value,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: AppColors.primary,
          ),
        ),
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: Colors.grey[600],
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
} 