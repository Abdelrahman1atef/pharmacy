import 'package:share_plus/share_plus.dart';
import 'package:pharmacy/core/models/product/product_response.dart';
import 'package:pharmacy/generated/l10n.dart';

class ShareService {
  /// Share product information with a generated URL
  static Future<void> shareProduct({
    required Results product,
    required String baseUrl,
    String? customMessage,
  }) async {
    try {
      // Generate product URL
      final productUrl = _generateProductUrl(product, baseUrl);
      
      // Create share message
      final message = customMessage ?? _generateDefaultMessage(product, productUrl);
      
      // Share the content
      await Share.share(
        message,
        subject: product.productNameAr ?? product.productNameEn ?? 'Product',
      );
    } catch (e) {
      // Handle any errors that might occur during sharing
      print('Error sharing product: $e');
    }
  }

  /// Generate a product URL based on the product ID
  static String _generateProductUrl(Results product, String baseUrl) {
    // Remove trailing slash if present
    final cleanBaseUrl = baseUrl.endsWith('/') 
        ? baseUrl.substring(0, baseUrl.length - 1) 
        : baseUrl;
    
    return '$cleanBaseUrl/product/${product.productId}';
  }

  /// Generate a default share message
  static String _generateDefaultMessage(Results product, String productUrl) {
    final productName = product.productNameAr ?? product.productNameEn ?? 'Product';
    final price = product.sellPrice?.toString() ?? '';
    
    return '''
🔔 Check out this amazing product!

📦 $productName
💰 Price: $price EGP
🔗 View details: $productUrl

Get it now from our pharmacy app! 💊
''';
  }

  /// Share product with custom message
  static Future<void> shareProductWithCustomMessage({
    required Results product,
    required String baseUrl,
    required String customMessage,
  }) async {
    await shareProduct(
      product: product,
      baseUrl: baseUrl,
      customMessage: customMessage,
    );
  }
} 