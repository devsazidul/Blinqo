import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/utils/constants/icon_path.dart';
import 'package:blinqo/core/utils/constants/image_path.dart';
import 'package:blinqo/features/role/venue_owner/venue_booking_page/controllers/booking_controller.dart';
import 'package:blinqo/features/role/venue_owner/venue_booking_page/model/booking.dart';
import 'package:blinqo/features/role/venue_owner/venue_booking_page/screens/booking_details_page.dart';
import 'package:flutter/material.dart';


/// A container widget that displays details of a single booking.
class BookingCard extends StatelessWidget {
  final Booking booking;
  final BookingController controller;

  const BookingCard({
    super.key,
    required this.booking,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12), // Rounded corners
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            // Subtle shadow similar to Card elevation=2
            blurRadius: 4,
            offset: const Offset(0, 2), // Shadow slightly below
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Booking Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.asset(
                          ImagePath.eventCard,
                          fit: BoxFit.cover,
                          height: 40,
                          width: 40,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            booking.name,
                            style: getTextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF333333),
                            ),
                          ),
                          Text(
                            booking.venue,
                            style: getTextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 12,
                              color: const Color(0xFF999999),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  // Date and Time with Calendar Icon
                  Row(
                    children: [
                      Image.asset(
                        IconPath.calendermonthe,
                        height: 16,
                        width: 16,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        booking.date,
                        style: getTextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: const Color(0xFF999999),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Text(
                        booking.time,
                        style: getTextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: const Color(0xFF999999),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // View Details Button
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context,BookingDetailsPage.name),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xff003366),
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 9),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                'View Details',
                style: getTextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Color(0xffE6EBF0),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
