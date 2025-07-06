import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../gen/colors.gen.dart';

class SnackBarTheme {
  static SnackBarThemeData get lightTheme => SnackBarThemeData(
    backgroundColor: ColorName.secondaryColor,
    contentTextStyle: TextStyle(
      color: Colors.white,
      fontSize: 14.sp,
      fontWeight: FontWeight.w500,
    ),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12.r),
    ),
    behavior: SnackBarBehavior.floating,
    elevation: 8,
  );

  static SnackBarThemeData get darkTheme => SnackBarThemeData(
    backgroundColor: ColorName.secondaryColor,
    contentTextStyle: TextStyle(
      color: Colors.white,
      fontSize: 14.sp,
      fontWeight: FontWeight.w500,
    ),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12.r),
    ),
    behavior: SnackBarBehavior.floating,
    elevation: 8,
  );
} 