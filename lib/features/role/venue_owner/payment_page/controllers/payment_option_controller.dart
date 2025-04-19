import 'package:get/get.dart';

class PaymentOptionController extends GetxController{
  RxBool isSelected = false.obs;

  void toggleSelection() {
    isSelected.value = !isSelected.value;
  }
}