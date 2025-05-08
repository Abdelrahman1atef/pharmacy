import 'package:flutter/material.dart';

enum TransitionType {
  fade,
  slide,
  scale,
  rotation,
  none,
}

Route<dynamic> navigateWithAnimation({required Widget screen, TransitionType transition = TransitionType.slide,}) {
   return PageRouteBuilder(
      pageBuilder: (_, __, ___) => screen,
      transitionsBuilder: (_, animation, __, child) {
        switch (transition) {
          case TransitionType.fade:
            return FadeTransition(opacity: animation, child: child);
          case TransitionType.scale:
            return ScaleTransition(scale: animation, child: child);
          case TransitionType.rotation:
            return RotationTransition(turns: animation, child: child);
          case TransitionType.none:
            return child;
          case TransitionType.slide:
          default:
            return SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(1.0, 0.0),
                end: Offset.zero,
              ).animate(animation),
              child: child,
            );
        }
      },
  );
}
