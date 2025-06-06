import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pharmacy/utils/device_size.dart';
import 'package:provider/provider.dart';
import 'app_config_provider/app_config_provider.dart';
import 'app_config_provider/logic/auth/logic/auth_cubit.dart';
import 'app_config_provider/logic/auth/logic/auth_state.dart';
import 'core/routes/app_route.dart';
import 'core/routes/routes.dart';
import 'generated/l10n.dart';

class PharmacyApp extends StatelessWidget {
  const PharmacyApp({super.key});

  @override
  Widget build(BuildContext context) {
    DeviceSize deviceSize = DeviceSize(context);
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
