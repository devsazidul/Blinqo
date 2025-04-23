import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:blinqo/core/utils/constants/image_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../service_provider/service_profile_page/controller/service_user_profile_controler.dart';
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
    final controller = Get.put(SpProfileController());
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
              color: AppColors.buttonColor2,
            ),
          ),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Stack(
                children: [
                  // Image.asset(
                  //   themeMode == ThemeMode.dark
                  //       ? GifPath.successdark
                  //       : GifPath.successlight,
                  //   height: height * 0.4,
                  //   fit: BoxFit.cover,
                  // ),
                  Image.asset(ImagePath.congratulations),
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
        ),
      );
    });
  }
}
