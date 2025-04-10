import 'package:get/get.dart';

class ServiceUserProfileControler extends GetxController {
  //
  var isDarkMode = false.obs;
  var showNotifications = true.obs;

  void toggleDarkMode() {
    isDarkMode.value = !isDarkMode.value;
  }

  void toggleNotifications() {
    showNotifications.value = !showNotifications.value;
  }
}
