import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:pharmacy/app_bloc_providers.dart';
import 'package:pharmacy/app_config_provider/app_config_provider.dart';
import 'package:pharmacy/pharmacy_app.dart';
import 'package:provider/provider.dart';

import 'app_config_provider/cashe_helper.dart';
import 'core/di/module.dart';
import 'features/offline/ui/initial_check_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CashHelper.init();
  setupDependencies();
  runApp(Phoenix(
    child: ChangeNotifierProvider(
      create: (context) => AppConfigProvider(),
      child: const AppBlocProviders(child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: InitialCheckScreen(), // Start with server check
      ),),
    ),
  ));
}

