# Product Sharing Feature

## Overview
This feature allows users to share product information with other users through various sharing options. The implementation uses the `share_plus` package to provide native sharing functionality.

## Features

### 1. Multiple Sharing Options
- **Share with Details**: Full product information including name, price, availability, and URL
- **Share Link Only**: Just the product URL
- **Share as Promotion**: Promotional message with special offer styling
- **Simple Share**: Product name and link only

### 2. Share Options Dialog
A user-friendly dialog that presents all sharing options with icons and descriptions.

### 3. Error Handling
- Graceful error handling with user feedback
- Fallback options if sharing fails
- Context-aware error messages

## Implementation Details

### Files Created/Modified

1. **`lib/core/services/share_service.dart`**
   - Main sharing service with multiple sharing methods
   - Error handling and user feedback
   - Configurable message templates

2. **`lib/core/config/app_config.dart`**
   - App-wide configuration for sharing URLs
   - Message templates and app information
   - URL generation utilities

3. **`lib/core/widgets/share_options_dialog.dart`**
   - User interface for sharing options
   - Multiple sharing methods with descriptions
   - Material Design compliant dialog

4. **`lib/features/details/ui/widgets/product_info_section.dart`**
   - Updated share button to show options dialog
   - Integration with sharing service

5. **`pubspec.yaml`**
   - Added `share_plus: ^7.2.1` dependency

### Usage

#### Basic Sharing
```dart
// Share product with default message
await ShareService.shareProduct(
  product: product,
  context: context,
);
```

#### Share with Context
```dart
// Share with availability status
await ShareService.shareProductWithContext(
  product: product,
  context: context,
  additionalInfo: 'Limited time offer!',
);
```

#### Share Options Dialog
```dart
// Show sharing options dialog
showDialog(
  context: context,
  builder: (context) => ShareOptionsDialog(
    product: product,
  ),
);
```

## Configuration

### Base URL Configuration
The sharing URLs are configured in `lib/core/config/app_config.dart`:

```dart
static const String shareBaseUrl = 'https://locust-eminent-urchin.ngrok-free.app/';
static const String productSharePath = '/product/';
```

### Message Templates
Customizable message templates are available in the app config:

```dart
static const String shareMessageTemplate = '''
🔔 Check out this amazing product!

📦 {productName}
💰 Price: {price} EGP
🔗 View details: {productUrl}

Get it now from our pharmacy app! 💊
''';
```

## Generated URLs

Product URLs follow this pattern:
```
https://locust-eminent-urchin.ngrok-free.app/product/{productId}
```

## Error Handling

The sharing service includes comprehensive error handling:
- Network connectivity issues
- Platform-specific sharing limitations
- User feedback through SnackBar messages
- Graceful fallbacks

## Testing

To test the sharing functionality:

1. Navigate to any product details page
2. Tap the share icon (top-right corner)
3. Choose from the available sharing options
4. Verify that the share sheet appears with the correct content

## Future Enhancements

1. **Deep Linking**: Implement deep linking to open shared product URLs directly in the app
2. **Analytics**: Track sharing events for analytics
3. **Custom Messages**: Allow users to customize share messages
4. **Social Media Integration**: Direct sharing to specific social platforms
5. **QR Code Generation**: Generate QR codes for product URLs

## Dependencies

- `share_plus: ^7.2.1` - Native sharing functionality
- `flutter` - Core Flutter framework
- `flutter_bloc` - State management (for context)

## Platform Support

The sharing feature works on:
- Android (native share sheet)
- iOS (native share sheet)
- Web (browser share API)
- Desktop (system share dialog) 