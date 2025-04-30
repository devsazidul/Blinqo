import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:blinqo/core/utils/constants/icon_path.dart';
import 'package:blinqo/features/profile/controller/pick_color_controller.dart';
import 'package:blinqo/features/profile/controller/profile_controller.dart';
import 'package:blinqo/features/role/event_planner/event_home_page/controllers/search_details_controller/search_details_controller.dart';
import 'package:blinqo/features/role/event_planner/event_home_page/screens/search_details_screens/widget/filter_booking_type.dart';
import 'package:blinqo/features/role/event_planner/event_home_page/screens/search_details_screens/widget/filter_capacity.dart';
import 'package:blinqo/features/role/event_planner/event_home_page/screens/search_details_screens/widget/filter_data_availability.dart';
import 'package:blinqo/features/role/event_planner/event_home_page/screens/search_details_screens/widget/filter_location.dart';
import 'package:blinqo/features/role/event_planner/event_home_page/screens/search_details_screens/widget/filter_ratings_reviews.dart';
import 'package:blinqo/features/role/event_planner/event_home_page/screens/search_details_screens/widget/filter_toggle_button.dart';
import 'package:blinqo/features/role/event_planner/event_home_page/screens/search_details_screens/widget/filter_vanue_type.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FilterDetailsScreen extends StatelessWidget {
  final ProfileController themeController = Get.put(ProfileController());
  final SearchDetailsController searchDetailsController = Get.put(
    SearchDetailsController(),
  );
  final PickColorController femaleColorController = Get.put(
    PickColorController(),
  );
  FilterDetailsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = themeController.isDarkMode.value;
    final bool isFemale = femaleColorController.isFemale.value;
    return Scaffold(
      backgroundColor:
          isDarkMode
              ? AppColors.darkBackgroundColor
              : AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor:
            isDarkMode
                ? AppColors.darkBackgroundColor
                : AppColors.backgroundColor,
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
                Navigator.of(context).pop();
              },
            ),
          ),
        ),
        title: Text(
          'Filter',
          style: getTextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: isDarkMode ? AppColors.borderColor2 : AppColors.textColor,
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
                    color:
                        isDarkMode
                            ? AppColors.buttonColor
                            : isFemale
                            ? femaleColorController.selectedColor
                            : AppColors.buttonColor2,
                    weight: 16,
                  ),
                  SizedBox(width: 6),
                  Text(
                    'Location',
                    style: getTextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color:
                          isDarkMode
                              ? AppColors.borderColor2
                              : AppColors.textColor,
                    ),
                  ),
                ],
              ),
              Location(searchDetailsController: searchDetailsController),
              SizedBox(height: 42),
              Row(
                children: [
                  Icon(
                    Icons.calendar_month,
                    color:
                        isDarkMode
                            ? AppColors.buttonColor
                            : isFemale
                            ? femaleColorController.selectedColor
                            : AppColors.buttonColor2,
                  ),
                  SizedBox(width: 8),
                  Text(
                    'Date & Availability',
                    style: getTextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color:
                          isDarkMode
                              ? AppColors.borderColor2
                              : AppColors.textColor,
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
                    color:
                        isDarkMode
                            ? AppColors.buttonColor
                            : isFemale
                            ? femaleColorController.selectedColor
                            : AppColors.buttonColor2,
                  ),
                  SizedBox(width: 10),
                  Text(
                    'Capacity',
                    style: getTextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color:
                          isDarkMode
                              ? AppColors.borderColor2
                              : AppColors.textColor,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Capacity(searchDetailsController: searchDetailsController),
              SizedBox(height: 24),
              VanueType(searchDetailsController: searchDetailsController),
              SizedBox(height: 30),
              Row(
                children: [
                  Image.asset(
                    IconPath.shoppingmode,
                    width: 20,
                    color:
                        isDarkMode
                            ? AppColors.buttonColor
                            : isFemale
                            ? femaleColorController.selectedColor
                            : AppColors.buttonColor2,
                  ),
                  SizedBox(width: 8),
                  Text(
                    'Booking Type',
                    style: getTextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color:
                          isDarkMode
                              ? AppColors.borderColor2
                              : AppColors.textColor,
                    ),
                  ),
                ],
              ),
              BookingType(searchDetailsController: searchDetailsController),
              SizedBox(height: 20),
              Row(
                children: [
                  Image.asset(
                    IconPath.cardsstar,
                    width: 19,
                    color:
                        isDarkMode
                            ? AppColors.buttonColor
                            : isFemale
                            ? femaleColorController.selectedColor
                            : AppColors.buttonColor2,
                  ),
                  SizedBox(width: 8),
                  Text(
                    'Ratings & Reviews',
                    style: getTextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color:
                          isDarkMode
                              ? AppColors.borderColor2
                              : AppColors.textColor,
                    ),
                  ),
                ],
              ),
              RatingsReviews(searchDetailsController: searchDetailsController),
              Obx(
                () => Row(
                  children: [
                    InkWell(
                      onTap: () {
                        searchDetailsController.toggleTab(0);
                      },
                      child: Container(
                        width: 14,
                        height: 14,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color:
                                searchDetailsController.selectedTab.value == 0
                                    ? (isDarkMode
                                        ? AppColors.buttonColor
                                        : isFemale
                                        ? femaleColorController.selectedColor
                                        : AppColors.buttonColor2)
                                    : Colors.grey,
                            width: 2,
                          ),
                        ),
                        child:
                            searchDetailsController.selectedTab.value == 0
                                ? Center(
                                  child: Container(
                                    width: 12,
                                    height: 12,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color:
                                          isDarkMode
                                              ? AppColors.buttonColor
                                              : isFemale
                                              ? femaleColorController
                                                  .selectedColor
                                              : AppColors.buttonColor2,
                                    ),
                                  ),
                                )
                                : null,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Verified',
                      style: getTextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color:
                            isDarkMode
                                ? AppColors.borderColor2
                                : AppColors.textColor,
                      ),
                    ),
                  ],
                ),
              ),
              ToggleButton(),
              SizedBox(height: 58),
            ],
          ),
        ),
      ),
    );
  }
}
