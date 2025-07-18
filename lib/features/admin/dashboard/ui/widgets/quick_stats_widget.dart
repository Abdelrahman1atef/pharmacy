import 'package:flutter/material.dart';
import 'package:pharmacy/features/admin/dashboard/data/models/dashboard_response.dart';
import 'package:pharmacy/core/themes/theme_mode/colors.dart';
import 'package:pharmacy/generated/l10n.dart';

class QuickStatsWidget extends StatelessWidget {
  final QuickStats stats;

  const QuickStatsWidget({
    super.key,
    required this.stats,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Determine grid layout based on available width
        int crossAxisCount = _getCrossAxisCount(constraints.maxWidth);
        double childAspectRatio = _getChildAspectRatio(constraints.maxWidth);
        
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              S.of(context).quickOverview,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
              ),
            ),
            const SizedBox(height: 16),
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: crossAxisCount,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: childAspectRatio,
              children: [
                _buildStatCard(
                  context,
                  S.of(context).pendingOrders,
                  stats.pendingOrders.toString(),
                  Icons.pending,
                  Colors.orange,
                ),
                _buildStatCard(
                  context,
                  S.of(context).deliveredOrders,
                  stats.deliveredOrders.toString(),
                  Icons.check_circle,
                  Colors.green,
                ),
                _buildStatCard(
                  context,
                  S.of(context).totalProducts,
                  stats.totalProducts.toString(),
                  Icons.inventory,
                  Colors.blue,
                ),
                _buildStatCard(
                  context,
                  S.of(context).outOfStock,
                  stats.outOfStockProducts.toString(),
                  Icons.warning,
                  Colors.red,
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  int _getCrossAxisCount(double width) {
    if (width < 400) return 1;      // Very small screens
    if (width < 600) return 2;      // Small screens
    if (width < 900) return 3;      // Medium screens
    return 4;                       // Large screens
  }

  double _getChildAspectRatio(double width) {
    if (width < 400) return 2.5;    // Taller cards for narrow screens
    if (width < 600) return 2.0;    // Medium height
    if (width < 900) return 1.8;    // Slightly shorter
    return 1.5;                     // Standard ratio for large screens
  }

  Widget _buildStatCard(BuildContext context, String title, String value, IconData icon, Color color) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Adjust font sizes based on available space
        double iconSize = constraints.maxWidth < 120 ? 24 : 32;
        double valueFontSize = constraints.maxWidth < 120 ? 18 : 24;
        double titleFontSize = constraints.maxWidth < 120 ? 10 : 12;
        
        return Card(
          elevation: 4,
          child: Container(
            padding: EdgeInsets.all(constraints.maxWidth < 120 ? 8 : 12),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, size: iconSize, color: color),
                SizedBox(height: constraints.maxWidth < 120 ? 4 : 8),
                Flexible(
                  child: Text(
                    value,
                    style: TextStyle(
                      fontSize: valueFontSize,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                SizedBox(height: constraints.maxWidth < 120 ? 2 : 4),
                Flexible(
                  child: Text(
                    title,
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: titleFontSize,
                    ),
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
} 