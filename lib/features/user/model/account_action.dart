import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AccountAction {
  final SvgPicture? icon;
  final Text text;
  final void Function()? action;

  AccountAction({this.icon,required this.action, required this.text});
}