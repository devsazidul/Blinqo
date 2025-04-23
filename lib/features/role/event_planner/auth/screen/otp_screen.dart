import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/common/widgets/custom_button.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../controller/otp_controller.dart';

class OTPScreen extends StatelessWidget {
  // Get the OTP controller instance using Get.find()
  final OTPController otpController = Get.put(OTPController());

  OTPScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.loginBg,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
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
                _buildPinCodeTextField(context),
                SizedBox(height: 20),
                Text(
                  'Verification code has been sent to the email',
                  style: getTextStyle(
                    color: AppColors.textColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      ' Your ',
                      style: getTextStyle(
                        color: AppColors.textColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Text(
                      '****abc@gmal.com',
                      style: getTextStyle(
                        color: AppColors.buttonColor2,
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                GestureDetector(
                  onTap: () {},
                  child: Text(
                    "Resend Code",
                    style: getTextStyle(
                      color: AppColors.textColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                SizedBox(height: 40),
                Obx(
                  () => CustomButton(
                    // onPress: () => Get.to(() => ChangePasswordScreen()),
                    title: 'Continue',
                    textcolor:
                        otpController.isFormValid.value
                            ? AppColors.primary
                            : AppColors.buttonColor2,
                    onPress:
                        otpController.isFormValid.value
                            ? () {
                              // Navigate to the next screen if the OTP is valid
                              // Get.to(() => ChangePasswordScreen());
                            }
                            : null,
                    backgroundColor:
                        otpController.isFormValid.value
                            ? AppColors.buttonColor2
                            : AppColors.buttonColor2.withOpacity(0.1),
                    borderColor:
                        otpController.isFormValid.value
                            ? AppColors.buttonColor2
                            : AppColors.buttonColor2.withOpacity(0.1),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPinCodeTextField(BuildContext context) {
    return PinCodeTextField(
      length: 6,
      obscureText: false,
      keyboardType: TextInputType.number,
      pinTheme: PinTheme(
        shape: PinCodeFieldShape.box,
        borderRadius: BorderRadius.circular(8),
        fieldHeight: 40,
        fieldWidth: 40,
        activeFillColor: AppColors.otpbg,
        selectedFillColor: AppColors.otpbg,
        inactiveFillColor: AppColors.otpbg,
        inactiveColor: AppColors.otpbg,
        selectedColor: AppColors.otpbg,
        activeColor: AppColors.otpbg,
      ),
      animationDuration: const Duration(milliseconds: 300),
      backgroundColor: Colors.transparent,
      controller: otpController.pinController,
      appContext: context,
      onChanged: (value) {
        // Call validate form on OTP field change
        otpController.validateForm();
      },
    );
  }
}
