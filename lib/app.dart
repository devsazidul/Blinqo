import 'package:blinqo/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'core/bindings/controller_binder.dart';
import 'core/utils/theme/custom_themes/text_theme.dart';
import 'core/utils/theme/theme.dart';

class Blinqo extends StatelessWidget {
  const Blinqo({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return Obx(() {
          final themeController = Get.find<ThemeController>();
          return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            builder: (context, child) {
              child = EasyLoading.init()(context, child);
              return child;
            },
            initialRoute: AppRoute.getsplashoScreen(),
            getPages: AppRoute.routes,
            initialBinding: ControllerBinder(),
            themeMode:
                themeController.isDarkMode.value
                    ? ThemeMode.dark
                    : ThemeMode.light,
            // Specify both themes here
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
          );
        });
      },
    );
  }
}
