import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:device_preview/device_preview.dart';
import 'package:pharmacy/app_bloc_providers.dart';
import 'package:pharmacy/app_config_provider/app_config_provider.dart';
import 'package:pharmacy/pharmacy_app.dart';
import 'package:provider/provider.dart';
import 'app_config_provider/cashe_helper.dart';
import 'core/di/module.dart';
import 'core/db/cache/cache_manager.dart';
import 'firebase_options.dart';
import 'package:pharmacy/core/notifications/notification_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await NotificationService.initialize();
  await CashHelper.init();
  
  // Initialize cache manager
  await CacheManager().initialize();
  
  setupDependencies();

  runApp(
    DevicePreview(
      enabled: false, // Set to false for production
      builder: (context) => Phoenix(
        child: ChangeNotifierProvider(
          create: (context) => AppConfigProvider(),
          child: Builder(
            builder: (context) {
              // Example: call FCM init after login and token retrieval
              // fcmService.initFCM(context);
              return const AppBlocProviders(
                child: PharmacyApp(),
              );
            },
          ),
        ),
      ),
    ),
  );
}

