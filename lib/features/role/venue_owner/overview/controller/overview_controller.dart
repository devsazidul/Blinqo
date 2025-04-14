import 'package:blinqo/core/utils/constants/image_path.dart' show ImagePath;
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

  List<Map<String, String>> reviews = [
      {
        "title": "Corporate Event",
        "subtitle": "Conference Hall",
        "date": "15 March,2025",
        "time": "3.00 PM",
        "image": ImagePath.event,
        "status": "Confirmed",
      },
      {
        "title": "Team Building Retreat",
        "subtitle": "Lakeside Lodge",
        "date": "22 April,2025",
        "time": "10.00 AM",
        "image": ImagePath.event2,
        "status": "Pending",
      },
      {
        "title": "Product Launch",
        "subtitle": "Main Auditorium",
        "date": "30 May,2025",
        "time": "1:00 PM",
        "image": ImagePath.event3,
        "status": "Confirmed",
      },
    ];
}
