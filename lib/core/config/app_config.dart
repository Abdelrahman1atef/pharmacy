class AppConfig {
  // Base URLs
  static const String apiBaseUrl = 'https://locust-eminent-urchin.ngrok-free.app/';
  static const String webBaseUrl = 'https://locust-eminent-urchin.ngrok-free.app/';
  
  // Sharing configuration
  static const String shareBaseUrl = webBaseUrl;
  static const String productSharePath = '/product/';
  
  // App information for sharing
  static const String appName = 'Pharmacy App';
  static const String appDescription = 'Your trusted pharmacy companion';
  
  // Social media and sharing
  static const String shareMessageTemplate = '''
🔔 Check out this amazing product!

📦 {productName}
💰 Price: {price} EGP
🔗 View details: {productUrl}

Get it now from our pharmacy app! 💊
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