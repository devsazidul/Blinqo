import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/utils/constants/image_path.dart';
import 'package:blinqo/features/role/event_planner/event_home_page/screens/start_booking.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../core/utils/constants/colors.dart';
import '../../../../../core/utils/constants/icon_path.dart';
import '../../service_home_page/widget/booking_list_card.dart';
import '../../service_profile_page/controller/service_user_profile_controler.dart';

class SpEarningPage extends StatelessWidget {
  const SpEarningPage({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    final controller = Get.put(SpProfileController());

    return Obx(() {
      final themeMode =
          controller.isDarkMode.value ? ThemeMode.dark : ThemeMode.light;

      return Scaffold(
        backgroundColor:
            themeMode == ThemeMode.dark ? Colors.black : AppColors.borderColor2,
        appBar: AppBar(
          backgroundColor:
              themeMode == ThemeMode.dark
                  ? Colors.black
                  : AppColors.borderColor2,
          forceMaterialTransparency: true,
          leading:
              themeMode == ThemeMode.dark
                  ? SizedBox()
                  : Padding(
                    padding: EdgeInsets.only(left: screenWidth * 0.05),
                    child: GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: CircleAvatar(
                        backgroundColor: const Color(0xFFD9D9D9),
                        child: Image.asset(
                          width: 16,
                          IconPath.arrowLeftAlt,
                          color: AppColors.textColor,
                        ),
                      ),
                    ),
                  ),
          centerTitle: true,
          title: Text(
            'Booking',
            style: getTextStyle(
              fontSize: screenWidth * 0.05,
              fontWeight: FontWeight.w600,
              color:
                  themeMode == ThemeMode.dark
                      ? AppColors.borderColor2
                      : AppColors.buttonColor2,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: screenHeight * 0.03),

                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Booking List',
                      style: getTextStyle(
                        fontSize: screenWidth * 0.05, // 5% of screen width
                        fontWeight: FontWeight.w600,
                        color:
                            themeMode == ThemeMode.dark
                                ? AppColors.borderColor2
                                : AppColors.buttonColor2,
                      ),
                    ),
                    Spacer(),
                    Container(
                      height: screenHeight * 0.05, // 5% of screen height
                      width: screenWidth * 0.25, // 25% of screen width
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4.r),
                        color:
                            themeMode == ThemeMode.dark
                                ? Colors.black
                                : AppColors.primary,
                        border: Border.all(
                          color:
                              themeMode == ThemeMode.dark
                                  ? AppColors.buttonColor
                                  : AppColors.buttonColor2,
                          width: 1.5,
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Short by',
                            style: getTextStyle(
                              fontSize:
                                  screenWidth * 0.03, // 3% of screen width
                              fontWeight: FontWeight.w400,
                              color:
                                  themeMode == ThemeMode.dark
                                      ? AppColors.buttonColor
                                      : AppColors.buttonColor2,
                            ),
                          ),
                          SizedBox(
                            width: screenWidth * 0.02,
                          ), // 2% of screen width
                          Image.asset(
                            ImagePath.newIcon,
                            width: screenWidth * 0.04, // 4% of screen width
                            height: screenHeight * 0.02, // 2% of screen height
                            color:
                                themeMode == ThemeMode.dark
                                    ? AppColors.buttonColor
                                    : AppColors.buttonColor2,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: screenHeight * 0.03),

                //                 SizedBox(height: screenHeight * 0.03),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'In Progress',
                      style: getTextStyle(
                        fontSize: screenWidth * 0.04,
                        fontWeight: FontWeight.w600,
                        color:
                            themeMode == ThemeMode.dark
                                ? AppColors.borderColor2
                                : AppColors.buttonColor2,
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    // List of 2 "In Progress" bookings with consistent gap
                    ...List.generate(2, (index) {
                      return Padding(
                        padding: EdgeInsets.only(
                          bottom: screenHeight * 0.02,
                        ), // Consistent gap between cards
                        child: BookingListCard(
                          themeMode: themeMode,
                          screenHeight: screenHeight,
                          screenWidth: screenWidth,
                          bookingName: "Wedding Ceremony",
                          bookingDate: "25th December 2023",
                          bookingTime: "5:00 PM - 11:00 PM",
                          bookingLocation: "Grand Hotel, Los Angeles",
                          bookingStatus: "Pending", // Status "Pending"
                          bookingPrice: "\$1200",
                        ),
                      );
                    }),
                  ],
                ),

                // "Completed" Section
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Completed',
                      style: getTextStyle(
                        fontSize: screenWidth * 0.04,
                        fontWeight: FontWeight.w600,
                        color:
                            themeMode == ThemeMode.dark
                                ? AppColors.borderColor2
                                : AppColors.buttonColor2,
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    // List of 1 "Completed" booking with consistent gap
                    Padding(
                      padding: EdgeInsets.only(bottom: screenHeight * 0.02),
                      child: BookingListCard(
                        themeMode: themeMode,
                        screenHeight: screenHeight,
                        screenWidth: screenWidth,
                        bookingName: "Wedding Ceremony",
                        bookingDate: "25th December 2023",
                        bookingTime: "5:00 PM - 11:00 PM",
                        bookingLocation: "Grand Hotel, Los Angeles",
                        bookingStatus: "Completed", // Status "Completed"
                        bookingPrice: "\$1200",
                      ),
                    ),
                  ],
                ),

                // Add Booking Button
                // Container(
                //   height: screenHeight * 0.06,
                //   color: Colors.amber,
                //   width: double.infinity,
                //   child: ElevatedButton(
                //     onPressed: () {},
                //     style: ElevatedButton.styleFrom(
                //       elevation: 0,
                //       backgroundColor: AppColors.buttonColor2,
                //       shape: RoundedRectangleBorder(
                //         borderRadius: BorderRadius.circular(12),
                //       ),
                //     ),
                //     child: Row(
                //       mainAxisAlignment: MainAxisAlignment.center,
                //       children: [
                //         Text(
                //           "Add Booking",
                //           style: getTextStyle(
                //             fontSize: screenWidth * 0.04,
                //             color: Colors.white,
                //           ),
                //         ),
                //         SizedBox(width: screenWidth * 0.02),
                //         Icon(
                //           Icons.add,
                //           size: screenWidth * 0.06,
                //           color: Colors.white,
                //         ),
                //       ],
                //     ),
                //   ),
                // ),
                SizedBox(height: screenHeight * 0.01),

                ElevatedButton(
                  onPressed: () {
                    Get.to(StartBooking());
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(
                      vertical: screenHeight * 0.015,
                    ),
                    elevation: 0,
                    backgroundColor: AppColors.buttonColor2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Add Booking",
                        style: getTextStyle(
                          fontSize:
                              screenWidth *
                              0.04, // Adjust font size according to screen width
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(width: screenWidth * 0.02),
                      Icon(
                        Icons.add,
                        size:
                            screenWidth *
                            0.06, // Adjust icon size based on screen width
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),

                SizedBox(height: screenHeight / 0.040),
              ],
            ),
          ),
        ),
      );
    });
  }
}
