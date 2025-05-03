import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/common/widgets/custom_button.dart';
import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:blinqo/features/role/venue_owner/authentication/controller/signup_verification_otp_controller.dart';
import 'package:blinqo/features/role/venue_owner/authentication/widgets/v_cistom_pin.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VerificationCodeScreen extends StatelessWidget {
  final String email;
  const VerificationCodeScreen({super.key, required this.email});

  // Mask email for display (e.g., ***abcd@gmail.com)
  String maskEmail(String email) {
    final parts = email.split('@');
    if (parts.length != 2) return email;
    final localPart = parts[0];
    final domain = parts[1];
    final maskedLocal = localPart.length > 4
        ? '***${localPart.substring(localPart.length - 4)}'
        : '***$localPart';
    return '$maskedLocal@$domain';
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<VerificationCodeController>(
      init: VerificationCodeController(),
      builder: (controller) {
        return Scaffold(
          backgroundColor: AppColors.backgroundColor,
          body: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Enter the\nconfirmation code',
                      style: getTextStyle(
                        color: const Color(0xFF082B09),
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 32),
                    CustomPinField(
                      controller: controller.codeController,
                    ),
                    const SizedBox(height: 20),
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: 'Verification code has been sent to the email Your ',
                            style: getTextStyle(
                              color: const Color(0xFF333333),
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          TextSpan(
                            text: maskEmail(email),
                            style: getTextStyle(
                              color: const Color(0xFF00BA0B),
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    // GestureDetector(
                    //   onTap: controller.resendCode,
                    //   child: Text(
                    //     'Resend Code',
                    //     style: getTextStyle(
                    //       color: AppColors.textColor,
                    //       fontSize: 14,
                    //       fontWeight: FontWeight.w500,
                    //     ),
                    //   ),
                    // ),
                    const SizedBox(height: 32),
                    Obx(
                          () => CustomButton(
                        title: 'Continue',
                        textColor: controller.isFormValid.value
                            ? Colors.white
                            : const Color(0xFF7EE07E),
                        onPress: (){
                          if(controller.isFormValid.value){
                            controller.verifyCode(email);
                          }
                        },
                        backgroundColor: controller.isFormValid.value
                            ? const Color(0xFF00BA0B)
                            : const Color(0xFFE6F8E7),
                        borderColor: controller.isFormValid.value
                            ? const Color(0xFF00BA0B)
                            : const Color(0xFFE6F8E7),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}