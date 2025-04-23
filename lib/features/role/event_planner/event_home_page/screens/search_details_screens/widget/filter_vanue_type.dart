import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:blinqo/core/utils/constants/icon_path.dart';
import 'package:blinqo/features/role/event_planner/event_home_page/controllers/search_details_controller/search_details_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class VanueType extends StatelessWidget {
  const VanueType({
    super.key,
    required this.themeMode,
    required this.searchDetailsController,
  });

  final ThemeMode themeMode;
  final SearchDetailsController searchDetailsController;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(Icons.apartment, color: AppColors.buttonColor2),
        SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Venue Type',
              style: getTextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: AppColors.textColor,
              ),
            ),
            SizedBox(height: 10),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8),
              height: 38,
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Obx(
                () => PopupMenuButton<String>(
                  color:
                      themeMode == ThemeMode.dark
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
                          color: AppColors.subTextColor2,
                        ),
                      ),
                      SizedBox(width: 58),
                      Image.asset(IconPath.arrowdown, width: 16, height: 16),
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
