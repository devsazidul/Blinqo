import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:blinqo/core/utils/constants/icon_path.dart';
import 'package:blinqo/features/role/event_planner/event_home_page/controllers/search_details_controller/search_details_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

class Location extends StatelessWidget {
  const Location({
    super.key,
    required this.themeMode,
    required this.searchDetailsController,
  });

  final ThemeMode themeMode;
  final SearchDetailsController searchDetailsController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 28, top: 7),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 38,
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Obx(
                () => PopupMenuButton<String>(
                  initialValue: 'City',
                  color:
                      themeMode == ThemeMode.dark
                          ? AppColors.textFrieldDarkColor
                          : AppColors.popUpBackground,
                  onSelected:
                      (value) =>
                          searchDetailsController.updateSelectedCity(value),
                  itemBuilder: (context) {
                    return searchDetailsController.city.map((role) {
                      return PopupMenuItem<String>(
                        value: role,
                        child: Text(role),
                      );
                    }).toList();
                  },

                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: Text(
                          searchDetailsController.selectedCity.value,
                          style: getTextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w300,
                            color: AppColors.subTextColor2,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: 8),
                        child: Image.asset(
                          IconPath.arrowdown,
                          width: 16,
                          height: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Container(
              height: 38,
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Obx(
                () => PopupMenuButton<String>(
                  initialValue: 'Area',
                  color:
                      themeMode == ThemeMode.dark
                          ? AppColors.textFrieldDarkColor
                          : AppColors.popUpBackground,
                  onSelected:
                      (value) =>
                          searchDetailsController.updateSelectedArea(value),
                  itemBuilder: (context) {
                    return searchDetailsController.area.map((role) {
                      return PopupMenuItem<String>(
                        value: role,
                        child: Text(role),
                      );
                    }).toList();
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: Text(
                          searchDetailsController.selectedArea.value,
                          style: getTextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w300,
                            color: AppColors.subTextColor2,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: 8),
                        child: Image.asset(
                          IconPath.arrowdown,
                          width: 16,
                          height: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
