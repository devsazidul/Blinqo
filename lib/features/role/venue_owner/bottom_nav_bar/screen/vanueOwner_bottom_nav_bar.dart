import 'package:blinqo/core/utils/constants/icon_path.dart';
import 'package:blinqo/features/role/venue_owner/myvenue/screen/venue.dart';
// ignore_for_file: file_names
import 'package:blinqo/features/role/venue_owner/overview/screen/overview_screen.dart';
import 'package:blinqo/features/role/venue_owner/venue_booking_page/screens/booking_details_page.dart';
import 'package:blinqo/features/role/venue_owner/venue_booking_page/screens/venue_booking_page.dart';
import 'package:blinqo/features/role/venue_owner/venue_chat_page/screens/chat_list_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/vanueOwner_bottom_nav_controller.dart';

class VanueOwnerBottomNavBar extends StatelessWidget {
  const VanueOwnerBottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double iconSize = screenWidth < 700 ? 60 : 70;
    final VanueOwnerBottomNavController controller = Get.put(
      VanueOwnerBottomNavController(),
    );

    final List<Widget> pages = [
      OverviewScreen(),
      Venue(),
      // VenueBookingPage(),
      BookingDetailsPage(),
      ChatListView(),
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
              spreadRadius: 0,
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
        final isSelected =
            Get.find<VanueOwnerBottomNavController>().currentIndex.value ==
            index;
        return Image.asset(
          isSelected ? activeImage : passiveImage,
          height: iconSize,
          fit: BoxFit.contain,
        );
      }),
    );
  }
}
