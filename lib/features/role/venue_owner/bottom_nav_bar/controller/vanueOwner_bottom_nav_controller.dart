// ignore_for_file: file_names

import 'package:get/get.dart';

class VanueOwnerBottomNavController extends GetxController {
  var currentIndex = 0.obs;
  void changeIndex(int index) {
    currentIndex.value = index;
  }
}
