import 'package:blinqo/features/role/event_planner/chat_screen/screen/ep_Chat_Screen.dart';
import 'package:blinqo/features/role/event_planner/ep_booking/screens/ep_booking_list_screen.dart';
import 'package:blinqo/features/role/event_planner/ep_home/screens/ep_home_screen.dart';
import 'package:blinqo/features/role/event_planner/event_checkout_page/screens/event_checklist_screen.dart';
import 'package:blinqo/features/role/event_planner/profile/screen/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EventBottomNavController extends GetxController {
  final List<Widget> pages = [
    EventHomeScreen(),
    EventChecklistScreen(),
    EpBookingListScreen(),
    EpChatScreen(),
    MainProfileScreen(),
  ];

  RxInt currentIndex = 0.obs;

  void changeIndex(int index) {
    currentIndex.value = index;
  }
}
