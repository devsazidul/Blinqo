import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:blinqo/core/utils/constants/icon_path.dart';
import 'package:blinqo/features/role/event_planner/profile/controller/pick_color_controller.dart';
import 'package:blinqo/features/role/event_planner/profile/controller/profile_controller.dart';
import 'package:blinqo/features/role/event_planner/review_booking/screen/review_booking_datieals.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BookingContainerCard extends StatelessWidget {
  final String eventName;
  final String venue;
  final int totalCost;
  final DateTime date;

  const BookingContainerCard({
    super.key,
    required this.eventName,
    required this.venue,
    required this.totalCost,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = Get.find<ProfileController>().isDarkMode.value;
    final PickColorController pickColorController = Get.find();
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    double fontSize = screenWidth > 600 ? 16 : 14;
    double subFontSize = screenWidth > 600 ? 14 : 12;

    double verticalSpacing = screenWidth > 600 ? 10 : 8;

    double sizedBoxHeight = screenHeight > 800 ? 25 : 20;
    double sizedBoxWidth = screenWidth > 600 ? 8 : 5;

    return Container(
      decoration: BoxDecoration(
        color: isDarkMode ? AppColors.cardDarkColor : AppColors.primary,
        borderRadius: BorderRadius.circular(12.0),
      ),
      padding: EdgeInsets.all(10.0),
      margin: EdgeInsets.only(bottom: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                eventName,
                style: getTextStyle(
                  fontSize: fontSize,
                  fontWeight: FontWeight.w600,
                  color:
                      isDarkMode
                          ? AppColors.chatBackground
                          : AppColors.textColor,
                ),
              ),
              SizedBox(height: verticalSpacing),
              Row(
                children: [
                  Text(
                    "Venue:",
                    style: getTextStyle(
                      fontSize: subFontSize,
                      color:
                          isDarkMode
                              ? AppColors.darkGreaColor
                              : AppColors.subTextColor,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Text(
                    " $venue",
                    style: getTextStyle(
                      fontSize: subFontSize,
                      color:
                          isDarkMode
                              ? AppColors.chatBackground
                              : AppColors.textColor,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
              SizedBox(height: verticalSpacing),
              Row(
                children: [
                  Text(
                    "Total Cost: ",
                    style: getTextStyle(
                      fontSize: subFontSize,
                      color:
                          isDarkMode
                              ? AppColors.darkGreaColor
                              : AppColors.subTextColor,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Text(
                    "$totalCost\$",
                    style: getTextStyle(
                      fontSize: subFontSize,
                      color:
                          isDarkMode
                              ? AppColors.chatBackground
                              : AppColors.textColor,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    "Booking Status: ",
                    style: getTextStyle(
                      fontSize: subFontSize,
                      color:
                          isDarkMode
                              ? AppColors.darkGreaColor
                              : AppColors.subTextColor,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Text(
                    "Confirmed",
                    style: getTextStyle(
                      fontSize: subFontSize,
                      color: AppColors.statusColor,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Column(
            children: [
              Text(
                "Thursday",
                style: getTextStyle(
                  fontSize: fontSize,
                  color:
                      isDarkMode ? Color(0xffB0C0D0) : AppColors.subTextColor,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(height: verticalSpacing),
              Text(
                "15-12-2024",
                style: getTextStyle(
                  fontSize: fontSize,
                  color:
                      isDarkMode
                          ? AppColors.chatBackground
                          : AppColors.textColor,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(height: sizedBoxHeight), // Dynamic SizedBox height

              InkWell(
                onTap: () {
                  Get.to(ReviewBookingDetails());
                },
                child: Row(
                  children: [
                    Text(
                      "Booking Details",
                      style: getTextStyle(
                        fontSize: subFontSize,
                        color:
                            isDarkMode
                                ? AppColors.buttonColor
                                : pickColorController.isFemale.value
                                ? pickColorController.selectedColor
                                : AppColors.buttonColor2,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(width: sizedBoxWidth), // Dynamic SizedBox width
                    Image.asset(
                      IconPath.rightarrow,
                      width: 16,
                      height: 16,
                      color:
                          isDarkMode
                              ? AppColors.buttonColor
                              : pickColorController.isFemale.value
                              ? pickColorController.selectedColor
                              : AppColors.buttonColor2,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
