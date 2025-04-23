import 'package:get/get.dart';

class EventPaymentController extends GetxController {
  RxBool isSelected = false.obs;

  void toggleSelection() {
    isSelected.value = !isSelected.value;
  }
}
