import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/common/widgets/auth_custom_textfield.dart';
import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:flutter/material.dart';

import '../../home/controller/booking_controller.dart';

class StartBookingNumberOfGuests extends StatelessWidget {
  const StartBookingNumberOfGuests({
    super.key,
    required this.screenHeight,
    required this.bookingController,
  });

  final double screenHeight;
  final BookingController bookingController;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Number of Guests',
          style: getTextStyle(
            color: AppColors.dopdownTextColor,
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
        ),
        SizedBox(height: screenHeight * 0.002),
        AuthCustomTextField(
          controller: bookingController.numberOfGuestsController,
          onChanged: (value) {},
          text: '150 -200',

          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Event Name';
            }
            return null;
          },
        ),
      ],
    );
  }
}
