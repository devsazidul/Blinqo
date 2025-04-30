import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:blinqo/core/utils/constants/icon_path.dart';
import 'package:blinqo/features/profile/controller/pick_color_controller.dart';
import 'package:blinqo/features/profile/controller/profile_controller.dart';
import 'package:blinqo/features/role/event_planner/event_home_page/controllers/search_details_controller/search_details_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VanueType extends StatelessWidget {
  VanueType({super.key, required this.searchDetailsController});
  final ProfileController themeController = Get.put(ProfileController());
  final PickColorController femaleColorController = Get.put(
    PickColorController(),
  );

  final SearchDetailsController searchDetailsController;

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = themeController.isDarkMode.value;
    final bool isFemale = femaleColorController.isFemale.value;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          Icons.apartment,
          color:
              isDarkMode
                  ? AppColors.buttonColor
                  : isFemale
                  ? femaleColorController.selectedColor
                  : AppColors.buttonColor2,
        ),
        SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Venue Type',
              style: getTextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color:
                    isDarkMode ? AppColors.borderColor2 : AppColors.textColor,
              ),
            ),
            SizedBox(height: 10),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8),
              height: 38,
              decoration: BoxDecoration(
                color: isDarkMode ? AppColors.cardDarkColor : AppColors.primary,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Obx(
                () => PopupMenuButton<String>(
                  initialValue: 'Brithday Party',
                  color:
                      isDarkMode
                          ? AppColors.textFrieldDarkColor
                          : AppColors.popUpBackground,
                  onSelected:
                      (value) => searchDetailsController.updateVenue(value),
                  itemBuilder: (context) {
                    return searchDetailsController.venueType.map((role) {
                      return PopupMenuItem<String>(
                        value: role,
                        child: Text(role),
                      );
                    }).toList();
                  },

                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        searchDetailsController.selectedVenue.value,
                        style: getTextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w300,
                          color:
                              isDarkMode
                                  ? AppColors.subTextColor2
                                  : AppColors.subTextColor2,
                        ),
                      ),
                      SizedBox(width: 58),
                      Image.asset(
                        IconPath.arrowdown,
                        width: 16,
                        height: 16,
                        color:
                            isDarkMode
                                ? AppColors.borderColor2
                                : AppColors.textColor,
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
