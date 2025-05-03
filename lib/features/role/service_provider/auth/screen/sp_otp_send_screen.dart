import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/common/widgets/custom_button.dart';
import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:blinqo/features/role/service_provider/auth/controller/sp_forget_password_controller.dart';
import 'package:blinqo/features/role/service_provider/auth/controller/sp_otp_verification_controller.dart';
import 'package:blinqo/features/role/service_provider/auth/screen/sp_login_screen.dart';
import 'package:blinqo/features/role/service_provider/auth/widgets/v_cistom_pin.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SpOtpSendScreen extends StatelessWidget {
  final SpForgetPasswordController spForgetPasswordController = Get.put(
    SpForgetPasswordController(),
  );
  final String email;
  SpOtpSendScreen({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    final SpOtpVerificationController spOtpVerificationController = Get.put(
      SpOtpVerificationController(),
    );
    String maskedValue = '';
    if (email.contains('@')) {
      // Process email
      maskedValue =
          email.length > 5
              ? '${email.substring(0, 5)}@****.com'
              : '${email.substring(0)}@****.com';
    } else {
      // Process phone
      maskedValue =
          email.length > 5
              ? '${email.substring(0, 5)}****'
              : '${email.substring(0)}****';
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
                  // controller: spForgetPasswordController.pinController,
                  controller: spOtpVerificationController.pinController.value,
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
                        spOtpVerificationController.isValidate.value
                            ? Colors.white
                            : Color(0xFF003366),
                    onPress: () {
                      if (spOtpVerificationController.isValidate.value) {
                        spOtpVerificationController.verifyOtp(email).then((
                          isSuccess,
                        ) {
                          if (isSuccess) {
                            Get.to(SpLoginScreen());
                          }
                        });
                      }
                    },

                    backgroundColor:
                        spOtpVerificationController.isValidate.value
                            ? Color(0xFF003366)
                            // ignore: deprecated_member_use
                            : Color(0xFF003366).withOpacity(0.1),
                    borderColor:
                        spOtpVerificationController.isValidate.value
                            // spForgetPasswordController.isFormValid2.value
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
