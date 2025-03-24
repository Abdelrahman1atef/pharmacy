import 'package:flutter/material.dart';

class DeviceSize {
  // Singleton instance
  static final DeviceSize _instance = DeviceSize._internal();
  factory DeviceSize(BuildContext context) {
    _instance._initialize(context);
    return _instance;
  }

  DeviceSize._internal();

  late double _deviceHeight;
  late double _deviceWidth;
  late double _topPadding;

  void _initialize(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    _topPadding = MediaQuery.of(context).padding.top;
  }

  double get height => _deviceHeight;
  double get width => _deviceWidth;
  double get topPadding => _topPadding;
}