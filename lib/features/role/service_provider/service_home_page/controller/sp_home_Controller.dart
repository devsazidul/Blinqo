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

  var tasks =
      [
        {
          "title": "Jhon's Birth Day",
          "date": "15-12-2025",
          "day": "Thursday",
          "description":
              "Today Is My Friend Jhon's Birthday. I Want To Wish Him And Also Surprise Him",
        },
        {
          "title": "Project Deadline",
          "date": "20-12-2025",
          "day": "Monday",
          "description":
              "The deadline for my current project is coming up, need to wrap things up.",
        },
        {
          "title": "Meeting with Boss",
          "date": "18-12-2025",
          "day": "Saturday",
          "description":
              "Prepare the presentation for the meeting with my boss.",
        },
        // Add more tasks here
      ].obs;
}
