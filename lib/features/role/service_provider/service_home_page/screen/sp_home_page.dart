import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/features/role/service_provider/service_home_page/widget/custombookingcard.dart';
import 'package:blinqo/features/role/service_provider/service_home_page/widget/project_request_card.dart';
import 'package:blinqo/features/role/service_provider/service_home_page/widget/upcoming_project_card.dart'
    show UpcomingProjectCard;
import 'package:blinqo/features/role/service_provider/service_profile_page/controller/service_user_profile_controler.dart';

import 'package:easy_date_timeline/easy_date_timeline.dart'
    show
        DayStructure,
        DayStyle,
        EasyDateTimeLine,
        EasyDayProps,
        EasyHeaderProps,
        EasyTimeLineProps,
        MonthPickerType;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:blinqo/core/utils/constants/icon_path.dart';
import 'package:blinqo/features/role/service_provider/service_home_page/controller/sp_home_Controller.dart';

class SpHomePage extends StatelessWidget {
  SpHomePage({super.key});
  final SpHomeController spHomeController = Get.put(SpHomeController());
  final controller = Get.put(SpProfileController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final themeMode =
          controller.isDarkMode.value ? ThemeMode.dark : ThemeMode.light;

      return Scaffold(
        backgroundColor:
            themeMode == ThemeMode.dark
                ? Colors.black
                : AppColors.backgroundColor,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          forceMaterialTransparency: true,
          centerTitle: false,
          title: Row(
            children: [
              CircleAvatar(
                backgroundColor: Colors.grey.shade200,
                child: Image.asset(IconPath.sphprofile, width: 40, height: 40),
              ),
              SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Dianne Russell",
                    style: TextStyle(
                      color:
                          themeMode == ThemeMode.dark
                              ? AppColors.primary
                              : AppColors.borderColor2,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    "Service Provider",
                    style: TextStyle(
                      color:
                          themeMode == ThemeMode.dark
                              ? AppColors.hintTextColor
                              : Color(0xFF898989),
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ],
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      controller.toggleDarkMode();
                    },
                    child: Container(
                      width: 80,
                      height: 42,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        color: AppColors.buttonColor,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        child: Center(
                          child: Text(
                            'Go Pro',
                            style: getTextStyle(
                              color: AppColors.borderColor2,
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  GestureDetector(
                    onTap: () {},
                    child: Image.asset(
                      IconPath.notifications,
                      width: 24,
                      height: 24,
                      color:
                          themeMode == ThemeMode.dark
                              ? AppColors.buttonColor
                              : AppColors.buttonColor2,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              children: [
                SizedBox(height: 30),
                Column(
                  children: [
                    EasyDateTimeLine(
                      initialDate: DateTime.now(),
                      onDateChange: (selectedDate) {
                        spHomeController.updateSelectedDate(selectedDate);
                      },

                      headerProps: EasyHeaderProps(
                        monthPickerType: MonthPickerType.switcher,
                        monthStyle: getTextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color:
                              themeMode == ThemeMode.dark
                                  ? AppColors.primary
                                  : AppColors.buttonColor2,
                        ),
                        showSelectedDate: false,
                        centerHeader: true,
                      ),
                      dayProps: EasyDayProps(
                        dayStructure: DayStructure.dayStrDayNum,
                        height: 58,
                        width: 33,
                        activeDayStyle: DayStyle(
                          borderRadius: 32.0,
                          decoration: BoxDecoration(
                            color: AppColors.buttonColor2,
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                          ),
                        ),
                        inactiveDayStyle: DayStyle(borderRadius: 8),

                        // ignore: deprecated_member_use
                        activeDayNumStyle: getTextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary,
                        ),
                        // ignore: deprecated_member_use
                        inactiveDayNumStyle: getTextStyle(
                          fontSize: 12,
                          color:
                              themeMode == ThemeMode.dark
                                  ? AppColors.primary
                                  : AppColors.textColor,
                          fontWeight: FontWeight.w500,
                        ),

                        // ignore: deprecated_member_use
                        activeDayStrStyle: getTextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primary,
                        ),
                        // ignore: deprecated_member_use
                        inactiveDayStrStyle: getTextStyle(
                          fontSize: 12,
                          color:
                              themeMode == ThemeMode.dark
                                  ? AppColors.primary
                                  : AppColors.textColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      timeLineProps: const EasyTimeLineProps(
                        hPadding: 20.0,
                        separatorPadding: 20.0,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 40),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "You’ve Got One Booking Today",
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
                SizedBox(height: 10),
                SizedBox(
                  height: 152,
                  child: PageView.builder(
                    controller: spHomeController.pageController,
                    reverse: false,
                    scrollDirection: Axis.horizontal,
                    onPageChanged: (index) {
                      spHomeController.setPage(index);
                    },
                    itemCount: spHomeController.bookings.length,
                    itemBuilder: (context, index) {
                      final item = spHomeController.bookings[index];
                      return CustomBookingCard(
                        title: item["title"] ?? '',
                        description: item["description"] ?? '',
                        day: item["day"] ?? '',
                        date: item["date"] ?? '',
                      );
                    },
                  ),
                ),
                SizedBox(height: 10),
                Obx(() {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(spHomeController.bookings.length, (
                      index,
                    ) {
                      return AnimatedContainer(
                        duration: Duration(milliseconds: 300),
                        margin: EdgeInsets.symmetric(horizontal: 4),
                        width:
                            spHomeController.currentPageIndex.value == index
                                ? 23
                                : 6,
                        height: 6,
                        decoration: BoxDecoration(
                          color:
                              spHomeController.currentPageIndex.value == index
                                  ? themeMode == ThemeMode.dark
                                      ? AppColors.primary
                                      : AppColors.textColor
                                  : AppColors.indicatorColors,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      );
                    }),
                  );
                }),
                SizedBox(height: 40),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Upcoming Project",
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
                      onTap: () {},
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
                SizedBox(height: 40),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Project Requests",
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
                      onTap: () {},
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
                Column(
                  children: List.generate(
                    spHomeController.projectRequests.length,
                    (index) {
                      var project = spHomeController.projectRequests[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 3.0),
                        child: ProjectRequestCard(
                          title: project['title']!,
                          location: project['location']!,
                          date: project['date']!,
                          time: project['time']!,
                          logoPath: project['logo']!,
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(height: 80),

                // Obx(() {
                //   if (!spHomeController.hasdata.value) {
                //     return Column(
                //       children: [
                //         Image.asset(
                //           ImagePath.homenodata,
                //           width: double.infinity,
                //           height: 250,
                //         ),
                //         SizedBox(height: 28),
                //         Text(
                //           "No Bookings Yet",
                //           style: getTextStyle(
                //             fontSize: 14,
                //             fontWeight: FontWeight.w400,
                //             color: AppColors.textColor,
                //           ),
                //         ),
                //       ],
                //     );
                //   } else {
                //     return Expanded(
                //       child: Column(
                //         children: [
                //           Expanded(
                //             child: PageView.builder(
                //               controller: spHomeController.pageController,
                //               itemCount: spHomeController.tasks.length,
                //               onPageChanged: (index) {
                //                 spHomeController.setPage(index);
                //               },
                //               itemBuilder: (context, index) {
                //                 var task = spHomeController.tasks[index];
                //                 return TaskCard(
                //                   title: task["title"]!,
                //                   date: task["date"]!,
                //                   day: task["day"]!,
                //                   description: task["description"]!,
                //                 );
                //               },
                //             ),
                //           ),
                //           // Custom page indicator
                //           Obx(() {
                //             return Container(
                //               padding: const EdgeInsets.symmetric(vertical: 10),
                //               child: Row(
                //                 mainAxisAlignment: MainAxisAlignment.center,
                //                 children: List.generate(
                //                   spHomeController.tasks.length,
                //                   (index) {
                //                     return AnimatedContainer(
                //                       duration: Duration(milliseconds: 300),
                //                       margin: EdgeInsets.symmetric(
                //                         horizontal: 4,
                //                       ),
                //                       width:
                //                           spHomeController
                //                                       .currentPageIndex
                //                                       .value ==
                //                                   index
                //                               ? 20
                //                               : 8,
                //                       height: 8,
                //                       decoration: BoxDecoration(
                //                         color:
                //                             spHomeController
                //                                         .currentPageIndex
                //                                         .value ==
                //                                     index
                //                                 ? Colors.blue
                //                                 : Colors.grey,
                //                         borderRadius: BorderRadius.circular(4),
                //                       ),
                //                     );
                //                   },
                //                 ),
                //               ),
                //             );
                //           }),
                //         ],
                //       ),
                //     );
                //   }
                // }),
              ],
            ),
          ),
        ),
      );
    });
  }
}
