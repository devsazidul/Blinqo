import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/common/widgets/auth_custom_textfield.dart';
import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:flutter/material.dart';

import '../../home/controller/booking_controller.dart';

class StartBookingTextFrom extends StatelessWidget {
  const StartBookingTextFrom({
    super.key,
    required this.screenHeight,
    required this.bookingController,
    required this.themeMode,
  });

  final double screenHeight;
  final BookingController bookingController;
  final ThemeMode themeMode;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: screenHeight * 0.02),
        Text(
          'Event Name',
          style: getTextStyle(
            color:
                themeMode == ThemeMode.dark
                    ? AppColors.borderColor2
                    : AppColors.dopdownTextColor,
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
        ),
        SizedBox(height: screenHeight * 0.01),
        AuthCustomTextField(
          controller: bookingController.eventNameController,
          onChanged: (value) {},
          text: 'Event Name',

          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Event Name';
            }
            return null;
          },
        ),
        SizedBox(height: screenHeight * 0.03),
        Text(
          'Event Planner Name',
          style: getTextStyle(
            color:
                themeMode == ThemeMode.dark
                    ? AppColors.borderColor2
                    : AppColors.dopdownTextColor,
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
        ),
        SizedBox(height: screenHeight * 0.01),
        AuthCustomTextField(
          controller: bookingController.eventPlannerNameController,
          onChanged: (value) {},
          text: 'type event planner name',

          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Event Planner Name';
            }
            return null;
          },
        ),
      ],
    );
  }
}
