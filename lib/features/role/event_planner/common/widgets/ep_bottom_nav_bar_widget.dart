import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:blinqo/core/utils/constants/icon_path.dart';
import 'package:blinqo/features/role/event_planner/common/controllers/ep_bottom_nav_controller.dart';
import 'package:blinqo/features/role/event_planner/main_layout/screen/ep_main_layout_screen.dart';
import 'package:blinqo/features/role/event_planner/profile/controller/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EpBottomNavBarWidget extends StatelessWidget {
  const EpBottomNavBarWidget({super.key, this.selectedIndex = 0});

  final int selectedIndex;

  @override
  Widget build(BuildContext context) {
    final EventBottomNavController epBottomNavController = Get.find();

    double screenWidth = MediaQuery.of(context).size.width;
    double iconSize = screenWidth < 700 ? 60 : 70;

    return GetBuilder<ProfileController>(
      builder: (ctr) {
        bool isDarkMode = ctr.isDarkMode.value;
        return Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black.withAlpha(65),
                spreadRadius: 2,
                blurRadius: 6,
                offset: Offset(0, -2),
              ),
            ],
            color: isDarkMode ? Color(0xff1B2731) : Colors.white,
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
                  epBottomNavController: epBottomNavController,
                ),
                _buildNavItem(
                  activeImage: IconPath.checkoutactive,
                  passiveImage: IconPath.checkoutdeactive,
                  index: 1,
                  iconSize: iconSize,
                  epBottomNavController: epBottomNavController,
                ),
                _buildNavItem(
                  activeImage: IconPath.bookingactive,
                  passiveImage: IconPath.bookingdeactive,
                  index: 2,
                  iconSize: iconSize,
                  epBottomNavController: epBottomNavController,
                ),
                _buildNavItem(
                  activeImage: IconPath.chatactive,
                  passiveImage: IconPath.chatdeactive,
                  index: 3,
                  iconSize: iconSize,
                  epBottomNavController: epBottomNavController,
                ),
                _buildNavItem(
                  activeImage: IconPath.profileactive,
                  passiveImage: IconPath.profiledeactive,
                  index: 4,
                  iconSize: iconSize,
                  epBottomNavController: epBottomNavController,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildNavItem({
    required String activeImage,
    required String passiveImage,
    required int index,
    required double iconSize,
    required EventBottomNavController epBottomNavController,
  }) {
    final bool isDarkMode = Get.find<ProfileController>().isDarkMode.value;
    return GestureDetector(
      onTap: () {
        epBottomNavController.changeIndex(index);
        Get.to(() => EventPlannerMainLayoutScreen());
      },
      child: Obx(() {
        final isSelected = epBottomNavController.currentIndex.value == index;
        return ColorFiltered(
          colorFilter: ColorFilter.mode(
            isSelected && isDarkMode
                ? AppColors.buttonColor
                : isSelected && !isDarkMode
                ? AppColors.buttonColor2
                : AppColors.thimeIconColor,
            BlendMode.srcIn,
          ),
          child: Image.asset(
            isSelected ? activeImage : passiveImage,
            height: iconSize,
            fit: BoxFit.contain,
          ),
        );
      }),
    );
  }
}
