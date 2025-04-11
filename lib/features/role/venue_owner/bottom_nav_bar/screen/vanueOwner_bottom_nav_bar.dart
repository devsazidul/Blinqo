// ignore_for_file: file_names

import 'package:blinqo/core/utils/constants/icon_path.dart';
import 'package:blinqo/features/role/venue_owner/overview/screen/overview_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/vanueOwner_bottom_nav_controller.dart';

class VanueOwnerBottomNavBar extends StatelessWidget {
  const VanueOwnerBottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    final VanueOwnerBottomNavController controller = Get.put(
      VanueOwnerBottomNavController(),
    );

    final List<Widget> pages = [
      OverviewScreen(),
      Text('Screen 2'),
      Text('Screen 3'),
      Text('Screen 4'),
      Text('Screen 5'),
    ];

    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBody: true,
      body: Obx(() => pages[controller.currentIndex.value]),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              // ignore: deprecated_member_use
              color: Colors.black.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 6,
              offset: Offset(0, -2),
            ),
          ],
          color: Colors.white,
        ),
        child: Padding(
          padding: const EdgeInsets.only(bottom: 5, top: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(
                activeImage: IconPath.homeactive,
                passiveImage: IconPath.homedeactive,
                index: 0,
              ),
              _buildNavItem(
                activeImage: IconPath.earningsactive,
                passiveImage: IconPath.earningsdeactive,
                index: 1,
              ),
              _buildNavItem(
                activeImage: IconPath.bookingactive,
                passiveImage: IconPath.bookingdeactive,
                index: 2,
              ),
              _buildNavItem(
                activeImage: IconPath.chatactive,
                passiveImage: IconPath.chatdeactive,
                index: 3,
              ),
              _buildNavItem(
                activeImage: IconPath.profileactive,
                passiveImage: IconPath.profiledeactive,
                index: 4,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required String activeImage,
    required String passiveImage,
    required int index,
  }) {
    return GestureDetector(
      onTap: () {
        Get.find<VanueOwnerBottomNavController>().changeIndex(index);
      },
      child: Obx(() {
        final isSelected =
            Get.find<VanueOwnerBottomNavController>().currentIndex.value ==
            index;
        return Image.asset(
          isSelected ? activeImage : passiveImage,
          height: 70,
          fit: BoxFit.contain,
        );
      }),
    );
  }
}
