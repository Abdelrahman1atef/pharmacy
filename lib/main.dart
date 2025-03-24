import 'package:flutter/material.dart';
import 'package:pharmacy/pharmacy_app.dart';

import 'core/di/module.dart';

void main(){
  setupDependencies();
  runApp( PharmacyApp());
}