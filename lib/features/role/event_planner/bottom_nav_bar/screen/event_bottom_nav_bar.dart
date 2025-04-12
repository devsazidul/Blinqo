import 'package:blinqo/core/utils/constants/icon_path.dart';
import 'package:blinqo/features/role/event_planner/bottom_nav_bar/controller/event_bottom_nav_controller.dart';
import 'package:blinqo/features/role/event_planner/event_home_page/screens/event_home_screen.dart';
import 'package:blinqo/features/role/service_provider/auth/screen/sp_login_screen.dart';
import 'package:blinqo/features/role/service_provider/service_profile_page/screen/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../service_provider/service_chat_page/screen/sp_chat_page.dart'
    show SpChatPage;
import '../../../service_provider/service_earning_page/screen/sp_earning_page.dart'
    show SpEarningPage;
import '../../../service_provider/service_profile_page/controller/service_user_profile_controler.dart';

class EventBottomNavBar extends StatelessWidget {
  const EventBottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    final EventBottomNavController controller = Get.put(
      EventBottomNavController(),
    );

    final ServiceUserProfileControler spUserProfileControler = Get.put(
      ServiceUserProfileControler(),
    );
    final List<Widget> pages = [
      EventHomeScreen(),
      SpLoginScreen(),
      SpEarningPage(),
      SpChatPage(),
      SpProfilePage(),
    ];
    double screenWidth = MediaQuery.of(context).size.width;
    double iconSize = screenWidth < 700 ? 65 : 70;

    return Obx(() {
      bool isDarkMode = spUserProfileControler.isDarkMode.value;
      return Scaffold(
        backgroundColor: isDarkMode ? Colors.transparent : Colors.white,
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
            color: isDarkMode ? Colors.transparent : Colors.white,
          ),
          child: Padding(
            padding: const EdgeInsets.only(bottom: 5, top: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildNavItem(
                  isDarkMode,
                  activeImage: IconPath.homeactive,
                  passiveImage: IconPath.homedeactive,
                  index: 0,
                  iconSize: iconSize,
                ),
                _buildNavItem(
                  isDarkMode,
                  activeImage: IconPath.checkoutactive,
                  passiveImage: IconPath.checkoutdeactive,
                  index: 1,
                  iconSize: iconSize,
                ),
                _buildNavItem(
                  isDarkMode,
                  activeImage: IconPath.bookingactive,
                  passiveImage: IconPath.bookingdeactive,
                  index: 2,
                  iconSize: iconSize,
                ),
                _buildNavItem(
                  isDarkMode,
                  activeImage: IconPath.chatactive,
                  passiveImage: IconPath.chatdeactive,
                  index: 3,
                  iconSize: iconSize,
                ),
                _buildNavItem(
                  isDarkMode,
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
    bool isDarkMode, {
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
        return Image.asset(
          isSelected ? activeImage : passiveImage,
          height: iconSize,
          fit: BoxFit.contain,
        );
      }),
    );
  }
}
