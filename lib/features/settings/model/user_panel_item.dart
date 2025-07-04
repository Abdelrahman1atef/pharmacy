import 'dart:ui';

import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
class UserPanelItem{
  final bool? toStaff;
  final SvgPicture icon ;
  final String title;
  final VoidCallback? function;

  UserPanelItem(  {required this.icon, this.toStaff=false,
    required this.title,
    required this.function,
  });
}
