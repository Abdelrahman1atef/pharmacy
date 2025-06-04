import 'dart:ui';

import 'package:flutter_svg/svg.dart';

class AdminPanelItem {
  final String title;
  final SvgPicture svgImage;
  final String route;
  final VoidCallback? function;

  AdminPanelItem({
    required this.title,
    required this.svgImage,
    required this.route,
    required this.function,
  });
}
