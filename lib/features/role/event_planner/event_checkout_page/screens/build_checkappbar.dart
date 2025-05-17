import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:blinqo/features/role/event_planner/profile/controller/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

AppBar buildCheckVenueAppBar() {
  final ProfileController themeController = Get.put(ProfileController());
  bool isDarkMode = themeController.isDarkMode.value;

  return AppBar(
    scrolledUnderElevation: 0,
    leading: Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: CircleAvatar(
        backgroundColor:
            isDarkMode
                ? AppColors.primary.withValues(alpha: 0.1)
                : AppColors.textColor.withValues(alpha: 0.15),
        child: IconButton(
          padding: EdgeInsets.all(0),
          icon: Icon(
            Icons.arrow_back,
            color: isDarkMode ? AppColors.primary : AppColors.textColor,
          ),

          onPressed: () {
            Get.back();
          },
        ),
      ),
    ),
    title: Text(
      'Checklist',
      style: getTextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: isDarkMode ? AppColors.borderColor2 : AppColors.textColor,
      ),
    ),
    centerTitle: true,
  );
}
