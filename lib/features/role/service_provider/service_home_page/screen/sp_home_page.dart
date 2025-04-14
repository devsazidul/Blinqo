import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/features/role/service_provider/service_home_page/widget/custombookingcard.dart';

import 'package:easy_date_timeline/easy_date_timeline.dart'
    show
        DateFormatter,
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
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
                    color: Color(0xFF082B09),
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  "Service Provider",
                  style: TextStyle(
                    color: Color(0xFF898989),
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
                  onTap: () {},
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
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              children: [
                SizedBox(height: 32),
                Column(
                  children: [
                    EasyDateTimeLine(
                      initialDate: DateTime.now(),
                      onDateChange: (selectedDate) {
                        spHomeController.updateSelectedDate(selectedDate);
                      },

                      headerProps: const EasyHeaderProps(
                        monthPickerType: MonthPickerType.switcher,
                        monthStyle: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: AppColors.buttonColor2,
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
                          color: AppColors.textColor,
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
                          color: AppColors.textColor,
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
                      color: AppColors.textColor,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                // Obx(() {
                //   return Column(
                //     children: [
                //       Expanded(
                //         child: PageView.builder(
                //           controller: spHomeController.pageController,
                //           itemCount: spHomeController.tasks.length,
                //           onPageChanged: (index) {
                //             spHomeController.setPage(index);
                //           },
                //           itemBuilder: (context, index) {
                //             var task = spHomeController.tasks[index];
                //             return CustomBookingCard(
                //               title: task["title"]!,
                //               description: task["description"]!,
                //               day: task["day"]!,
                //               date: task["date"]!,
                //             );
                //           },
                //         ),
                //       ),
                //       // Custom page indicator
                //       Container(
                //         padding: const EdgeInsets.symmetric(vertical: 10),
                //         child: Row(
                //           mainAxisAlignment: MainAxisAlignment.center,
                //           children: List.generate(
                //             spHomeController.tasks.length,
                //             (index) {
                //               return AnimatedContainer(
                //                 duration: Duration(milliseconds: 300),
                //                 margin: EdgeInsets.symmetric(horizontal: 4),
                //                 width:
                //                     spHomeController.currentPageIndex.value ==
                //                             index
                //                         ? 20
                //                         : 8,
                //                 height: 8,
                //                 decoration: BoxDecoration(
                //                   color:
                //                       spHomeController.currentPageIndex.value ==
                //                               index
                //                           ? Colors.blue
                //                           : Colors.grey,
                //                   borderRadius: BorderRadius.circular(4),
                //                 ),
                //               );
                //             },
                //           ),
                //         ),
                //       ),
                //     ],
                //   );
                // }),

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
      ),
    );
  }
}
