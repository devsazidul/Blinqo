import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/common/widgets/customcontinuebutton.dart';
import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:blinqo/core/utils/constants/icon_path.dart';
import 'package:blinqo/features/role/service_provider/payment_page/screen/sp_verification_submission.dart';
import 'package:blinqo/features/role/service_provider/payment_page/screen/sp_verification_thanks.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GetVerifiedScreen extends StatelessWidget {
  const GetVerifiedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
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
                    color: AppColors.textColor,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 32),
                CustomContinueButton(
                  onTap: () {
                    Get.to(SpVerificationSubmission());
                  },
                  title: "Get Verified",
                ),
                SizedBox(height: 16),
                GestureDetector(
                  onTap: () {
                    Get.to(SpVerificationThanks());
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
                          color: AppColors.buttonColor2,
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
  }
}
