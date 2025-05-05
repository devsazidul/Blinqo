import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/common/widgets/custom_button.dart';
import 'package:blinqo/features/role/service_provider/auth/controller/sp_otp_verify_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class SpForgetPasswordVerifyOtpScreen extends StatelessWidget {
  const SpForgetPasswordVerifyOtpScreen({super.key, required this.email});

  final String email;

  String _maskEmail(String email) {
    if (email.isEmpty || !email.contains('@')) return email;

    final parts = email.split('@');
    if (parts.length != 2) return email;

    final username = parts[0];
    final domain = parts[1];

    if (username.length <= 3) {
      return '${'*' * username.length}@$domain';
    }

    final visiblePart = username.substring(0, 3);
    final maskedPart = '*' * (username.length - 3);

    return '$visiblePart$maskedPart@$domain';
  }

  @override
  Widget build(BuildContext context) {
    final SpOtpVerifyController otpVerifyController = Get.put(
      SpOtpVerifyController(),
    );
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
                SizedBox(height: 20),
                PinCodeTextField(
                  autoDisposeControllers: false,
                  controller: otpVerifyController.pinController,
                  appContext: context,
                  length: 6,
                  onChanged: (value) {
                    otpVerifyController.pinController.text = value;
                    otpVerifyController.validateForm();
                  },
                  pinTheme: PinTheme(
                    fieldHeight: 50,
                    fieldWidth: 50,
                    selectedBorderWidth: 1,
                    selectedColor: Color(0xFF003366),
                    activeColor: Color(0xFFA7A7A7),
                    inactiveColor: Color(0xFFE5E6EB),
                    activeBorderWidth: 1,
                    inactiveBorderWidth: 1,
                    shape: PinCodeFieldShape.box,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),

                SizedBox(height: 20),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: 'Verification code has been sent \nto the email ',
                        style: getTextStyle(
                          color: Color(0xFF333333),
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      TextSpan(
                        text: _maskEmail(email),
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
                SizedBox(height: 32),
                Obx(
                  () => CustomButton(
                    title: 'Continue',
                    textColor:
                        otpVerifyController.isFormValid.value
                            ? Colors.white
                            : Color(0xFF003366),
                    onPress: () {
                      otpVerifyController.forgetPasswordVerifyOtp(email: email);
                    },
                    backgroundColor:
                        otpVerifyController.isFormValid.value
                            ? Color(0xFF003366)
                            : Color(0xFFE0E6EC),
                    borderColor:
                        otpVerifyController.isFormValid.value
                            ? Color(0xFF003366)
                            : Color(0xFFE0E6EC),
                  ),
                ),
                // Show timer and resend button
                SizedBox(height: 20),
                Obx(
                  () =>
                      otpVerifyController.canResend
                          ? GestureDetector(
                            onTap: () {
                              otpVerifyController.resendOtp(email: email);
                            },
                            child: Text(
                              "Resend Code",
                              style: getTextStyle(
                                color: Color(0xFF0047AB),
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          )
                          : Text(
                            'You can resend code after ${otpVerifyController.resendTimer.value} seconds',
                            style: getTextStyle(
                              color: Color(0xFF666666),
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
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
