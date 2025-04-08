import 'package:get/get.dart';

class OverviewController extends GetxController {
  var isPayment = false.obs;

  void confirmPayment(){
    isPayment.value = true;
  }
}
