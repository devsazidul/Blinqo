import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/features/profile/controller/profile_controller.dart';
import 'package:blinqo/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../../core/utils/constants/colors.dart';
import '../../event_home_page/sharch_start_booking/widget/revies_card.dart';
import '../../event_home_page/sharch_start_booking/widget/shearch_start_booking_page.dart';
import '../widget/ever_review_booking_details_section.dart';
import '../widget/reviews_text.dart';

class ReviewBooking extends StatelessWidget {
  const ReviewBooking({super.key});

  @override
  Widget build(BuildContext context) {
    // Get screen width and height for responsive design
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    final controller = Get.find<ProfileController>();
    return Obx(() {
      final themeMode =
          controller.isDarkMode.value ? ThemeMode.dark : ThemeMode.light;

      return Scaffold(
        backgroundColor:
            themeMode == ThemeMode.dark
                ? AppColors.darkBackgroundColor
                : AppColors.buttonBuckdownColor2,

        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: screenHeight * 0.02),
              ShearchStartBookingPage(),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: screenHeight * 0.02),
                    ReviesCard(themeMode: themeMode),

                    SizedBox(height: screenHeight * 0.02),

                    Center(
                      child: Text(
                        "Jhon's Birthday",
                        style: getTextStyle(
                          fontSize: 24.sp,
                          fontWeight: FontWeight.w600,
                          color:
                              themeMode == ThemeMode.dark
                                  ? Color(0xffD4AF37)
                                  : Color(0xff003285),
                        ),
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    EverReviewBookingDetailsSection(
                      themeMode: themeMode,
                      screenHeight: screenHeight,
                    ),
                    SizedBox(height: screenHeight * 0.03),

                    Container(
                      decoration: BoxDecoration(
                        color:
                            themeMode == ThemeMode.dark
                                ? Color(0xff32383D)
                                : AppColors.primary,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Decoration',
                              style: getTextStylePoppins(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color:
                                    themeMode == ThemeMode.dark
                                        ? AppColors.buttonColor
                                        : AppColors.buttonColor2,
                              ),
                            ),
                            SizedBox(height: screenHeight * 0.02),
                            ReviewsText(
                              isColorChinge: true,
                              label: 'Table Shape',
                              value: 'Round',
                              themeMode: themeMode,
                            ),
                            SizedBox(height: screenHeight * 0.02),
                            ReviewsText(
                              isColorChinge: true,

                              label: 'Flower Color',
                              value: 'Red',
                              themeMode: themeMode,
                            ),
                            SizedBox(height: screenHeight * 0.02),
                            ReviewsText(
                              isColorChinge: true,
                              label: 'Seating Style',
                              value: 'Banquet',
                              themeMode: themeMode,
                            ),
                            SizedBox(height: screenHeight * 0.02),
                            ReviewsText(
                              isColorChinge: true,

                              label: 'Fragrance',
                              value: 'Sweet',
                              themeMode: themeMode,
                            ),
                            SizedBox(height: screenHeight * 0.02),
                            ReviewsText(
                              isColorChinge: true,
                              label: 'Lighting Styles',
                              value: 'Warm Yellow',
                              themeMode: themeMode,
                            ),
                            SizedBox(height: screenHeight * 0.02),
                            ReviewsText(
                              isColorChinge: true,

                              label: 'Tablecloth Colors',
                              value: 'White',
                              themeMode: themeMode,
                            ),
                            SizedBox(height: screenHeight * 0.02),
                            ReviewsText(
                              isColorChinge: true,

                              label: 'Stage Decor',
                              value: 'LED Backdrops',
                              themeMode: themeMode,
                            ),
                          ],
                        ),
                      ),
                    ),

                    SizedBox(height: screenHeight * 0.02),

                    SizedBox(
                      width: double.infinity,

                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(
                            context,
                            AppRoute.getReviewBookingDetails(),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          backgroundColor:
                              themeMode == ThemeMode.dark
                                  ? Color(0xff003366)
                                  : Color(0xffE6EBF0), // Your custom color
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              12.r,
                            ), // Adjust the radius as needed
                          ),
                        ),
                        child: Text(
                          "proceed to payment",
                          style: getTextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500,
                            color:
                                themeMode == ThemeMode.dark
                                    ? Color(0xffffffff)
                                    : Color(0xff8AA1B9),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.01),
                    SizedBox(
                      width: double.infinity,

                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          backgroundColor:
                              themeMode == ThemeMode.dark
                                  ? AppColors.darkBackgroundColor
                                  : AppColors
                                      .backgroundColor, // Your custom color
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                              color:
                                  themeMode == ThemeMode.dark
                                      ? AppColors.darkBackgroundColor
                                      : AppColors.buttonColor2,
                            ),
                            borderRadius: BorderRadius.circular(
                              12.r,
                            ), // Adjust the radius as needed
                          ),
                        ),
                        child: Text(
                          "Invite Guest",
                          style: getTextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500,
                            color:
                                themeMode == ThemeMode.dark
                                    ? AppColors.primary
                                    : AppColors.buttonColor2,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.1),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
