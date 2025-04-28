import 'package:blinqo/features/profile/screen/profile_navigator.dart';
import 'package:blinqo/features/role/event_planner/booking/screens/booking_navigator.dart';
import 'package:blinqo/features/role/event_planner/chat_screen/screen/ep_Chat_Screen.dart';
import 'package:blinqo/features/role/event_planner/event_checkout_page/screens/event_checklist_screen.dart';
import 'package:blinqo/features/role/event_planner/event_home_page/screens/event_home_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EpBottomNavController extends GetxController {
  RxInt currentIndex = 0.obs;
  RxList<StatelessWidget> screens =
      [
        // EventHomeNavigator(),
        EventHomeScreen(),
        EventChecklistScreen(),
        // BookingList(),
        BookingNavigator(),
        EpChatScreen(),
        ProfileNavigator(),
      ].obs;

  void changeIndex(int index) {
    currentIndex.value = index;
  }

  void changeScreenWidget(StatelessWidget screen, int index) {
    screens.removeAt(index);
    screens.insert(index, screen);
    currentIndex.value = index;
  }
}
