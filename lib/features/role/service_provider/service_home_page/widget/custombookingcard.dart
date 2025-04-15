import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:blinqo/features/role/service_provider/service_profile_page/controller/service_user_profile_controler.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class CustomBookingCard extends StatelessWidget {
  final String title;
  final String description;
  final String day;
  final String date;

  // Constructor to accept data dynamically
  CustomBookingCard({
    required this.title,
    required this.description,
    required this.day,
    required this.date,
    super.key,
  });
  final controller = Get.put(SpProfileController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final themeMode =
          controller.isDarkMode.value ? ThemeMode.dark : ThemeMode.light;
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 14),
        decoration: BoxDecoration(
          color:
              themeMode == ThemeMode.dark
                  ? AppColors.textColor
                  : AppColors.chatBackground,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        title,
                        style: getTextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color:
                              themeMode == ThemeMode.dark
                                  ? AppColors.primary
                                  : AppColors.buttonColor2,
                        ),
                      ),
                    ),
                    Text(
                      description,
                      style: getTextStyle(
                        fontSize: 10,
                        color:
                            themeMode == ThemeMode.dark
                                ? AppColors.primary
                                : AppColors.textColor,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      day,
                      style: getTextStyle(
                        fontSize: 14,
                        color:
                            themeMode == ThemeMode.dark
                                ? AppColors.primary
                                : AppColors.textColor,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Text(
                      date,
                      style: getTextStyle(
                        fontSize: 14,
                        color: AppColors.buttonColor,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 26),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Today's Task",
                  style: getTextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w400,
                    color:
                        themeMode == ThemeMode.dark
                            ? AppColors.primary
                            : AppColors.textColor,
                  ),
                ),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10.0,
                          vertical: 5,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(
                            color:
                                themeMode == ThemeMode.dark
                                    ? AppColors.buttonColor
                                    : AppColors.buttonColor2,
                            width: 1,
                          ),
                        ),
                        child: Text(
                          "Reminder Later",
                          style: getTextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w400,
                            color:
                                themeMode == ThemeMode.dark
                                    ? AppColors.buttonColor
                                    : AppColors.buttonColor2,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 8.0),
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10.0,
                          vertical: 5,
                        ),
                        decoration: BoxDecoration(
                          color:
                              themeMode == ThemeMode.dark
                                  ? AppColors.buttonColor
                                  : AppColors.buttonColor2,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          "Done",
                          style: getTextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w400,
                            color: AppColors.primary,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      );
    });
  }
}
