import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pharmacy/app_config_provider/auth/logic/auth_cubit.dart';
import 'package:pharmacy/app_config_provider/auth/logic/auth_state.dart';
import 'package:pharmacy/core/controller/network_controller.dart';
import 'package:pharmacy/utils/device_size.dart';
import 'package:provider/provider.dart';
import 'app_config_provider/app_config_provider.dart';
import 'core/routes/app_route.dart';
import 'core/routes/routes.dart';
import 'generated/l10n.dart';

class PharmacyApp extends StatelessWidget {
  const PharmacyApp({super.key});

  @override
  Widget build(BuildContext context) {
    DeviceSize deviceSize = DeviceSize(context);
    NetworkController().onInit();
    return ScreenUtilInit(
        designSize: Size(deviceSize.width, deviceSize.height),
        splitScreenMode: true,
        minTextAdapt: true,
        builder: (context, child) {
          var provider = Provider.of<AppConfigProvider>(context);
          return BlocBuilder<AuthCubit, AuthState>(
            builder: (context, state) {
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                locale: Locale(provider.appLang),
                localizationsDelegates: const [
                  S.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],
                supportedLocales: S.delegate.supportedLocales,
                title: 'Pharmacy App',
                initialRoute: Routes.splash,
                onGenerateRoute: AppRouter.onGenerateRoute,
              );
            },
          );
        }
    );
  }
}

class NoInternetScreen extends StatelessWidget {
  const NoInternetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error, size: 50, color: Colors.red),
            SizedBox(height: 10),
            Text(
              'No internet connection',
              style: TextStyle(fontSize: 18, color: Colors.red),
            ),
          ],
        ),
      ),
    );
  }
}