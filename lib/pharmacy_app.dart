import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pharmacy/utils/device_size.dart';
import 'core/routes/app_route.dart';
import 'core/routes/routes.dart';

class PharmacyApp extends StatelessWidget {
    const PharmacyApp({super.key});
  @override
  Widget build(BuildContext context) {
    DeviceSize deviceSize = DeviceSize(context);

    return ScreenUtilInit(
      designSize:  Size(deviceSize.width, deviceSize.height),
      splitScreenMode: true,
      minTextAdapt: true,
      builder: (context, child) => MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Movie App',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSwatch(
              primarySwatch: Colors.deepPurple,
            ),
            useMaterial3: true,
          ),
          initialRoute: Routes.main,
          onGenerateRoute: AppRouter.onGenerateRoute,
        ),
    );
  }
}
