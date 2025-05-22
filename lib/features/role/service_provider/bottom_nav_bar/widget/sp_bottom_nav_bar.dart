import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:blinqo/core/utils/constants/icon_path.dart';
import 'package:blinqo/features/role/event_planner/profile/controller/profile_controller.dart';
import 'package:blinqo/features/role/service_provider/bottom_nav_bar/controller/bottom_nav_controller.dart';
import 'package:blinqo/features/role/service_provider/bottom_nav_bar/screen/sp_bottom_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SpBottomNavBarWidget extends StatelessWidget {
  const SpBottomNavBarWidget({super.key, this.selectedIndex = 0});

  final int selectedIndex;

  @override
  Widget build(BuildContext context) {
    final BottomNavController controller = Get.put(BottomNavController());
    double screenWidth = MediaQuery.of(context).size.width;
    double iconSize = screenWidth < 700 ? 60 : 70;
    return GetBuilder<ProfileController>(
      builder: (ctr) {
        bool isDarkMode = ctr.isDarkMode.value;
        return Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                // color: Colors.black.withOpacity(0.2),
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
                  controller: controller,
                ),
                _buildNavItem(
                  activeImage: IconPath.earningsactive,
                  passiveImage: IconPath.earningsdeactive,
                  index: 1,
                  iconSize: iconSize,
                  controller: controller,
                ),
                _buildNavItem(
                  activeImage: IconPath.bookingactive,
                  passiveImage: IconPath.bookingdeactive,
                  index: 2,
                  iconSize: iconSize,
                  controller: controller,
                ),
                _buildNavItem(
                  activeImage: IconPath.chatactive,
                  passiveImage: IconPath.chatdeactive,
                  index: 3,
                  iconSize: iconSize,
                  controller: controller,
                ),
                _buildNavItem(
                  activeImage: IconPath.profileactive,
                  passiveImage: IconPath.profiledeactive,
                  index: 4,
                  iconSize: iconSize,
                  controller: controller,
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
    required BottomNavController controller, // Add this parameter
  }) {
    final bool isDarkMode = Get.find<ProfileController>().isDarkMode.value;
    return GestureDetector(
      onTap: () {
        // controller.changeIndex(index);
        Get.put(BottomNavController()).changeIndex(index);
        Get.to((SpBottomNavBarScreen()));
      },
      child: Obx(() {
        final isSelected = controller.currentIndex.value == index;
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
