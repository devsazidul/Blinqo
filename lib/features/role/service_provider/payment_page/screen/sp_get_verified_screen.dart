import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/common/widgets/custom_continue_button.dart';
import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:blinqo/core/utils/constants/icon_path.dart';
import 'package:blinqo/features/role/service_provider/bottom_nav_bar/screen/sp_bottom_nav_bar.dart';
import 'package:blinqo/features/role/service_provider/common/controller/auth_controller.dart';
import 'package:blinqo/features/role/service_provider/payment_page/screen/sp_payment_option.dart';
import 'package:blinqo/features/role/service_provider/payment_page/screen/sp_verification_submission.dart';
import 'package:blinqo/features/role/service_provider/service_home_page/controller/sp_home_Controller.dart';
import 'package:blinqo/features/role/service_provider/sp_profile/controller/service_user_profile_controler.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SpGetVerifiedScreen extends StatelessWidget {
  SpGetVerifiedScreen({super.key});
  final controller = Get.put(SpProfileController());
  final SpHomeController spPaymentOptionController = Get.put(
    SpHomeController(),
  );
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
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Center(
              child: Column(
                children: [
                  SizedBox(height: 48),
                  Image.asset(IconPath.verifiedlogo, width: 140, height: 140),
                  SizedBox(height: 48),
                  Text(
                    "Build trust with event planners and boost your visibility.",
                    style: getTextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w600,
                      color:
                          themeMode == ThemeMode.dark
                              ? AppColors.primary
                              : AppColors.textColor,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 32),

                  //* -------------------------- Get Verified Button --------------------------
                  CustomContinueButton(
                    onPress: () {
                      if (SpAuthController
                              .spUser
                              ?.profile
                              ?.verificationSubmissionId !=
                          null) {
                        Get.snackbar(
                          "Verification Submission",
                          "Your verification submission is already done. Please add a payment method to get verified.",
                          backgroundColor: Colors.indigo,
                          colorText: Colors.white,
                          duration: Duration(milliseconds: 3000),
                        );
                        Get.to(SpPaymentOption());
                      } else {
                        Get.to(SpVerificationSubmission());
                      }
                    },
                    title: "Get Verified",
                  ),
                  SizedBox(height: 16),

                  //* -------------------------- Skip Button --------------------------
                  GestureDetector(
                    onTap: () {
                      Get.to(SpBottomNavBarScreen());
                    },
                    child: Container(
                      width: double.infinity,
                      height: 50,
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColors.buttonColor2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                        child: Text(
                          "Skip",
                          style: getTextStyle(
                            color:
                                themeMode == ThemeMode.dark
                                    ? AppColors.primary
                                    : AppColors.buttonColor2,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
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
