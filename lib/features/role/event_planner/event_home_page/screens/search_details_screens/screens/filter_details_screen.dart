import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:blinqo/core/utils/constants/icon_path.dart';
import 'package:blinqo/features/role/event_planner/event_home_page/controllers/search_details_controller/search_details_controller.dart';
import 'package:blinqo/features/role/service_provider/service_profile_page/controller/service_user_profile_controler.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FilterDetailsScreen extends StatelessWidget {
  final themeController = Get.find<SpProfileController>();
  final SearchDetailsController searchDetailsController = Get.put(
    SearchDetailsController(),
  );

  FilterDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final themeMode =
          themeController.isDarkMode.value ? ThemeMode.dark : ThemeMode.light;
      return SafeArea(
        child: Scaffold(
          backgroundColor: AppColors.backgroundColor,
          appBar: AppBar(
            leading: CircleAvatar(
              backgroundColor:
                  themeMode == ThemeMode.dark
                      ? AppColors.primary.withValues(alpha: 0.1)
                      : AppColors.textColor.withValues(alpha: 0.15),
              child: IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color:
                      themeMode == ThemeMode.dark
                          ? AppColors.primary
                          : AppColors.textColor,
                ),

                onPressed: () => Get.back(),
              ),
            ),
            title: Text(
              'Filter',
              style: getTextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: AppColors.textColor,
              ),
            ),
            centerTitle: true,
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 28),
            child: Column(
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.location_on,
                      color: AppColors.buttonColor2,
                      weight: 16,
                    ),
                    SizedBox(width: 6),
                    Text(
                      'Location',
                      style: getTextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: AppColors.textColor,
                      ),
                    ),
                  ],
                ),
                Padding(
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
                          child: PopupMenuButton<String>(
                            initialValue: 'City',
                            color:
                                themeMode == ThemeMode.dark
                                    ? AppColors.textFrieldDarkColor
                                    : AppColors.popUpBackground,
                            onSelected:
                                (value) => searchDetailsController
                                    .updateSelectedCity(value),
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
                      SizedBox(width: 12),
                      Expanded(
                        child: Container(
                          height: 38,
                          decoration: BoxDecoration(
                            color: AppColors.primary,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: PopupMenuButton<String>(
                            initialValue: 'Area',
                            color:
                                themeMode == ThemeMode.dark
                                    ? AppColors.textFrieldDarkColor
                                    : AppColors.popUpBackground,
                            onSelected:
                                (value) => searchDetailsController
                                    .updateSelectedArea(value),
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
                    ],
                  ),
                ),
                SizedBox(height: 42),
                Row(
                  children: [
                    Icon(Icons.calendar_month, color: AppColors.buttonColor2),
                    SizedBox(width: 8),
                    Text(
                      'Date & Availability',
                      style: getTextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: AppColors.textColor,
                      ),
                    ),
                  ],
                ),

                Padding(
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
                                color: AppColors.textColor,
                              ),
                            ),
                            SizedBox(height: 5),
                            Container(
                              height: 38,
                              decoration: BoxDecoration(
                                color: AppColors.primary,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: TextField(
                                decoration: InputDecoration(
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: AppColors.borderColor2,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: AppColors.borderColor2,
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
                                color: AppColors.textColor,
                              ),
                            ),
                            SizedBox(height: 5),
                            Container(
                              height: 38,
                              decoration: BoxDecoration(
                                color: AppColors.primary,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: TextField(
                                decoration: InputDecoration(
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: AppColors.borderColor2,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: AppColors.borderColor2,
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
                ),

                Row(
                  children: [
                    Icon(Icons.reduce_capacity, color: AppColors.buttonColor2),
                    SizedBox(width: 10),
                    Text(
                      'Capacity',
                      style: getTextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: AppColors.textColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Slider(
                  value: 20,
                  max: 100,
                  min: 10,
                  thumbColor: AppColors.buttonColor2,
                  activeColor: AppColors.buttonColor2,
                  onChanged: (Value) {},
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
