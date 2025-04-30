import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/common/widgets/customcontinuebutton.dart';
import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:blinqo/core/utils/constants/icon_path.dart';
import 'package:blinqo/features/role/service_provider/bottom_nav_bar/screen/bottom_nav_bar.dart';
import 'package:blinqo/features/role/service_provider/payment_page/screen/sp_verification_submission.dart';
import 'package:blinqo/features/role/service_provider/service_home_page/controller/sp_home_Controller.dart';
import 'package:blinqo/features/role/service_provider/service_profile_page/controller/service_user_profile_controler.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GetVerifiedScreen extends StatelessWidget {
  GetVerifiedScreen({super.key});
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
                  CustomContinueButton(
                    onTap: () {
                      debugPrint(
                        "Before: ${Get.find<SpHomeController>().isVerified.value}",
                      );

                      spHomeController.isVerified.value = true;

                      spHomeController.isVerified.refresh();

                      debugPrint(
                        "After: ${Get.find<SpHomeController>().isVerified.value}",
                      );

                      // Navigate after a slight delay
                      Future.delayed(Duration(milliseconds: 100), () {
                        Get.to(SpVerificationSubmission());
                      });
                    },
                    title: "Get Verified",
                  ),
                  // CustomContinueButton(
                  //   onTap: () {
                  //     Get.find<SpHomeController>().isVerified.value = true;
                  //     Future.delayed(Duration(milliseconds: 100), () {
                  //       Get.to(SpVerificationSubmission());
                  //     });
                  //   },
                  //   title: "Get Verified",
                  // ),
                  SizedBox(height: 16),
                  GestureDetector(
                    onTap: () {
                      Get.to(BottomNavBar());
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
