import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:pharmacy/core/models/product/product_response.dart';
import 'package:pharmacy/core/config/app_config.dart';

class ShareService {
  /// Share product using native share sheet (shows all available apps)
  static Future<void> shareProduct({
    required Results product,
    BuildContext? context,
  }) async {
    try {
      final productUrl = AppConfig.generateProductShareUrl(product.productId!);
      final productName = product.productNameAr ?? product.productNameEn ?? 'Product';
      final price = product.sellPrice?.toString() ?? '';
      
      final message = '''
🔔 Check out this product!

📦 $productName
💰 Price: $price EGP
🔗 $productUrl

Get it now from our Razy Pharmacy app! 💊
''';
      
      // Use native share sheet to show all available apps
      await Share.share(
        message,
        subject: productName,
      );
    } catch (e) {
      print('Error sharing product: $e');
      if (context != null && context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Failed to share product. Please try again.'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  /// Share product URL only using native share sheet
  static Future<void> shareProductUrl({
    required Results product,
    BuildContext? context,
  }) async {
    try {
      final productUrl = AppConfig.generateProductShareUrl(product.productId!);
      
      // Use native share sheet to show all available apps
      await Share.share(
        productUrl,
        subject: 'Product Link',
      );
    } catch (e) {
      print('Error sharing product URL: $e');
      if (context != null && context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Failed to share product link. Please try again.'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }
} 