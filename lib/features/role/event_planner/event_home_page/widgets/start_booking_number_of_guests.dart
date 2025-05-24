import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/common/widgets/auth_custom_textfield.dart';
import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:blinqo/features/role/event_planner/profile/controller/pick_color_controller.dart';
import 'package:flutter/material.dart';

import '../../ep_home/controller/booking_controller.dart';

class StartBookingNumberOfGuests extends StatelessWidget {
  const StartBookingNumberOfGuests({
    super.key,
    required this.screenHeight,
    required this.bookingController,
    required this.themeMode,
    this.pickColorController,
  });

  final double screenHeight;
  final BookingController bookingController;
  final PickColorController? pickColorController;
  final ThemeMode themeMode;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Number of Guests',
          style: getTextStyle(
            color:
                themeMode == ThemeMode.dark
                    ? AppColors.borderColor2
                    : pickColorController?.isFemale.value ?? false
                    ? pickColorController?.selectedColor ??
                        AppColors.dopdownTextColor
                    : AppColors.dopdownTextColor,
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
        ),
        SizedBox(height: screenHeight * 0.002),
        AuthCustomTextField(
          borderRadius: 4,
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
