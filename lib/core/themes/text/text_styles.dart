import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pharmacy/gen/colors.gen.dart';
import 'package:pharmacy/gen/fonts.gen.dart';

class TextStyles {
  static TextStyle get appTitle => TextStyle(
      fontSize: 20.sp,
      fontFamily: FontFamily.cairo,
      fontWeight: FontWeight.bold,
      fontStyle: FontStyle.italic,
      color: ColorName.whiteColor);

  static TextStyle get welcomeText => TextStyle(
      fontSize: 20.sp,
      fontFamily: FontFamily.cairo,
      fontWeight: FontWeight.bold,
      color: ColorName.whiteColor);

  static TextStyle get bottomNavLabel => TextStyle(
      fontSize: 15.sp,
      fontFamily: FontFamily.cairo,
      fontWeight: FontWeight.normal
  );

  static TextStyle get sectionTitles => TextStyle(
      fontSize: 17.sp,
      fontFamily: FontFamily.cairo,
      fontWeight: FontWeight.bold);

  static TextStyle get showAllText => TextStyle(
      fontSize: 17.sp,
      fontFamily: FontFamily.cairo,
      fontWeight: FontWeight.w900,
      color: ColorName.secondaryColor);

  static TextStyle get bestSellerText => TextStyle(
        fontSize: 15.sp,
        fontFamily: FontFamily.cairo,
        color: ColorName.whiteColor,
        fontWeight: FontWeight.bold,
      );

  static TextStyle get productTitles => TextStyle(
        fontSize: 18.sp,
        fontFamily: FontFamily.cairo,
        color: ColorName.blackColor,
        fontWeight: FontWeight.bold,
      );
  static TextStyle get availabilityText => TextStyle(
        fontSize: 13.sp,
        fontFamily: FontFamily.cairo,
        color: ColorName.availableTextColor,
        fontWeight: FontWeight.normal,
      );
  static TextStyle get unavailabilityText => TextStyle(
        fontSize: 13.sp,
        fontFamily: FontFamily.cairo,
        color: ColorName.errorTextColor,
        fontWeight: FontWeight.normal,
      );
  static TextStyle get productSubTitles => TextStyle(
        fontSize: 18.sp,
        fontFamily: FontFamily.cairo,
        color: ColorName.blackColor,
        fontWeight: FontWeight.normal,
      );
  static TextStyle get productDetailTitles => TextStyle(
        fontSize: 15.sp,
        fontFamily: FontFamily.cairo,
        color: ColorName.productDetailTextColor,
        fontWeight: FontWeight.bold,
      );
  static TextStyle get productBrandName => TextStyle(
        fontSize: 13.sp,
        fontFamily: FontFamily.cairo,
        color: ColorName.secondaryColor,
        fontWeight: FontWeight.normal,
      );
  static TextStyle get productUnitName => TextStyle(
        fontSize: 13.sp,
        fontFamily: FontFamily.cairo,
        color: ColorName.productDetailTextColor,
        fontWeight: FontWeight.normal,
      );
  static TextStyle get productHomeTitles => TextStyle(
        fontSize: 14.sp,
        fontFamily: FontFamily.cairo,
        color: ColorName.blackColor,
        fontWeight: FontWeight.normal,
      );
  static TextStyle get productPriceHomeTitles => TextStyle(
        fontSize: 14.sp,
        fontFamily: FontFamily.cairo,
        color: ColorName.blackColor,
        fontWeight: FontWeight.bold,
      );
  static TextStyle get cartProductType => TextStyle(
    fontSize: 15.sp,
    fontFamily: FontFamily.cairo,
    color: ColorName.secondaryColor,
    fontWeight: FontWeight.bold,
  );
  static TextStyle get cartProductPrice => TextStyle(
    fontSize: 15.sp,
    fontFamily: FontFamily.cairo,
    color: ColorName.primaryColor,
    fontWeight: FontWeight.bold,
  );
  static TextStyle get cartConfirmationDialog => TextStyle(
    fontSize: 15.sp,
    fontFamily: FontFamily.cairo,
    fontWeight: FontWeight.bold,
  );

  static TextStyle get cartCheckout => TextStyle(
    fontSize: 15.sp,
    fontFamily: FontFamily.cairo,
    color: ColorName.primaryColor,
    fontWeight: FontWeight.bold,
  );
  static TextStyle get settingsTitle => TextStyle(
    fontSize: 20.sp,
    fontFamily: FontFamily.cairo,
    color: ColorName.blackColor,
    fontWeight: FontWeight.bold,
  );
  static TextStyle get loginSignupText => TextStyle(
    fontSize: 15.sp,
    fontFamily: FontFamily.cairo,
    fontWeight: FontWeight.normal,
  );
  static TextStyle get gradientElevatedButtonText => TextStyle(
    color: ColorName.whiteColor,
    fontFamily: FontFamily.cairo,
    fontSize: 12.sp,
    fontWeight: FontWeight.bold,
  );
}
