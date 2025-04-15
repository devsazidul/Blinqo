import 'package:blinqo/core/utils/constants/icon_path.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class SpHomeController extends GetxController {
  var hasdata = false.obs;
  var selectedDate = DateTime.now().obs;
  var currentPageIndex = 0.obs;
  final PageController pageController = PageController();
  void updateSelectedDate(DateTime date) {
    selectedDate.value = date;
  }

  void updateDataStatus(bool status) {
    hasdata.value = status;
  }

  void setPage(int index) {
    currentPageIndex.value = index;
  }

  final List<Map<String, String>> bookings = [
    {
      "title": "Jhon’s Birth Day",
      "description":
          "Today Is My Friend Jhon's Birthday. I Want To\nWish Him And Also Surprise Him",
      "day": "Thursday",
      "date": "15-12-2025",
    },
    {
      "title": "Jack Sparrow Waidign",
      "description":
          "The deadline for my current project is\n coming up, need to wrap things up.",
      "day": "Saturday",
      "date": "18-12-2025",
    },
    {
      "title": "Devi Jhones er Khatna",
      "description":
          "The deadline for my current project is\n coming up, need to wrap things up.",
      "day": "Monday",
      "date": "20-12-2025",
    },
  ];
  final List<Map<String, String>> upcomingProjects = [
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
      "title": "Marketing Strategy",
      "location": "Room 203",
      "date": "20-06-2025",
      "time": "3:00 PM",
      "uplogo": IconPath.corporateEventLogo,
    },
  ];
  final List<Map<String, String>> projectRequests = [
    {
      "title": "Corporate Event",
      "location": "The Grand Hall",
      "date": "15 March,2025",
      "time": "3:00 PM",
      "logo": IconPath.corporateEventLogo,
    },
    {
      "title": "Product Launch",
      "location": "Skyview Pavilion",
      "date": "22 March,2025",
      "time": "10:00 AM",
      "logo": IconPath.productLaunchLogo,
    },
    {
      "title": "Team Building Retreat",
      "location": "Riverside Retreat",
      "date": "29 March,2025",
      "time": "9:00 AM",
      "logo": IconPath.teamBuildinglogo,
    },
  ];
}
