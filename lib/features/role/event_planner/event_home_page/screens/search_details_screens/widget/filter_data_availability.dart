import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:blinqo/features/profile/controller/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DataAvailability extends StatelessWidget {
  DataAvailability({super.key});
  final ProfileController themeController = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = themeController.isDarkMode.value;
    return Padding(
      padding: EdgeInsets.only(left: 30, top: 7),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Start Date',
                  style: getTextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w300,
                    color:
                        isDarkMode
                            ? AppColors.borderColor2
                            : AppColors.textColor,
                  ),
                ),
                SizedBox(height: 5),
                Container(
                  height: 38,
                  decoration: BoxDecoration(
                    color:
                        isDarkMode
                            ? AppColors.cardDarkColor
                            : AppColors.primary,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: TextField(
                    style: getTextStyle(
                      color:
                          isDarkMode
                              ? AppColors.borderColor2
                              : AppColors.textColor,
                    ),
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color:
                              isDarkMode
                                  ? AppColors.cardDarkColor
                                  : AppColors.borderColor2,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color:
                              isDarkMode
                                  ? AppColors.cardDarkColor
                                  : AppColors.borderColor2,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      hintText: 'dd-mm-yyyy',
                      hintStyle: getTextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w300,
                        color: AppColors.subTextColor2,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'End Date',
                  style: getTextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w300,
                    color:
                        isDarkMode
                            ? AppColors.borderColor2
                            : AppColors.textColor,
                  ),
                ),
                SizedBox(height: 5),
                Container(
                  height: 38,
                  decoration: BoxDecoration(
                    color:
                        isDarkMode
                            ? AppColors.cardDarkColor
                            : AppColors.primary,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: TextField(
                    style: getTextStyle(
                      color:
                          isDarkMode
                              ? AppColors.borderColor2
                              : AppColors.textColor,
                    ),
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color:
                              isDarkMode
                                  ? AppColors.cardDarkColor
                                  : AppColors.borderColor2,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color:
                              isDarkMode
                                  ? AppColors.cardDarkColor
                                  : AppColors.borderColor2,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      hintText: 'dd-mm-yyyy',
                      hintStyle: getTextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w300,
                        color: AppColors.subTextColor2,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
