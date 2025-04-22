import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../review_booking/screen/review_booking.dart';

class StartBookingButton extends StatelessWidget {
  const StartBookingButton({
    super.key,
    required this.screenHeight,
    required this.themeMode,
  });

  final double screenHeight;
  final ThemeMode themeMode;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,

          child: ElevatedButton(
            onPressed: () {
              Get.to(ReviewBooking());
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.buttonColor2, // Your custom color
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                  12.r,
                ), // Adjust the radius as needed
              ),
            ),
            child: Text(
              "Continue",
              style: getTextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
                color: AppColors.primary,
              ),
            ),
          ),
        ),
        SizedBox(height: screenHeight * 0.02),
        SizedBox(
          width: double.infinity,

          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              elevation: 0,
              backgroundColor: Color(0x1A003366), // Your custom color
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                  12.r,
                ), // Adjust the radius as needed
              ),
            ),
            child: Text(
              "Cancel Booking",
              style: getTextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
                color:
                    themeMode == ThemeMode.dark
                        ? AppColors.primary
                        : AppColors.buttonColor2,
              ),
            ),
          ),
        ),

        SizedBox(height: screenHeight * 0.04),
      ],
    );
  }
}
