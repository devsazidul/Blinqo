import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ServiceUserProfileControler extends GetxController {
  //
  var isDarkMode = false.obs;
  var showNotifications = true.obs;

  void toggleDarkMode() {
    isDarkMode.value = !isDarkMode.value;
    Get.changeThemeMode(isDarkMode.value ? ThemeMode.dark : ThemeMode.light);
  }

  void toggleNotifications() {
    showNotifications.value = !showNotifications.value;
  }
}
