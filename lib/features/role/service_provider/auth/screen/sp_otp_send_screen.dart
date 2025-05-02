import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/common/widgets/custom_button.dart';
import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:blinqo/features/role/service_provider/auth/controller/sp_forget_password_controller.dart';
import 'package:blinqo/features/role/service_provider/auth/screen/sp_change_password.dart';
import 'package:blinqo/features/role/service_provider/auth/widgets/v_cistom_pin.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SpOtpSendScreen extends StatelessWidget {
  final SpForgetPasswordController spForgetPasswordController = Get.put(
    SpForgetPasswordController(),
  );
  final String valueToSend;
  SpOtpSendScreen({super.key, required this.valueToSend});

  @override
  Widget build(BuildContext context) {
    String maskedValue = '';
    if (valueToSend.contains('@')) {
      // Process email
      maskedValue =
          valueToSend.length > 5
              ? '${valueToSend.substring(0, 5)}@****.com'
              : '${valueToSend.substring(0)}@****.com';
    } else {
      // Process phone
      maskedValue =
          valueToSend.length > 5
              ? '${valueToSend.substring(0, 5)}****'
              : '${valueToSend.substring(0)}****';
    }
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Enter the confirmation \n code',
                  style: getTextStyle(
                    color: Color(0xFF082B09),
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 32),
                SpCustomPinField(
                  controller: spForgetPasswordController.pinController,
                ),
                SizedBox(height: 20),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text:
                            'Verification code has been sent to the phone number Your ',
                        style: getTextStyle(
                          color: Color(0xFF333333),
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          lineHeight: 1.5,
                        ),
                      ),
                      TextSpan(
                        text: maskedValue,
                        // text: '0724****',
                        style: getTextStyle(
                          color: Color(0xFF003366),
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    // Code to resend OTP
                  },
                  child: Text(
                    "Resend Code",
                    style: getTextStyle(
                      color: AppColors.buttonColor2,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                SizedBox(height: 32),
                Obx(
                  () => CustomButton(
                    title: 'Continue',
                    textColor:
                        spForgetPasswordController.isFormValid2.value
                            ? Colors.white
                            : Color(0xFF003366),
                    onPress:
                        spForgetPasswordController.isFormValid2.value
                            ? () {
                              Get.to(SpChangePassword());
                            }
                            : null,
                    backgroundColor:
                        spForgetPasswordController.isFormValid2.value
                            ? Color(0xFF003366)
                            // ignore: deprecated_member_use
                            : Color(0xFF003366).withOpacity(0.1),
                    borderColor:
                        spForgetPasswordController.isFormValid2.value
                            ? Color(0xFF003366)
                            // ignore: deprecated_member_use
                            : Color(0xFF003366).withOpacity(0.1),
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
