import 'package:blinqo/core/utils/constants/icon_path.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class SpBookingController extends GetxController {
  RxString price = ''.obs;

  TextEditingController priceController = TextEditingController();

  void updatePrice(String newPrice) {
    price.value = newPrice;
  }

  final List<Map<String, String>> bookingRequests = [
    {
      "title": "Product Launch",
      "location": "Main Auditorium",
      "date": "30-05-2025",
      "time": "1:00 PM",
      "uplogo": IconPath.upcominglogo,
    },
    {
      "title": "Annual Meeting",
      "location": "Conference Room A",
      "date": "15-06-2025",
      "time": "9:30 AM",
      "uplogo": IconPath.teamBuildinglogo,
    },
    {
      "title": "Annual Meeting",
      "location": "Conference Room A",
      "date": "15-06-2025",
      "time": "9:30 AM",
      "uplogo": IconPath.teamBuildinglogo,
    },
    {
      "title": "Annual Meeting",
      "location": "Conference Room A",
      "date": "15-06-2025",
      "time": "9:30 AM",
      "uplogo": IconPath.teamBuildinglogo,
    },
    {
      "title": "Annual Meeting",
      "location": "Conference Room A",
      "date": "15-06-2025",
      "time": "9:30 AM",
      "uplogo": IconPath.teamBuildinglogo,
    },
    {
      "title": "Annual Meeting",
      "location": "Conference Room A",
      "date": "15-06-2025",
      "time": "9:30 AM",
      "uplogo": IconPath.teamBuildinglogo,
    },
    {
      "title": "Annual Meeting",
      "location": "Conference Room A",
      "date": "15-06-2025",
      "time": "9:30 AM",
      "uplogo": IconPath.teamBuildinglogo,
    },
    {
      "title": "Marketing Strategy",
      "location": "Room 203",
      "date": "20-06-2025",
      "time": "3:00 PM",
      "uplogo": IconPath.corporateEventLogo,
    },
  ];
}
