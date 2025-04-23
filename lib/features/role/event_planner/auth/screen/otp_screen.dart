import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/common/widgets/custom_button.dart';
import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:blinqo/features/role/event_planner/auth/controller/forget_password_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

// ignore: use_key_in_widget_constructors
class OTPScreen extends StatelessWidget {
  final ForgetPasswordController forgetPasswordController =
      Get.find<ForgetPasswordController>();

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
                    textColor:
                        forgetPasswordController.isFormValid2.value
                            ? AppColors.primary
                            : AppColors.buttonColor2,
                    onPress:
                        forgetPasswordController.isFormValid2.value
                            ? () {
                              // Get.to(() => ChangePasswordScreen());
                            }
                            : null,
                    backgroundColor:
                        forgetPasswordController.isFormValid2.value
                            ? AppColors.buttonColor2
                            : AppColors.buttonColor2.withValues(alpha: 0.1),
                    borderColor:
                        forgetPasswordController.isFormValid2.value
                            ? AppColors.buttonColor2
                            : AppColors.buttonColor2.withValues(alpha: 0.1),
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
      // animationType: AnimationType.fade,
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
      controller: forgetPasswordController.pinController,
      appContext: context,
    );
  }
}
