
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../gen/colors.gen.dart';

class GradientElevatedButton extends StatelessWidget {
  static const List<Color> defaultGradientColors=[
    ColorName.secondaryColor,
    ColorName.primaryColor
  ];
  final VoidCallback? onPressed;
  final Widget child;
  final List<Color>? gradientColors;
  final bool haveBorder;
  const GradientElevatedButton({
    super.key,
    required this.onPressed,
    required this.child,
    this.gradientColors =defaultGradientColors,
    this.haveBorder=false
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 44.h,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all(Colors.transparent),
          shadowColor: WidgetStateProperty.all(Colors.transparent),
          padding: WidgetStateProperty.all(EdgeInsets.zero),
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
              side:haveBorder? const BorderSide(color: Colors.blue,width: 1):BorderSide.none,// Adjust border radius
            ),
          ),
        ),
        child: Ink(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: gradientColors!, // Define your gradient colors
            ),
            borderRadius: BorderRadius.circular(30), // Match the border radius
          ),
          child: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            child: child
          ),
        ),
      ),
    );
  }
}