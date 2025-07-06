import 'package:flutter/material.dart';
import 'package:pharmacy/features/admin/dashboard/data/models/dashboard_response.dart';
import 'package:pharmacy/core/themes/theme_mode/colors.dart';
import 'package:pharmacy/generated/l10n.dart';

class ProductPerformanceWidget extends StatelessWidget {
  final ProductPerformance products;

  const ProductPerformanceWidget({
    super.key,
    required this.products,
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
                const Icon(Icons.inventory, color: AppColors.primary),
                const SizedBox(width: 8),
                Text(
                  S.of(context).productPerformance,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            
            // Top Selling Products
            Text(
              S.of(context).topSellingProducts,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            ...products.topSellingProducts.take(3).map((product) => 
              _buildProductItem(product.productNameEn, product.totalSold.toString(), true)
            ),
            
            const SizedBox(height: 20),
            
            // Out of Stock Products
            Text(
              '${S.of(context).outOfStockProducts} (${S.of(context).lowStockProductsShown(products.outOfStockProductsShown)})',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            ...products.outOfStockProducts.take(3).map((product) => 
              _buildProductItem(_getProductName(product), product.totalStock.toString(), false)
            ),
          ],
        ),
      ),
    );
  }

  String _getProductName(OutOfStockProduct product) {
    // Use English name if available, otherwise use Arabic name
    if (product.productNameEn.isNotEmpty) {
      return product.productNameEn;
    }
    return product.productNameAr;
  }

  Widget _buildProductItem(String name, String value, bool isTopSelling) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(
            isTopSelling ? Icons.trending_up : Icons.warning,
            size: 16,
            color: isTopSelling ? Colors.green : Colors.orange,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              name,
              style: const TextStyle(fontSize: 14),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: isTopSelling ? Colors.green : Colors.orange,
            ),
          ),
        ],
      ),
    );
  }
} 