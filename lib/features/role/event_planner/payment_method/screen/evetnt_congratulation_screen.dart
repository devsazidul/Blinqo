import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:blinqo/core/utils/constants/gif_path.dart';
import 'package:blinqo/features/profile/controller/profile_controller.dart';
import 'package:blinqo/features/profile/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'final_review_booking_datieals.dart';
// final themeMode =
//     controller.isDarkMode.value ? ThemeMode.dark : ThemeMode.light;

class EventCongratulationScreen extends StatelessWidget {
  const EventCongratulationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;
    final controller = Get.put(ProfileController());
    return Obx(() {
      final themeMode =
          controller.isDarkMode.value ? ThemeMode.dark : ThemeMode.light;
      return Scaffold(
        backgroundColor:
            themeMode == ThemeMode.dark ? Color(0xff000000) : Color(0xffFFFFFF),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(
            "Congratulations",
            style: getTextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 20.sp,
              color: ThemeStyle.text2(themeMode == ThemeMode.dark),
            ),
          ),
          centerTitle: true,
        ),
        body: Column(
          children: [
            Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Image.asset(
                    themeMode == ThemeMode.dark
                        ? GifPath.epSuccessDark
                        : GifPath.epSuccessLight,
                    width: MediaQuery.of(context).size.width,
                    height: 325,
                    fit: BoxFit.cover,
                  ),
                ),
                Container(
                  width: width,
                  height: height * 0.4,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        themeMode == ThemeMode.dark
                            ? AppColors.blackColor
                            : AppColors.primary.withValues(alpha: 0.1),
                        themeMode == ThemeMode.dark
                            ? AppColors.blackColor
                            : AppColors.primary.withValues(alpha: 0.1),
                        themeMode == ThemeMode.dark
                            ? AppColors.blackColor
                            : AppColors.primary.withValues(alpha: 0.1),
                        themeMode == ThemeMode.dark
                            ? AppColors.blackColor
                            : AppColors.primary.withValues(alpha: 0.1),
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: 20),
            Text(
              'You have completed\n\t\t\t\t\t\t your booking',
              style: getTextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color:
                    themeMode == ThemeMode.dark
                        ? AppColors.borderColor2
                        : AppColors.textColor,
              ),
            ),
            SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                Get.to(FinalReviewBookingDatieals());
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xff003366), // Background color
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12), // Border radius
                ),
                padding: EdgeInsets.symmetric(
                  vertical: 14.5,
                  horizontal: 100,
                ), // Optional: Adjust padding
              ),
              child: Text(
                "Booking Details",
                style: TextStyle(fontSize: 16, color: AppColors.primary),
              ),
            ),
          ],
        ),
      );
    });
  }
}
