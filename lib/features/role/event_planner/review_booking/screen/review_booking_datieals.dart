import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:blinqo/features/role/event_planner/common/widgets/ep_bottom_nav_bar_widget.dart';
import 'package:blinqo/features/role/event_planner/invitation/screens/invitation_card_screen.dart';
import 'package:blinqo/features/role/event_planner/profile/controller/pick_color_controller.dart';
import 'package:blinqo/features/role/event_planner/profile/controller/profile_controller.dart';
import 'package:blinqo/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:step_indicator_package/step_indicator.dart';

import '../../../../../core/common/styles/global_text_style.dart';
import '../../event_home_page/sharch_start_booking/widget/revies_card.dart';
import '../../event_home_page/sharch_start_booking/widget/shearch_start_booking_page.dart';
import '../widget/ever_review_booking_details_section.dart';
import '../widget/reviews_text.dart';

class ReviewBookingDetails extends StatelessWidget {
  const ReviewBookingDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final stepController = StepIndicatorController(maxSteps: 3);
    final PickColorController pickColorController = Get.find();
    Future.delayed(Duration(milliseconds: 300), () {
      stepController.setStep(2);
    });
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
              ShearchStartBookingPage(),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: screenHeight * 0.02),
                    ReviesCard(themeMode: themeMode),

                    SizedBox(height: screenHeight * 0.02),
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        'Booking Timeline',
                        style: getTextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color:
                              themeMode == ThemeMode.dark
                                  ? Color(0xffD4AF37)
                                  : pickColorController.isFemale.value
                                  ? pickColorController.selectedColor
                                  : Color(0xff003285),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    StepIndicator(
                      controller: stepController,
                      activeColor:
                          themeMode == ThemeMode.dark
                              ? Color(0xffD4AF37)
                              : pickColorController.isFemale.value
                              ? pickColorController.selectedColor
                              : Color(0xff003285),
                      activeLineColor:
                          themeMode == ThemeMode.dark
                              ? Color(0xffD4AF37)
                              : pickColorController.isFemale.value
                              ? pickColorController.selectedColor
                              : Color(0xff003285),
                      circleRadius: 18,
                      paddingHorizontal: 60,
                      showNavigationButtons: false,
                    ),
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
                              'Price Details',
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
                              isColorChinge: false,
                              label: 'Total Cost',
                              value: '\$8000',
                              themeMode: themeMode,
                            ),
                            SizedBox(height: screenHeight * 0.02),
                            ReviewsText(
                              isColorChinge: false,

                              label: 'Payable Amount',
                              value: '\$800(10%)',
                              themeMode: themeMode,
                            ),
                            SizedBox(height: screenHeight * 0.02),
                            ReviewsText(
                              isColorChinge: false,
                              label: 'Due',
                              value: '\$7200',
                              themeMode: themeMode,
                            ),
                            SizedBox(height: screenHeight * 0.02),
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
                            AppRoute.geteventPaymentOption(),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(vertical: 14),
                          elevation: 0,
                          backgroundColor:
                              themeMode == ThemeMode.dark ||
                                      !pickColorController.isFemale.value
                                  ? AppColors.buttonColor2
                                  : pickColorController
                                      .selectedColor, // Your custom color
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              12.r,
                            ), // Adjust the radius as needed
                          ),
                        ),
                        child: Text(
                          "Proceed to payment",
                          style: getTextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500,
                            color: AppColors.primary,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.01),
                    SizedBox(
                      width: double.infinity,

                      child: ElevatedButton(
                        onPressed: () {
                          Get.to(InvitationCardScreen());
                        },
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(vertical: 14),
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
                                      : pickColorController.isFemale.value
                                      ? pickColorController.selectedColor
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
                                    : pickColorController.isFemale.value
                                    ? pickColorController.selectedColor
                                    : AppColors.buttonColor2,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.15),
                  ],
                ),
              ),
            ],
          ),
        ),

        bottomNavigationBar: EpBottomNavBarWidget(),
      );
    });
  }
}
