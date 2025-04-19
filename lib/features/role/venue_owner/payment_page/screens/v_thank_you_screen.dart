import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:blinqo/core/utils/constants/icon_path.dart';
import 'package:blinqo/core/utils/constants/image_path.dart';
import 'package:blinqo/features/role/venue_owner/payment_page/widgets/v_payment_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'v_verification_submission_screen.dart';

class VThankYouScreen extends StatelessWidget {
  const VThankYouScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF9FAFB),
      appBar: VPaymentAppBar(isBackButtonVisible: false, title: 'Thank You'),
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
                  'We’ve received your request. Our team will review your details and notify you within 24–48 hours.',
                  style: getTextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textColor,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 32),

                // Get Verified Button
                GestureDetector(
                  onTap: () {
                    // Get.to(
                    //   transition: Transition.rightToLeft,
                    //   duration: const Duration(milliseconds: 400),
                    // );
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
                        'Back to Home',
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
