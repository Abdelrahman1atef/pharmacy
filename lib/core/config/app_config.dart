import 'package:pharmacy/core/network/constant.dart';

class AppConfig {
  // Base URLs
  static  String apiBaseUrl = Constant.baseUrl;
  static const String webBaseUrl =Constant.baseUrl;
  
  // Sharing configuration
  static const String shareBaseUrl = webBaseUrl;
  static const String productSharePath = Constant.productDetailsEndPoint;
  
  // App information for sharing
  static const String appName = 'Pharmacy App';
  static const String appDescription = 'Your trusted pharmacy companion';
  
  // Social media and sharing
  static const String shareMessageTemplate = '''
🔔 Check out this product!

📦 {productName}
💰 Price: {price} EGP
🔗 {productUrl}

Get it now from our Razy Pharmacy app! 💊
''';
  
  // Generate product share URL
  static String generateProductShareUrl(int productId) {
    return '$shareBaseUrl$productSharePath$productId';
  }
  
  // Generate share message
  static String generateShareMessage({
    required String productName,
    required String price,
    required String productUrl,
  }) {
    return shareMessageTemplate
        .replaceAll('{productName}', productName)
        .replaceAll('{price}', price)
        .replaceAll('{productUrl}', productUrl);
  }
} 