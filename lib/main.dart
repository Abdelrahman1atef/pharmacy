import 'package:flutter/material.dart';
import 'package:pharmacy/app_bloc_providers.dart';
import 'package:pharmacy/app_config_provider/app_config_provider.dart';
import 'package:pharmacy/pharmacy_app.dart';
import 'package:provider/provider.dart';

import 'app_config_provider/cashe_helper.dart';
import 'core/di/module.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CashHelper.init();
  setupDependencies();
  runApp(ChangeNotifierProvider(
    create: (context) => AppConfigProvider(),
    child: const AppBlocProviders(child: PharmacyApp()),
  ));
}
