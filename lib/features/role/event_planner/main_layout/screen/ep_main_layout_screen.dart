import 'package:blinqo/features/role/event_planner/common/controllers/ep_bottom_nav_controller.dart';
import 'package:blinqo/features/role/event_planner/common/widgets/ep_bottom_nav_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EventPlannerMainLayoutScreen extends StatelessWidget {
  const EventPlannerMainLayoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final EventBottomNavController epBottomNavController = Get.find();
    return Scaffold(
      extendBody: true,
      body: Obx(
        () =>
            epBottomNavController.pages[epBottomNavController
                .currentIndex
                .value],
      ),
      bottomNavigationBar: EpBottomNavBarWidget(),
    );
  }
}
