import 'package:get/get.dart';

class SpPaymentOptionController extends GetxController{ 
  var isPaymentMethodAdded = false.obs;
  void togglePaymentMethod(){
    isPaymentMethodAdded.value = !isPaymentMethodAdded.value;
  }
}