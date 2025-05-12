import 'package:get/get.dart';

class EventPaymentController extends GetxController {
  RxInt selectedIndex = (-1).obs; // -1 means no selection initially

  void selectPaymentOption(int index) {
    selectedIndex.value = index; // Update the selected index
  }
}
