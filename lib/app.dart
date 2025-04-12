import 'package:blinqo/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'core/bindings/controller_binder.dart';
import 'core/utils/theme/custom_themes/text_theme.dart';
import 'core/utils/theme/theme.dart';

class Blinqo extends StatelessWidget {
  const Blinqo({super.key});

  @override
  Widget build(BuildContext context) {
    // Bind the ThemeController here
    Get.put(ThemeController());

    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          initialRoute: AppRoute.getsplashoScreen(),
          getPages: AppRoute.routes,
          initialBinding: ControllerBinder(),
          theme: AppTheme.lightTheme, // Light theme applied here
          darkTheme: AppTheme.darkTheme, // Dark theme applied here
        );
      },
    );
  }
}
