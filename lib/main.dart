import 'package:flutter/material.dart';
import 'package:pharmacy/app_bloc_providers.dart';
import 'package:pharmacy/pharmacy_app.dart';

import 'core/di/module.dart';

void main() {
  setupDependencies();
  runApp( const AppBlocProviders(child: PharmacyApp()));

}
