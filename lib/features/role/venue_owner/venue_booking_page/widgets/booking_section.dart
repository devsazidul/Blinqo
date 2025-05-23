import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/utils/constants/icon_path.dart';
import 'package:blinqo/features/role/venue_owner/profile_page/controller/venue_owner_profile_controller.dart';
import 'package:blinqo/features/role/venue_owner/venue_booking_page/controllers/booking_controller.dart';
import 'package:blinqo/features/role/venue_owner/venue_booking_page/model/booking.dart';
import 'package:blinqo/features/role/venue_owner/venue_booking_page/screens/explore_all_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'booking_card.dart';

/// A widget that represents a section of bookings (e.g., Booking Requests, In Progress, Completed).
class BookingSection extends StatelessWidget {
  final String title;
  final List<Booking> bookings;
  final BookingController controller;

  const BookingSection({
    super.key,
    required this.title,
    required this.bookings,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode =
        Get.put(VenueOwnerProfileController()).isDarkMode.value;
    // Limit the number of bookings to display to 3
    final displayBookings =
        bookings.length > 3 ? bookings.sublist(0, 3) : bookings;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: getTextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: isDarkMode ? Color(0xffEBEBEB) : Color(0xFF333333),
                ),
              ),
            ],
          ),
          Row(
            children: [
              const Spacer(),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    ExploreAllScreen.name,
                    arguments: {
                      'title': title,
                      'bookings': bookings,
                      'controller': controller,
                    },
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'Explore All',
                      style: getTextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color:
                            isDarkMode
                                ? Color(0xffEBEBEB)
                                : const Color(0xFF444444),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Image.asset(
                      IconPath.rightarrow,
                      height: 16,
                      width: 16,
                      color: isDarkMode ? Color(0xffEBEBEB) : null,
                    ),
                  ],
                ),
              ),
            ],
          ),
          Column(
            children: List.generate(displayBookings.length, (index) {
              final booking = displayBookings[index];
              return BookingCard(booking: booking, controller: controller);
            }),
          ),
          const SizedBox(height: 24),
          // Adjust spacing to contribute to the total of 40 pixels
        ],
      ),
    );
  }
}
