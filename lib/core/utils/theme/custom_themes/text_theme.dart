import 'package:get/get.dart';

class ThemeController extends GetxController {
  // Observable for dark mode
  var isDarkMode = false.obs;

  // Method to toggle between dark and light mode
  void toggleTheme() {
    isDarkMode.value = !isDarkMode.value;
  }
}
