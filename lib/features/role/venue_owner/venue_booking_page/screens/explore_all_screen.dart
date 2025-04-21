import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:blinqo/core/utils/constants/icon_path.dart';
import 'package:blinqo/features/role/venue_owner/profile_page/controller/venue_owner_profile_controller.dart';
import 'package:blinqo/features/role/venue_owner/venue_booking_page/controllers/booking_controller.dart';
import 'package:blinqo/features/role/venue_owner/venue_booking_page/model/booking.dart';
import 'package:blinqo/features/role/venue_owner/venue_booking_page/widgets/booking_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// A screen that displays all bookings for a specific section.
class ExploreAllScreen extends StatelessWidget {
  static const String name = '/explore_all_screen';
  final String title;
  final List<Booking> bookings;
  final BookingController controller;

  const ExploreAllScreen({
    super.key,
    required this.title,
    required this.bookings,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode =
        Get.put(VenueOwnerProfileController()).isDarkMode.value;
    return Scaffold(
      backgroundColor:
          isDarkMode ? Color(0xff151515) : AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
        forceMaterialTransparency: true,
        leading: Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: CircleAvatar(
              backgroundColor:
              isDarkMode
                  ? Color(0xFFD9D9D9).withAlpha(40)
                  : const Color(0xFFD9D9D9),
              child: Image.asset(
                IconPath.arrowLeftAlt,
                width: 16,
                height: 12,
                color: isDarkMode ? Colors.white : AppColors.textColor,
              ),
            ),
          ),
        ),

        title: Text(
          title ?? '',
          style: getTextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: isDarkMode ? AppColors.backgroundColor : AppColors.textColor,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: ListView.builder(
          itemCount: bookings.length,
          itemBuilder: (context, index) {
            final booking = bookings[index];
            return BookingCard(booking: booking, controller: controller);
          },
        ),
      ),
    );
  }
}
