import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ThemeController extends GetxController {
  Rx<ThemeMode> themeMode = ThemeMode.light.obs;

  // Function to set the theme mode and persist it
  void setThemeMode(ThemeMode mode) async {
    themeMode.value = mode;
    // Apply theme change to the app
    Get.changeThemeMode(mode);

    update();
  }
}
