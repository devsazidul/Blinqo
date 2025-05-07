import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:blinqo/core/utils/constants/icon_path.dart';
import 'package:blinqo/features/role/service_provider/service_booking_page/screen/sp_booking_page.dart';
import 'package:blinqo/features/role/service_provider/service_chat_page/screen/sp_chat_page.dart';
import 'package:blinqo/features/role/service_provider/service_earning_page/screen/sp_earning_page.dart';
import 'package:blinqo/features/role/service_provider/service_home_page/screen/sp_home_page.dart';
import 'package:blinqo/features/role/service_provider/service_profile_page/controller/service_user_profile_controler.dart';
import 'package:blinqo/features/role/service_provider/service_profile_page/screen/sp_profile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/bottom_nav_controller.dart';

class SpBottomNavBarScreen extends StatelessWidget {
  const SpBottomNavBarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    print("SpBottomNavBarScreen");
    final SpProfileController spProfileController = Get.put(
      SpProfileController(),
    );
    final BottomNavController controller = Get.put(BottomNavController());

    final List<Widget> pages = [
      SpHomePage(),
      SpEarningPage(),
      SpBookingPage(),
      SpChatPage(),
      SpProfile(),
    ];
    double screenWidth = MediaQuery.of(context).size.width;
    double iconSize = screenWidth < 700 ? 65 : 70;

    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBody: true,
      body: Obx(() => pages[controller.currentIndex.value]),
      bottomNavigationBar: Obx(() {
        return Container(
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
            color:
                spProfileController.isDarkMode.value
                    ? Color(0xFF1C2731)
                    : Colors.white,
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
                  iconSize: iconSize,
                ),
                _buildNavItem(
                  activeImage: IconPath.earningsactive,
                  passiveImage: IconPath.earningsdeactive,
                  index: 1,
                  iconSize: iconSize,
                ),
                _buildNavItem(
                  activeImage: IconPath.bookingactive,
                  passiveImage: IconPath.bookingdeactive,
                  index: 2,
                  iconSize: iconSize,
                ),
                _buildNavItem(
                  activeImage: IconPath.chatactive,
                  passiveImage: IconPath.chatdeactive,
                  index: 3,
                  iconSize: iconSize,
                ),
                _buildNavItem(
                  activeImage: IconPath.profileactive,
                  passiveImage: IconPath.profiledeactive,
                  index: 4,
                  iconSize: iconSize,
                ),
              ],
            ),
          ),
        );
      }),
    );
  }

  Widget _buildNavItem({
    required String activeImage,
    required String passiveImage,
    required int index,
    required double iconSize,
  }) {
    bool isDarkMode = Get.find<SpProfileController>().isDarkMode.value;
    return GestureDetector(
      onTap: () {
        Get.find<BottomNavController>().changeIndex(index);
      },
      child: Obx(() {
        final isSelected =
            Get.find<BottomNavController>().currentIndex.value == index;
        return Image.asset(
          isSelected ? activeImage : passiveImage,
          height: iconSize,
          fit: BoxFit.contain,
          color:
              isDarkMode && isSelected
                  ? AppColors.buttonColor
                  : !isDarkMode && isSelected
                  ? AppColors.buttonColor2
                  : Color(0xFF898989),
        );
      }),
    );
  }
}
