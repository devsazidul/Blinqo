import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:blinqo/core/utils/constants/icon_path.dart';
import 'package:blinqo/features/role/event_planner/bottom_nav_bar/controller/event_bottom_nav_controller.dart';
import 'package:blinqo/features/role/event_planner/event_checkout_page/screens/event_checklist_screen.dart';
import 'package:blinqo/features/role/event_planner/event_home_page/screens/event_home_screen.dart';
import 'package:blinqo/features/role/service_provider/service_profile_page/screen/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../service_provider/service_earning_page/screen/sp_earning_page.dart'
    show SpEarningPage;
import '../../../service_provider/service_profile_page/controller/service_user_profile_controler.dart';
import '../../chat_screen/screen/ep_Chat_Screen.dart' show EPChatScreen;

class EventBottomNavBar extends StatelessWidget {
  const EventBottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    final EventBottomNavController controller = Get.put(
      EventBottomNavController(),
    );
    final ServiceUserProfileControler spUserProfileControler =
        Get.find<ServiceUserProfileControler>();
    final List<Widget> pages = [
      EventHomeScreen(),
      EventChecklistScreen(),
      SpEarningPage(),
      EPChatScreen(),
      SpProfilePage(),
    ];
    double screenWidth = MediaQuery.of(context).size.width;
    double iconSize = screenWidth < 700 ? 65 : 70;

    return Obx(() {
      final themeMode =
          spUserProfileControler.isDarkMode.value
              ? ThemeMode.dark
              : ThemeMode.light;

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
            color:
                themeMode == ThemeMode.dark ? Color(0xff1B2731) : Colors.white,
          ),
          child: Padding(
            padding: const EdgeInsets.only(bottom: 5, top: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildNavItem(
                  themeMode,
                  activeImage: IconPath.homeactive,
                  passiveImage: IconPath.homedeactive,
                  index: 0,
                  iconSize: iconSize,
                ),
                _buildNavItem(
                  themeMode,
                  activeImage: IconPath.checkoutactive,
                  passiveImage: IconPath.checkoutdeactive,
                  index: 1,
                  iconSize: iconSize,
                ),
                _buildNavItem(
                  themeMode,
                  activeImage: IconPath.bookingactive,
                  passiveImage: IconPath.bookingdeactive,
                  index: 2,
                  iconSize: iconSize,
                ),
                _buildNavItem(
                  themeMode,
                  activeImage: IconPath.chatactive,
                  passiveImage: IconPath.chatdeactive,
                  index: 3,
                  iconSize: iconSize,
                ),
                _buildNavItem(
                  themeMode,
                  activeImage: IconPath.profileactive,
                  passiveImage: IconPath.profiledeactive,
                  index: 4,
                  iconSize: iconSize,
                ),
              ],
            ),
          ),
        ),
      );
    });
  }

  Widget _buildNavItem(
    ThemeMode themeMode, {
    required String activeImage,
    required String passiveImage,
    required int index,
    required double iconSize,
  }) {
    return GestureDetector(
      onTap: () {
        Get.find<EventBottomNavController>().changeIndex(index);
      },
      child: Obx(() {
        final isSelected =
            Get.find<EventBottomNavController>().currentIndex.value == index;
        return ColorFiltered(
          colorFilter: ColorFilter.mode(
            isSelected && themeMode == ThemeMode.dark
                ? AppColors.buttonColor
                : isSelected && themeMode == ThemeMode.light
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
