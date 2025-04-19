import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:blinqo/core/utils/constants/icon_path.dart';
import 'package:blinqo/core/utils/constants/image_path.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'v_verification_submission_screen.dart';

class VGetVerifiedScreen extends StatelessWidget {
  const VGetVerifiedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF9FAFB),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                SizedBox(height: 48),
                Image.asset(IconPath.verifiedlogo, height: 140),
                SizedBox(height: 48),
                Text(
                  'Build trust with event planners and boost your visibility.',
                  style: getTextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textColor,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 32),

                // Get Verified Button
                GestureDetector(
                  onTap: () {
                   Get.to(
                      VVerificationSubmissionScreen(),
                      transition: Transition.rightToLeft,
                      duration: const Duration(milliseconds: 400),
                    );
                  },
                  child: Container(
                    width: double.infinity,
                    height: 48,
                    decoration: BoxDecoration(
                      color: AppColors.buttonColor2,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: Text(
                        'Get Verified',
                        style: getTextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 16),
                // Skip Button
                GestureDetector(
                  onTap: () {
                    // Navigate to the next screen
                  },
                  child: Container(
                    width: double.infinity,
                    height: 48,
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.buttonColor2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: Text(
                        'Skip',
                        style: getTextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: AppColors.buttonColor2,
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
