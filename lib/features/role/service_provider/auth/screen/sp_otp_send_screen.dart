import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/common/widgets/custom_button.dart';
import 'package:blinqo/features/role/service_provider/auth/controller/sp_forget_password_controller.dart';
import 'package:blinqo/features/role/venue_owner/authentication/widgets/v_cistom_pin.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: use_key_in_widget_constructors
class SpOtpSendScreen extends StatelessWidget {
  // Initialize the controller here
  final SpForgetPasswordController vForgetPasswordController = Get.put(
    SpForgetPasswordController(),
  );

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
                CustomPinField(
                  controller: vForgetPasswordController.pinController,
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
                          lineHeight: 14,
                        ),
                      ),
                      TextSpan(
                        text: '0724****',
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
                      color: Color(0xFFD4AF37),
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
                        vForgetPasswordController.isFormValid2.value
                            ? Colors.white
                            : Color(0xFF003366),
                    onPress:
                        vForgetPasswordController.isFormValid2.value
                            ? () {
                              // Proceed with form submission
                            }
                            : null,
                    backgroundColor:
                        vForgetPasswordController.isFormValid2.value
                            ? Color(0xFF003366)
                            // ignore: deprecated_member_use
                            : Color(0xFF003366).withOpacity(0.1),
                    borderColor:
                        vForgetPasswordController.isFormValid2.value
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
