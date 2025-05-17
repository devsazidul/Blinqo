import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:blinqo/features/role/event_planner/profile/controller/pick_color_controller.dart';
import 'package:blinqo/features/role/event_planner/profile/controller/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class StartBookingButton extends StatelessWidget {
  const StartBookingButton({
    super.key,
    required this.screenHeight,
    required this.themeMode,
    this.onTapContinue,
  });

  final double screenHeight;
  final ThemeMode themeMode;
  final VoidCallback? onTapContinue;

  @override
  Widget build(BuildContext context) {
    final PickColorController pickColorController = Get.find();
    final bool isDarkMode = Get.find<ProfileController>().isDarkMode.value;
    return Column(
      children: [
        SizedBox(
          width: double.infinity,

          child: ElevatedButton(
            onPressed: onTapContinue,
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(vertical: 12),
              backgroundColor:
                  isDarkMode || !pickColorController.isFemale.value
                      ? AppColors.buttonColor2
                      : pickColorController.selectedColor,
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
            onPressed: () {
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(vertical: 12),
              elevation: 0,
              backgroundColor:
                  isDarkMode || !pickColorController.isFemale.value
                      ? Color(0x1A003366)
                      : Color(0xffff2d55).withValues(alpha: 0.1),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                  12.r,
                ), // Adjust the radius as needed
              ),
              side: BorderSide(
                color:
                    themeMode == ThemeMode.dark
                        ? AppColors.buttonColor2
                        : Colors.transparent,
                width: 1,
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
                        : pickColorController.isFemale.value
                        ? pickColorController.selectedColor
                        : AppColors.buttonColor2,
              ),
            ),
          ),
        ),
        SizedBox(height: screenHeight * 0.08),
      ],
    );
  }
}
