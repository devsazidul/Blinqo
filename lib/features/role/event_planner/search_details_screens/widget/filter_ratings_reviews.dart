import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:blinqo/features/role/event_planner/event_home_page/controllers/search_details_controller/search_details_controller.dart';
import 'package:blinqo/features/role/event_planner/profile/controller/pick_color_controller.dart';
import 'package:blinqo/features/role/event_planner/profile/controller/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RatingsReviews extends StatelessWidget {
  final ProfileController themeController = Get.put(ProfileController());
  RatingsReviews({super.key, required this.searchDetailsController});
  final PickColorController femaleColorController = Get.put(
    PickColorController(),
  );
  final SearchDetailsController searchDetailsController;

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = themeController.isDarkMode.value;
    final bool isFemale = femaleColorController.isFemale.value;
    return Padding(
      padding: EdgeInsets.only(left: 30),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: isDarkMode ? AppColors.cardDarkColor : AppColors.primary,
              borderRadius: BorderRadius.circular(6),
            ),

            child: Row(
              children: [
                Icon(Icons.star, color: AppColors.reviesStarColor, size: 12),
                SizedBox(width: 6),
                Obx(
                  () => Text(
                    '${searchDetailsController.ratingValue.value}',
                    style: getTextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w300,
                      color: AppColors.subTextColor2,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Obx(
            () => Slider(
              min: 0,
              max: 100,
              thumbColor: AppColors.thumbColor,
              activeColor:
                  isDarkMode
                      ? AppColors.buttonColor
                      : isFemale
                      ? femaleColorController.selectedColor
                      : AppColors.buttonColor2,
              value: searchDetailsController.sliderValue.value,
              divisions: 10,
              onChanged: (double value) {
                searchDetailsController.updateSliderValue(value);
                searchDetailsController.updateRatingValue(value);
              },
            ),
          ),
        ],
      ),
    );
  }
}
