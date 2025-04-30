import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:blinqo/core/utils/constants/icon_path.dart';
import 'package:blinqo/features/profile/controller/pick_color_controller.dart';
import 'package:blinqo/features/profile/controller/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EpSpProfileSummarySection extends StatelessWidget {
  const EpSpProfileSummarySection({
    super.key,
    required this.isDarkMode,
    required this.isFemale,
    required this.femaleColorController,
  });
  final bool isDarkMode;
  final bool isFemale;
  final PickColorController femaleColorController;

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = Get.put(ProfileController()).isDarkMode.value;
    return Column(
      children: [
        /// name
        Text(
          'Ronald Richards',
          style: getTextStyle(
            fontSize: 20,
            color: isDarkMode ? AppColors.borderColor2 : AppColors.textColor,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 8),

        /// City
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              IconPath.locationOn,
              height: 16,
              width: 16,
              color:
                  isDarkMode
                      ? AppColors.buttonColor
                      : isFemale
                      ? femaleColorController.selectedColor
                      : AppColors.buttonColor2,
            ),
            SizedBox(width: 4),
            Text(
              'New York',
              style: getTextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color:
                    isDarkMode ? AppColors.borderColor2 : AppColors.textColor,
              ),
            ),
          ],
        ),
        SizedBox(height: 8),

        /// Profession
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              IconPath.camera,
              height: 16,
              width: 16,
              color:
                  isDarkMode
                      ? AppColors.buttonColor
                      : isFemale
                      ? femaleColorController.selectedColor
                      : AppColors.buttonColor2,
            ),
            SizedBox(width: 4),
            Text(
              'Photographer',
              style: getTextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color:
                    isDarkMode ? AppColors.borderColor2 : AppColors.textColor,
              ),
            ),
          ],
        ),
        SizedBox(height: 24),
      ],
    );
  }
}
