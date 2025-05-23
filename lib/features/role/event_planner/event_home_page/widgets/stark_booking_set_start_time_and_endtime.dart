import 'package:blinqo/features/role/event_planner/profile/controller/pick_color_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../core/common/styles/global_text_style.dart';
import '../../../../../core/utils/constants/colors.dart';
import '../../ep_home/controller/booking_controller.dart';

class StarkBookingSetStartTimeOrEndTime extends StatelessWidget {
  const StarkBookingSetStartTimeOrEndTime({
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
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Set Time',
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
            const SizedBox(height: 6),
            SizedBox(
              width: 150,
              child: GestureDetector(
                onTap: () => bookingController.selectStartTime(context),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8.0,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color:
                          themeMode == ThemeMode.dark
                              ? Colors.transparent
                              : Color(0xFFE6E6E6),
                      width: 1,
                    ),
                    color:
                        themeMode == ThemeMode.dark
                            ? Color(
                              0x26979797,
                            ) // Light border color for dark theme
                            : AppColors.dopdwonBackdownColor,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.access_time,
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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Start time',
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
                              bookingController.getFormattedStartTime(context),
                              style: getTextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color:
                                    themeMode == ThemeMode.dark
                                        ? AppColors.buttonColor
                                        : pickColorController?.isFemale.value ??
                                            false
                                        ? pickColorController?.selectedColor ??
                                            AppColors.iconColor
                                        : AppColors.iconColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Spacer(),
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
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 30),
            SizedBox(
              width: 150,
              child: GestureDetector(
                onTap: () => bookingController.selectEndTime(context),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8.0,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color:
                          themeMode == ThemeMode.dark
                              ? Colors.transparent
                              : Color(0xFFE6E6E6),
                      width: 1,
                    ),
                    color:
                        themeMode == ThemeMode.dark
                            ? Color(
                              0x26979797,
                            ) // Light border color for dark theme
                            : AppColors.dopdwonBackdownColor,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.access_time,
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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'End time',
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
                              bookingController.getFormattedEndTime(context),
                              style: getTextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color:
                                    themeMode == ThemeMode.dark
                                        ? AppColors.buttonColor
                                        : pickColorController?.isFemale.value ??
                                            false
                                        ? pickColorController?.selectedColor ??
                                            AppColors.iconColor
                                        : AppColors.iconColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Spacer(),
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
            ),
          ],
        ),
      ],
    );
  }
}
