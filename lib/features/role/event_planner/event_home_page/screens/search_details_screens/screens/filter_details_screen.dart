import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:blinqo/core/utils/constants/icon_path.dart';
import 'package:blinqo/features/role/event_planner/event_home_page/controllers/search_details_controller/search_details_controller.dart';
import 'package:blinqo/features/role/event_planner/event_home_page/screens/search_details_screens/widget/filter_booking_type.dart';
import 'package:blinqo/features/role/event_planner/event_home_page/screens/search_details_screens/widget/filter_capacity.dart';
import 'package:blinqo/features/role/event_planner/event_home_page/screens/search_details_screens/widget/filter_data_availability.dart';
import 'package:blinqo/features/role/event_planner/event_home_page/screens/search_details_screens/widget/filter_location.dart';
import 'package:blinqo/features/role/event_planner/event_home_page/screens/search_details_screens/widget/filter_ratings_reviews.dart';
import 'package:blinqo/features/role/event_planner/event_home_page/screens/search_details_screens/widget/filter_vanue_type.dart';
import 'package:blinqo/features/role/event_planner/event_home_page/screens/search_details_screens/widget/filter_toggle_button.dart';
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
            backgroundColor: AppColors.backgroundColor,
            scrolledUnderElevation: 0,
            leading: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: CircleAvatar(
                backgroundColor:
                    themeMode == ThemeMode.dark
                        ? AppColors.primary.withValues(alpha: 0.1)
                        : AppColors.textColor.withValues(alpha: 0.15),
                child: IconButton(
                  padding: EdgeInsets.all(0),
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
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 28),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
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
                  Location(
                    themeMode: themeMode,
                    searchDetailsController: searchDetailsController,
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

                  DataAvailability(),
                  SizedBox(height: 40),
                  Row(
                    children: [
                      Icon(
                        Icons.reduce_capacity,
                        color: AppColors.buttonColor2,
                      ),
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

                  Capacity(searchDetailsController: searchDetailsController),
                  SizedBox(height: 24),
                  VanueType(
                    themeMode: themeMode,
                    searchDetailsController: searchDetailsController,
                  ),
                  SizedBox(height: 30),
                  Row(
                    children: [
                      Image.asset(IconPath.shoppingmode, width: 20),
                      SizedBox(width: 8),
                      Text(
                        'Booking Type',
                        style: getTextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: AppColors.textColor,
                        ),
                      ),
                    ],
                  ),
                  BookingType(searchDetailsController: searchDetailsController),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Image.asset(IconPath.cardsstar, width: 19),
                      SizedBox(width: 8),
                      Text(
                        'Ratings & Reviews',
                        style: getTextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: AppColors.textColor,
                        ),
                      ),
                    ],
                  ),
                  RatingsReviews(
                    searchDetailsController: searchDetailsController,
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Obx(
                        () => Radio(
                          value: 0,
                          groupValue: searchDetailsController.selectedTab.value,
                          onChanged: (int? value) {
                            if (value != null) {
                              searchDetailsController.toggleTab(value);
                            }
                          },
                          activeColor: AppColors.buttonColor2,
                        ),
                      ),
                      SizedBox(width: 6),
                      Text(
                        'Verified',
                        style: getTextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: AppColors.textColor,
                        ),
                      ),
                    ],
                  ),
                  ToggleButton(),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
