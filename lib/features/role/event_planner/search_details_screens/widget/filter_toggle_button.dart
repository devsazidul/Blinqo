import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:blinqo/features/role/event_planner/event_home_page/controllers/search_details_controller/search_details_controller.dart';
import 'package:blinqo/features/role/event_planner/profile/controller/pick_color_controller.dart';
import 'package:blinqo/features/role/event_planner/profile/controller/profile_controller.dart';
import 'package:blinqo/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ToggleButton extends StatelessWidget {
  final ProfileController themeController = Get.put(ProfileController());
  ToggleButton({super.key});
  final SearchDetailsController searchDetailsController = Get.put(
    SearchDetailsController(),
  );
  final PickColorController femaleColorController = Get.put(
    PickColorController(),
  );
  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = themeController.isDarkMode.value;
    final bool isFemale = femaleColorController.isFemale.value;
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        OutlinedButton(
          style: OutlinedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            side: BorderSide(color: AppColors.buttonColor2),
          ),
          onPressed: () {
            searchDetailsController.allFieldCanceled();
          },
          child: Text(
            'Cancel',
            style: getTextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: isDarkMode ? AppColors.primary : AppColors.textColor,
            ),
          ),
        ),
        SizedBox(width: 6),
        OutlinedButton(
          style: OutlinedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            side: BorderSide(
              color:
                  isDarkMode
                      ? AppColors.buttonColor2
                      : isFemale
                      ? femaleColorController.selectedColor
                      : AppColors.buttonColor2,
            ),
            backgroundColor:
                isDarkMode
                    ? AppColors.buttonColor2
                    : isFemale
                    ? femaleColorController.selectedColor
                    : AppColors.buttonColor2,
          ),
          onPressed: () {
            Navigator.pushNamed(context, AppRoute.getfilterViewScreen());
          },
          child: Text(
            'Apply',
            style: getTextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: AppColors.primary,
            ),
          ),
        ),
      ],
    );
  }
}
