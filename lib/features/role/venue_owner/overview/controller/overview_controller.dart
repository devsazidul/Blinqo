import 'package:get/get.dart';

class OverviewController extends GetxController {
  var isPayment = false.obs;
  var percentage = 12.5.obs;
  var totalRevenue = 92500.0.obs;
  var totalEarnings = 20500.0.obs;
  var totalBookings = 5.obs;

  void confirmPayment(){
    isPayment.value = true;
  }
}
