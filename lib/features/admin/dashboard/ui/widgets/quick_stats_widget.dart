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
        
        print('Grid layout: $crossAxisCount columns');
        print('Available width: ${constraints.maxWidth}, height: ${constraints.maxHeight}');
        
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
            SizedBox(
              width: double.infinity,
              child: GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: crossAxisCount,
                crossAxisSpacing: 15,
                mainAxisSpacing: 15,
                childAspectRatio: _calculateAspectRatio(constraints.maxWidth, crossAxisCount),
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
            ),
          ],
        );
      },
    );
  }

  int _getCrossAxisCount(double width) {
    print('QuickStatsWidget width: $width');
    
    if (width < 450) {
      print('Using 1 column for width: $width');
      return 1;
    }
    if (width < 500) {
      print('Using 2 columns for width: $width');
      return 2;
    }
    if (width < 900) {
      print('Using 3 columns for width: $width');
      return 3;
    }
    if (width < 1200) {
      print('Using 4 columns for width: $width');
      return 4;
    }
    print('Using 5 columns for width: $width');
    return 5;
  }

  double _calculateAspectRatio(double width, int crossAxisCount) {
    // Calculate available width per card (accounting for spacing)
    double availableWidth = width - (12 * (crossAxisCount - 1)); // Subtract spacing
    double cardWidth = availableWidth / crossAxisCount;
    
    // Calculate optimal aspect ratio based on content needs
    double aspectRatio;
    
    if (crossAxisCount == 1) {
      aspectRatio = 3.0; // Taller for single column
    } else if (crossAxisCount == 2) {
      aspectRatio = 2.5; // Good balance for 2 columns
    } else if (crossAxisCount == 3) {
      aspectRatio = 2.0; // Slightly shorter for 3 columns
    } else if (crossAxisCount == 4) {
      aspectRatio = 1.8; // Compact for 4 columns
    } else {
      aspectRatio = 1.5; // Very compact for 5+ columns
    }
    
    print('Card width: $cardWidth, Aspect ratio: $aspectRatio');
    return aspectRatio;
  }

  Widget _buildStatCard(BuildContext context, String title, String value, IconData icon, Color color) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Calculate responsive sizes based on card dimensions
        double cardWidth = constraints.maxWidth;
        double cardHeight = constraints.maxHeight;
        
        // Calculate optimal sizes based on available space
        double iconSize = _calculateIconSize(cardWidth, cardHeight);
        double valueFontSize = _calculateValueFontSize(cardWidth, cardHeight);
        double titleFontSize = _calculateTitleFontSize(cardWidth, cardHeight);
        double padding = _calculatePadding(cardWidth);
        double spacing = _calculateSpacing(cardWidth);
        
        print('Card dimensions: ${cardWidth.toStringAsFixed(1)}x${cardHeight.toStringAsFixed(1)}');
        print('Sizes - Icon: $iconSize, Value: $valueFontSize, Title: $titleFontSize');
        
        return Card(
          elevation: 4,
          child: Container(
            padding: EdgeInsets.all(padding),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Icon
                Icon(icon, size: iconSize, color: color),
                SizedBox(height: spacing),
                
                // Value
                Text(
                  value,
                  style: TextStyle(
                    fontSize: valueFontSize,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
                
                SizedBox(height: spacing / 2),
                
                // Title
                Text(
                  title,
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: titleFontSize,
                  ),
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  double _calculateIconSize(double width, double height) {
    double minDimension = width < height ? width : height;
    if (minDimension < 80) return 16;
    if (minDimension < 120) return 20;
    if (minDimension < 150) return 24;
    return 28;
  }

  double _calculateValueFontSize(double width, double height) {
    double minDimension = width < height ? width : height;
    if (minDimension < 80) return 14;
    if (minDimension < 120) return 16;
    if (minDimension < 150) return 18;
    return 22;
  }

  double _calculateTitleFontSize(double width, double height) {
    double minDimension = width < height ? width : height;
    if (minDimension < 80) return 8;
    if (minDimension < 120) return 10;
    if (minDimension < 150) return 11;
    return 12;
  }

  double _calculatePadding(double width) {
    if (width < 100) return 6;
    if (width < 150) return 8;
    return 12;
  }

  double _calculateSpacing(double width) {
    if (width < 100) return 2;
    if (width < 150) return 4;
    return 6;
  }
} 