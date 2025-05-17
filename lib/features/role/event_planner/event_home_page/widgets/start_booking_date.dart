import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:blinqo/features/role/event_planner/profile/controller/pick_color_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../../core/common/styles/global_text_style.dart';
import '../../home/controller/booking_controller.dart';

class StartBookingDate extends StatelessWidget {
  const StartBookingDate({
    super.key,
    required this.bookingController,
    required this.themeMode,
    this.pickColorController,
  });

  final BookingController bookingController;
  final ThemeMode themeMode;
  final PickColorController? pickColorController;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Set Date',
          style: getTextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color:
                themeMode == ThemeMode.dark
                    ? AppColors.borderColor2
                    : pickColorController?.isFemale.value ?? false
                    ? pickColorController?.selectedColor ??
                        AppColors.dopdownTextColor
                    : AppColors.dopdownTextColor,
          ),
        ),
        SizedBox(height: 6.h),
        GestureDetector(
          onTap: () => bookingController.selectDate(context),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              border: Border.all(
                color:
                    themeMode == ThemeMode.dark
                        ? Colors.transparent
                        : Color(0xFFE6E6E6),
              ),
              color:
                  themeMode == ThemeMode.dark
                      ? Color(0x26979797) // Light border color for dark theme
                      // : Color(
                      //   0xFFBDBDBD,
                      // ), // A non-transparent color for light theme
                      : AppColors.dopdwonBackdownColor,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.calendar_month,
                  color:
                      themeMode == ThemeMode.dark
                          ? AppColors.buttonColor
                          : pickColorController?.isFemale.value ?? false
                          ? pickColorController?.selectedColor ??
                              AppColors.iconColor
                          : AppColors.iconColor,
                ),
                SizedBox(width: 4),
                Column(
                  children: [
                    Text(
                      'Select a day',
                      style: getTextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color:
                            themeMode == ThemeMode.dark
                                ? AppColors.borderColor2
                                : AppColors.textColor,
                      ),
                    ),
                    Obx(
                      () => Text(
                        bookingController.getFormattedDate(),
                        style: getTextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color:
                              themeMode == ThemeMode.dark
                                  ? AppColors.buttonColor
                                  : pickColorController?.isFemale.value ?? false
                                  ? pickColorController?.selectedColor ??
                                      Color(0xFF003285)
                                  : Color(0xFF003285),
                        ),
                      ),
                    ),
                  ],
                ),

                const Spacer(),
                Transform.rotate(
                  angle: 256,
                  child: Icon(
                    Icons.arrow_back_ios_new,
                    color:
                        themeMode == ThemeMode.dark
                            ? Color(0xFFEBEBEB)
                            : AppColors.iconColor,
                    size: 18,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
