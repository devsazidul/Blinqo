import 'package:blinqo/core/utils/constants/icon_path.dart';
import 'package:blinqo/features/role/venue_owner/myvenue/screen/venue_home_screen.dart';

// ignore_for_file: file_names
import 'package:blinqo/features/role/venue_owner/overview/screen/overview_screen.dart';
import 'package:blinqo/features/role/venue_owner/team/screen/schedule_and_team_screen.dart';
import 'package:blinqo/features/role/venue_owner/venue_booking_page/screens/venue_owner_booking.dart';
import 'package:blinqo/features/role/venue_owner/profile_page/controller/venue_owner_profile_controller.dart';
import 'package:blinqo/features/role/venue_owner/venue_chat_page/screens/chat_list_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/vanueOwner_bottom_nav_controller.dart';

class VanueOwnerBottomNavBar extends StatelessWidget {
  const VanueOwnerBottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode =
        Get.put(VenueOwnerProfileController()).isDarkMode.value;
    double screenWidth = MediaQuery.of(context).size.width;
    double iconSize = screenWidth < 700 ? 60 : 70;

    final VanueOwnerBottomNavController controller = Get.put(
      VanueOwnerBottomNavController(),
    );

    final List<Widget> pages = [
      OverviewScreen(),
      VenueHomePage(),
      VenueOwnerBooking(),
      ChatListView(),
      VenueHomePage(isTeam: true),
      // Emptyschedule(),
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
              spreadRadius: 0,
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
                activeImage: IconPath.overviewactive,
                passiveImage: IconPath.overviewdeactive,
                index: 0,
                iconSize: iconSize,
              ),
              _buildNavItem(
                activeImage: IconPath.venueactive,
                passiveImage: IconPath.vernuownerdeactive,
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
                activeImage: IconPath.activeteam,
                passiveImage: IconPath.deactiveteam,
                index: 4,
                iconSize: iconSize,
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
    required double iconSize,
  }) {
    return GestureDetector(
      onTap: () {
        Get.find<VanueOwnerBottomNavController>().changeIndex(index);
      },
      child: Obx(() {
        final bool isDarkMode =
            Get.put(VenueOwnerProfileController()).isDarkMode.value;
        final isSelected =
            Get.find<VanueOwnerBottomNavController>().currentIndex.value ==
            index;
        return Image.asset(
          isSelected ? activeImage : passiveImage,
          height: iconSize,
          fit: BoxFit.contain,
          color:
              isDarkMode && isSelected
                  ? Color(0xffD4AF37)
                  : isSelected && !isDarkMode
                  ? null
                  : Color(0xff8A8A8A),
        );
      }),
    );
  }
}
