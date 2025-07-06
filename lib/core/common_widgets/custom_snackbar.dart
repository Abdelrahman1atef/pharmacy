import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../themes/text/text_styles.dart';
import '../../gen/colors.gen.dart';

enum SnackBarType {
  success,
  error,
  warning,
  info,
}

class CustomSnackBar {
  static void show({
    required BuildContext context,
    required String message,
    SnackBarType type = SnackBarType.info,
    Duration duration = const Duration(seconds: 1),
    SnackBarAction? action,
  }) {
    final snackBar = SnackBar(
      content: Row(
        children: [
          // Icon based on type
          Icon(
            _getIcon(type),
            color: Colors.white,
            size: 20.sp,
          ),
          SizedBox(width: 12.w),
          // Message
          Expanded(
            child: Text(
              message,
              style: TextStyles.productHomeTitles.copyWith(
                color: Colors.white,
                fontSize: 14.sp,
              ),
            ),
          ),
        ],
      ),
      backgroundColor: _getBackgroundColor(type),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.r),
      ),
      margin: EdgeInsets.all(16.w),
      elevation: 8,
      duration: duration,
      action: action,
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  static IconData _getIcon(SnackBarType type) {
    switch (type) {
      case SnackBarType.success:
        return Icons.check_circle_outline;
      case SnackBarType.error:
        return Icons.error_outline;
      case SnackBarType.warning:
        return Icons.warning_amber_outlined;
      case SnackBarType.info:
        return Icons.info_outline;
    }
  }

  static Color _getBackgroundColor(SnackBarType type) {
    switch (type) {
      case SnackBarType.success:
        return ColorName.availableTextColor;
      case SnackBarType.error:
        return ColorName.errorTextColor;
      case SnackBarType.warning:
        return Colors.orange;
      case SnackBarType.info:
        return ColorName.secondaryColor;
    }
  }

  // Convenience methods for different types
  static void showSuccess(BuildContext context, String message, {Duration? duration}) {
    show(
      context: context,
      message: message,
      type: SnackBarType.success,
      duration: duration ?? const Duration(seconds: 3),
    );
  }

  static void showError(BuildContext context, String message, {Duration? duration}) {
    show(
      context: context,
      message: message,
      type: SnackBarType.error,
      duration: duration ?? const Duration(seconds: 4),
    );
  }

  static void showWarning(BuildContext context, String message, {Duration? duration}) {
    show(
      context: context,
      message: message,
      type: SnackBarType.warning,
      duration: duration ?? const Duration(seconds: 4),
    );
  }

  static void showInfo(BuildContext context, String message, {Duration? duration}) {
    show(
      context: context,
      message: message,
      type: SnackBarType.info,
      duration: duration ?? const Duration(seconds: 3),
    );
  }
} 