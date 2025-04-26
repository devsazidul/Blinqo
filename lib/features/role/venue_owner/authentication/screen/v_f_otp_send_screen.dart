import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/common/widgets/custom_button.dart';
import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:blinqo/features/role/venue_owner/authentication/controller/v_forget_password_controller.dart';
import 'package:blinqo/features/role/venue_owner/authentication/widgets/v_cistom_pin.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VFOtpSendScreen extends StatelessWidget {
  VFOtpSendScreen({super.key});

  // Use Get.find() to get the existing instance of the controller
  final VForgetPasswordController forgetPasswordController =
      Get.find<VForgetPasswordController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Enter the\n confirmation code',
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
                // Pass the pinController directly to the widget
                CustomPinField(
                  controller: forgetPasswordController.pinController,
                ),
                SizedBox(height: 20),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text:
                            'Verification code has been sent to the email Your ',
                        style: getTextStyle(
                          color: Color(0xFF333333),
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      TextSpan(
                        text: '***abcd@gmai.com'  ,
                        style: getTextStyle(
                          color: Color(0xFF00BA0B),
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
                    // Handle resend code logic here
                  },
                  child: Text(
                    "Resend Code",
                    style: getTextStyle(
                      color: AppColors.textColor,
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
                        forgetPasswordController.isFormValid2.value
                            ? Colors.white
                            : Color(0xFF7EE07E),
                    onPress:
                        forgetPasswordController.isFormValid2.value
                            ? () {
                              // Pass the OTP from the pinController to verifyOtp
                              // forgetPasswordController.vefyOtp();
                            }
                            : null,
                    backgroundColor:
                        forgetPasswordController.isFormValid2.value
                            ? Color(0xFF00BA0B)
                            : Color(0xFFE6F8E7),
                    borderColor:
                        forgetPasswordController.isFormValid2.value
                            ? Color(0xFF00BA0B)
                            : Color(0xFFE6F8E7),
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
