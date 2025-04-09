import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/common/widgets/customcontinuebutton.dart';
import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:blinqo/core/utils/constants/icon_path.dart';
import 'package:blinqo/features/role/service_provider/payment_page/screen/sp_congratulations_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SpVerificationThanks extends StatelessWidget {
  const SpVerificationThanks({super.key});

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
                Text(
                  "Thank You",
                  style: getTextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textColor,
                  ),
                ),
                SizedBox(height: 20),
                Image.asset(IconPath.verifiedlogo, width: 140, height: 140),
                SizedBox(height: 32),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: Text(
                    "We’ve received your request. Our team will review your details and notify you within 24–48 hours.",
                    style: getTextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: AppColors.textColor,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: 40),
                CustomContinueButton(
                  onTap: () {
                    Get.to(SpCongratulationsPage());
                  },
                  title: "Back to Home",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
