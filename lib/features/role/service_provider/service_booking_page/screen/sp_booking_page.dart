import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:blinqo/core/utils/constants/icon_path.dart';
import 'package:blinqo/features/role/event_planner/event_home_page/sharch_start_booking/screen/search_start_booking.dart';
import 'package:blinqo/features/role/service_provider/service_booking_page/controller/sp_booking_controller.dart';
import 'package:blinqo/features/role/service_provider/service_booking_page/screen/sp_project_request.dart';
import 'package:blinqo/features/role/service_provider/service_booking_page/widget/sp_custom_booking_request.dart';
import 'package:blinqo/features/role/service_provider/service_booking_page/widget/sp_custom_calender.dart';
import 'package:blinqo/features/role/service_provider/service_booking_page/widget/sp_status_label.dart';
import 'package:blinqo/features/role/service_provider/service_home_page/controller/sp_home_Controller.dart';
import 'package:blinqo/features/role/service_provider/service_home_page/widget/upcoming_project_card.dart';
import 'package:blinqo/features/role/service_provider/service_profile_page/controller/service_user_profile_controler.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SpBookingPage extends StatelessWidget {
  SpBookingPage({super.key});
  final SpBookingController spBookingController = Get.put(
    SpBookingController(),
  );
  final controller = Get.put(SpProfileController());
  final SpHomeController spHomeController = Get.put(SpHomeController());
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final themeMode =
          controller.isDarkMode.value ? ThemeMode.dark : ThemeMode.light;
      return Scaffold(
        backgroundColor:
            themeMode == ThemeMode.dark
                ? AppColors.darkBackgroundColor
                : AppColors.backgroundColor,
        appBar: AppBar(
          forceMaterialTransparency: true,
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: Text(
            "Booking",
            style: getTextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color:
                  themeMode == ThemeMode.dark
                      ? AppColors.primary
                      : AppColors.textColor,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              children: [
                // this is for there is no data
                // Column(
                //   children: [
                //     SizedBox(height: 28),
                //     Row(
                //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //       children: [
                //         Text(
                //           "Booking List",
                //           style: getTextStyle(
                //             fontSize: 20,
                //             fontWeight: FontWeight.w600,
                //             color: AppColors.buttonColor2,
                //           ),
                //         ),
                //         Container(
                //           width: 95,
                //           height: 40,
                //           decoration: BoxDecoration(
                //             borderRadius: BorderRadius.circular(4),
                //             border: Border.all(
                //               color: AppColors.subTextColor2,
                //               width: 1,
                //             ),
                //           ),
                //           child: Center(
                //             child: Row(
                //               mainAxisAlignment: MainAxisAlignment.center,
                //               children: [
                //                 Text(
                //                   "Short By",
                //                   style: getTextStyle(
                //                     fontSize: 12,
                //                     fontWeight: FontWeight.w600,
                //                     color: AppColors.subTextColor2,
                //                   ),
                //                 ),
                //                 SizedBox(width: 4),
                //                 Image.asset(
                //                   IconPath.arrowdown,
                //                   width: 16,
                //                   height: 16,
                //                 ),
                //               ],
                //             ),
                //           ),
                //         ),
                //       ],
                //     ),
                //     SizedBox(height: 40),
                //     Image.asset(
                //       ImagePath.homenodata,
                //       width: double.infinity,
                //       height: 250,
                //     ),
                //     SizedBox(height: 28),
                //     Text(
                //       "No Bookings Yet",
                //       style: getTextStyle(
                //         fontSize: 14,
                //         fontWeight: FontWeight.w400,
                //         color: AppColors.textColor,
                //       ),
                //     ),
                //   ],
                // ),
                SizedBox(height: 20),
                SpCustomCalender(selectedDatesNotifier: selectedDatesNotifier),
                SizedBox(height: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SpStatusLabel(
                      color:
                          themeMode == ThemeMode.dark
                              ? AppColors.darkCalendarColor
                              : AppColors.darkTextColor,
                      label: 'Booked',
                    ),
                    SizedBox(height: 8),
                    SpStatusLabel(
                      color:
                          themeMode == ThemeMode.dark
                              ? AppColors.darkCalendarColor2
                              : AppColors.buttonColor,
                      label: 'Selected',
                    ),
                  ],
                ),
                SizedBox(height: 12),
                Container(
                  decoration: BoxDecoration(
                    color:
                        themeMode == ThemeMode.dark
                            ? AppColors.textFrieldDarkColor
                            : AppColors.primary,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Selected Date",
                              style: getTextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color:
                                    themeMode == ThemeMode.dark
                                        ? AppColors.primary
                                        : AppColors.textColor,
                              ),
                            ),
                            Text(
                              "1 November, 2025",
                              style: getTextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color:
                                    themeMode == ThemeMode.dark
                                        ? AppColors.darkCalendarColor2
                                        : AppColors.buttonColor,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Price",
                              style: getTextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color:
                                    themeMode == ThemeMode.dark
                                        ? AppColors.primary
                                        : AppColors.textColor,
                              ),
                            ),
                            SizedBox(
                              height: 42,
                              width: 93,
                              child: TextField(
                                style: getTextStyle(
                                  fontSize: 16,
                                  color:
                                      themeMode == ThemeMode.dark
                                          ? AppColors.darkCalendarColor2
                                          : AppColors.buttonColor,
                                ),
                                textAlign: TextAlign.center,
                                controller: spBookingController.priceController,
                                decoration: InputDecoration(
                                  hintText: "\$5000",
                                  label: Text("Price"),
                                  labelStyle: getTextStyle(
                                    fontSize: 16,
                                    color: AppColors.borderColor,
                                  ),
                                  hintStyle: getTextStyle(
                                    fontSize: 16,
                                    color:
                                        themeMode == ThemeMode.dark
                                            ? AppColors.darkCalendarColor2
                                            : AppColors.buttonColor,
                                  ),
                                  contentPadding: EdgeInsets.symmetric(
                                    vertical: 12.0,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 16),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              width: 1,
                              color:
                                  themeMode == ThemeMode.dark
                                      ? AppColors.buttonColor
                                      : AppColors.buttonColor2,
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 32,
                              vertical: 16.0,
                            ),
                            child: Text(
                              "Save Chage",
                              style: getTextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color:
                                    themeMode == ThemeMode.dark
                                        ? AppColors.buttonColor
                                        : AppColors.buttonColor2,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 40),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Booking Requests",
                    style: getTextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color:
                          themeMode == ThemeMode.dark
                              ? AppColors.primary
                              : AppColors.textColor,
                    ),
                  ),
                ),
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Get.to(SpProjectRequest());
                      },
                      child: Row(
                        children: [
                          Text(
                            "Explore All",
                            style: getTextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color:
                                  themeMode == ThemeMode.dark
                                      ? AppColors.primary
                                      : AppColors.textColor,
                            ),
                          ),
                          SizedBox(width: 8),
                          Image.asset(
                            IconPath.exploreallright,
                            width: 13,
                            height: 6,
                            color:
                                themeMode == ThemeMode.dark
                                    ? AppColors.primary
                                    : AppColors.textColor,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                SpCustomBookingRequest(
                  title: 'Corporate Event',
                  location: 'The Grand Hall',
                  date: '15 March,2025',
                  time: '3:00 PM',
                  logoPath: IconPath.corporateEventLogo,
                  onTap: () {
                    Get.to(SpProjectRequest());
                  },
                ),

                SpCustomBookingRequest(
                  title: 'Corporate Event',
                  location: 'The Grand Hall',
                  date: '15 March,2025',
                  time: '3:00 PM',
                  logoPath: IconPath.corporateEventLogo,
                  onTap: () {
                    Get.to(SpProjectRequest());
                  },
                ),
                SpCustomBookingRequest(
                  title: 'Corporate Event',
                  location: 'The Grand Hall',
                  date: '15 March,2025',
                  time: '3:00 PM',
                  logoPath: IconPath.corporateEventLogo,
                  onTap: () {
                    Get.to(SpProjectRequest());
                  },
                ),
                SizedBox(height: 40),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    "All project",
                    style: getTextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color:
                          themeMode == ThemeMode.dark
                              ? AppColors.primary
                              : AppColors.textColor,
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Column(
                  children: List.generate(
                    spHomeController.upcomingProjects.length > 3
                        ? 3
                        : spHomeController.upcomingProjects.length,
                    (index) {
                      var project = spHomeController.upcomingProjects[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        child: UpcomingProjectCard(
                          title: project['title']!,
                          location: project['location']!,
                          date: project['date']!,
                          time: project['time']!,
                          logoPath: project['uplogo']!,
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(height: 110),
              ],
            ),
          ),
        ),
      );
    });
  }
}
