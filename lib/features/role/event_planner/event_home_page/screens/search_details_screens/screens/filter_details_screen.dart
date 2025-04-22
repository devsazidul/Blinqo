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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(left: 10),
                                    child: Text(
                                      searchDetailsController
                                          .selectedCity
                                          .value,
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(left: 10),
                                    child: Text(
                                      searchDetailsController
                                          .selectedArea
                                          .value,
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

                  Column(
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
                                  searchDetailsController.capacityStart.value
                                      .toStringAsFixed(0),
                                  searchDetailsController.capacityEnd.value
                                      .toStringAsFixed(0),
                                ),

                                activeColor: AppColors.buttonColor2,
                                inactiveColor: AppColors.appBarIcolor,
                                onChanged: (RangeValues values) {
                                  searchDetailsController.capacityStartValue(
                                    values.start,
                                  );
                                  searchDetailsController.capacityEndValue(
                                    values.end,
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20),
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 11,
                            backgroundColor: Colors.white,
                            child: Image.asset(IconPath.group),
                          ),
                          SizedBox(width: 8),
                          Text(
                            'Price Range',
                            style: getTextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: AppColors.textColor,
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
                                  searchDetailsController.priceStart.value,
                                  searchDetailsController.priceEnd.value,
                                ),
                                min: 0,
                                max: 12000,
                                divisions: 12000,
                                labels: RangeLabels(
                                  searchDetailsController.priceStart.value
                                      .toStringAsFixed(0),
                                  searchDetailsController.priceEnd.value
                                      .toStringAsFixed(0),
                                ),

                                activeColor: AppColors.buttonColor2,
                                inactiveColor: AppColors.appBarIcolor,
                                onChanged: (RangeValues values) {
                                  searchDetailsController.priceRangeStart(
                                    values.start,
                                  );
                                  searchDetailsController.priceRangeEnd(
                                    values.end,
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 24),
                  Row(
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
                            child: PopupMenuButton<String>(
                              //initialValue: 'City',
                              color:
                                  themeMode == ThemeMode.dark
                                      ? AppColors.textFrieldDarkColor
                                      : AppColors.popUpBackground,
                              onSelected:
                                  (value) => searchDetailsController
                                      .updateVenue(value),
                              itemBuilder: (context) {
                                return searchDetailsController.venueType.map((
                                  role,
                                ) {
                                  return PopupMenuItem<String>(
                                    value: role,
                                    child: Text(role),
                                  );
                                }).toList();
                              },

                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                  Image.asset(
                                    IconPath.arrowdown,
                                    width: 16,
                                    height: 16,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
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
                  Padding(
                    padding: EdgeInsets.only(left: 16),
                    child: Row(
                      children: [
                        Obx(
                          () => Expanded(
                            child: Radio(
                              toggleable: true,
                              activeColor: AppColors.textColor,
                              value: 1,
                              groupValue:
                                  searchDetailsController
                                      .selectedBookingValue
                                      .value,
                              onChanged: (int? value) {
                                if (value != null) {
                                  searchDetailsController.toggleBooking();
                                }
                              },
                            ),
                          ),
                        ),
                        Text(
                          'Instant booking',
                          style: getTextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w300,
                            color: AppColors.textColor,
                          ),
                        ),
                        Obx(
                          () => Expanded(
                            child: Radio(
                              toggleable: true,
                              activeColor: AppColors.textColor,
                              value: 0,
                              groupValue:
                                  searchDetailsController
                                      .selectedBookingValue
                                      .value,
                              onChanged: (int? value) {
                                if (value != null) {
                                  searchDetailsController.toggleBooking();
                                }
                              },
                            ),
                          ),
                        ),
                        Text(
                          'request-based booking',
                          style: getTextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w300,
                            color: AppColors.textColor,
                          ),
                        ),
                      ],
                    ),
                  ),
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
                  Padding(
                    padding: EdgeInsets.only(left: 30),
                    child: Row(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.primary,
                            borderRadius: BorderRadius.circular(6),
                          ),

                          child: Row(
                            children: [
                              Icon(
                                Icons.star,
                                color: AppColors.reviesStarColor,
                                size: 12,
                              ),
                              SizedBox(width: 6),
                              Text(
                                '4.5',
                                style: getTextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w300,
                                  color: AppColors.subTextColor2,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Slider(
                          min: 0,
                          max: 100,
                          thumbColor: AppColors.thumbColor,
                          activeColor: AppColors.buttonColor2,
                          value: searchDetailsController.sliderValue.value,
                          divisions: 100,
                          onChanged: (double value) {
                            searchDetailsController.updateSliderValue(value);
                          },
                        ),
                      ],
                    ),
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          side: BorderSide(color: AppColors.buttonColor2),
                        ),
                        onPressed: () {},
                        child: Text(
                          'Cancel',
                          style: getTextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: AppColors.textColor,
                          ),
                        ),
                      ),
                      SizedBox(width: 6),
                      OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          side: BorderSide(color: AppColors.buttonColor2),
                          backgroundColor: AppColors.buttonColor2,
                        ),
                        onPressed: () {},
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
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
