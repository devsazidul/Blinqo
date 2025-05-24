import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:blinqo/core/utils/constants/icon_path.dart';
import 'package:blinqo/features/role/event_planner/event_home_page/controllers/search_details_controller/search_details_controller.dart';
import 'package:blinqo/features/role/event_planner/profile/controller/pick_color_controller.dart';
import 'package:blinqo/features/role/event_planner/profile/controller/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Capacity extends StatelessWidget {
  Capacity({super.key, required this.searchDetailsController});
  final ProfileController themeController = Get.put(ProfileController());
  final SearchDetailsController searchDetailsController;
  final PickColorController femaleColorController = Get.put(
    PickColorController(),
  );

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = themeController.isDarkMode.value;
    final bool isFemale = femaleColorController.isFemale.value;
    return Column(
      children: [
        Obx(
          () => Row(
            children: [
              Expanded(
                child: RangeSlider(
                  values: RangeValues(
                    searchDetailsController.capacityStart.value,
                    searchDetailsController.capacityEnd.value,
                  ),
                  min: 0,
                  max: 1000,
                  divisions: 1000,
                  labels: RangeLabels(
                    searchDetailsController.priceStart.value.toStringAsFixed(0),
                    searchDetailsController.priceEnd.value.toStringAsFixed(0),
                  ),

                  activeColor:
                      isDarkMode
                          ? AppColors.buttonColor
                          : isFemale
                          ? femaleColorController.selectedColor
                          : AppColors.buttonColor2,
                  inactiveColor: AppColors.appBarIcolor,
                  onChanged: (RangeValues values) {
                    searchDetailsController.capacityStartValue(values.start);
                    searchDetailsController.capacityEndValue(values.end);
                  },
                ),
              ),
            ],
          ),
        ),

        // ----------------------------- Text field for capacity ----------------------------
        Padding(
          padding: const EdgeInsets.only(left: 32),
          child: Align(
            alignment: Alignment.centerLeft,
            child: SizedBox(
              width: 155,
              child: TextFormField(
                decoration: InputDecoration(
                  isDense: true,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 10,
                  ),
                  hintText: 'Enter Capacity',
                  hintStyle: const TextStyle(
                    color: Color(0xFFABB7C2),
                    fontSize: 12,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w300,
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(
                      width: 1,
                      color: Color(0xFFEBEBEB),
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(
                      width: 1,
                      color: Color(0xFFEBEBEB),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(
                      width: 1,
                      color: Color(0xFFEBEBEB),
                    ),
                  ),
                ),
                style: const TextStyle(
                  fontSize: 12,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w300,
                ),
                textAlign: TextAlign.start,
              ),
            ),
          ),
        ),

        // ----------------------------- Text field for capacity ----------------------------
        SizedBox(height: 20),

        Row(
          children: [
            Image.asset(
              IconPath.group,
              width: 24,
              color:
                  isDarkMode
                      ? AppColors.buttonColor
                      : isFemale
                      ? femaleColorController.selectedColor
                      : AppColors.iconColor,
            ),
            SizedBox(width: 8),

            Text(
              'Price Range',
              style: getTextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color:
                    isDarkMode ? AppColors.borderColor2 : AppColors.textColor,
              ),
            ),
          ],
        ),
        SizedBox(height: 20),

        Obx(
          () => Row(
            children: [
              SizedBox(height: 20),
              Expanded(
                child: RangeSlider(
                  values: RangeValues(
                    searchDetailsController.priceStart.value.clamp(
                      12000,
                      150000,
                    ),
                    searchDetailsController.priceEnd.value.clamp(12000, 150000),
                  ),
                  min: 12000,
                  max: 150000,
                  divisions: 150000 - 12000,
                  labels: RangeLabels(
                    searchDetailsController.priceStart.value.toStringAsFixed(0),
                    searchDetailsController.priceEnd.value.toStringAsFixed(0),
                  ),

                  activeColor:
                      isDarkMode
                          ? AppColors.buttonColor
                          : isFemale
                          ? femaleColorController.selectedColor
                          : AppColors.buttonColor2,
                  inactiveColor: AppColors.appBarIcolor,
                  onChanged: (RangeValues values) {
                    searchDetailsController.priceRangeStart(values.start);
                    searchDetailsController.priceRangeEnd(values.end);
                  },
                ),
              ),
            ],
          ),
        ),

        // ----------------------------- Text field for price range ----------------------------
        Padding(
          padding: const EdgeInsets.only(left: 32),
          child: Align(
            alignment: Alignment.centerLeft,
            child: SizedBox(
              width: 155,
              child: TextFormField(
                decoration: InputDecoration(
                  isDense: true,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 10,
                  ),
                  hintText: 'Enter Price Range',
                  hintStyle: const TextStyle(
                    color: Color(0xFFABB7C2),
                    fontSize: 12,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w300,
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(
                      width: 1,
                      color: Color(0xFFEBEBEB),
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(
                      width: 1,
                      color: Color(0xFFEBEBEB),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(
                      width: 1,
                      color: Color(0xFFEBEBEB),
                    ),
                  ),
                ),
                style: const TextStyle(
                  fontSize: 12,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w300,
                ),
                textAlign: TextAlign.start,
              ),
            ),
          ),
        ),

        // ----------------------------- Text field for capacity ----------------------------
      ],
    );
  }
}
