import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:blinqo/features/role/event_planner/review_booking/widget/reviews_text.dart'
    show ReviewsText;

import 'package:flutter/material.dart';

class EverReviewBookingDetailsSection extends StatelessWidget {
  const EverReviewBookingDetailsSection({
    super.key,
    required this.themeMode,
    required this.screenHeight,
  });
  final ThemeMode themeMode;
  final double screenHeight;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color:
            themeMode == ThemeMode.dark ? Color(0xff32383D) : AppColors.primary,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Booking',
              style: getTextStylePoppins(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color:
                    themeMode == ThemeMode.dark
                        ? Color(0xffD4AF37)
                        : Color(0xff003366),
              ),
            ),
            SizedBox(height: screenHeight * 0.02),
            ReviewsText(
              label: 'Organizer',
              value: 'John Doe Events',
              themeMode: themeMode,
            ),
            SizedBox(height: screenHeight * 0.02),
            ReviewsText(
              label: 'Date',
              value: '15/03/2025',
              themeMode: themeMode,
            ),
            SizedBox(height: screenHeight * 0.02),
            ReviewsText(
              label: 'Time',
              value: '10:00am-4:00pm',
              themeMode: themeMode,
            ),
            SizedBox(height: screenHeight * 0.02),
            ReviewsText(label: 'Guests', value: '150', themeMode: themeMode),
            SizedBox(height: screenHeight * 0.02),
            ReviewsText(
              label: 'Event Type',
              value: 'Birthday',
              themeMode: themeMode,
            ),
          ],
        ),
      ),
    );
  }
}
