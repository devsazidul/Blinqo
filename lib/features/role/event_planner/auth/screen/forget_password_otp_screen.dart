import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/common/widgets/custom_button.dart';
import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:blinqo/features/role/event_planner/auth/controller/forget_password_otp_controller.dart';
import 'package:blinqo/features/role/event_planner/profile/controller/pick_color_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class FPOTPScreen extends StatelessWidget {
  final FPOTPController fpotpController = Get.put(FPOTPController());

  FPOTPScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final String email = Get.arguments ?? '';
    final femaleColorController = Get.find<PickColorController>();
    final bool isFemale = femaleColorController.isFemale.value;

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
                      'Your $email',
                      style: getTextStyle(
                        color:
                            isFemale
                                ? femaleColorController.selectedColor
                                : AppColors.buttonColor2,
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Obx(
                  () => GestureDetector(
                    onTap:
                        fpotpController.resendEnabled.value
                            ? () {
                              fpotpController.resendCode(email);
                            }
                            : null,
                    child: Text(
                      fpotpController.resendEnabled.value
                          ? "Resend Code"
                          : "Resend Code in ${fpotpController.countdown.value}s",
                      style: getTextStyle(
                        color: AppColors.textColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 40),
                Obx(
                  () => CustomButton(
                    title: 'Continue',
                    textColor:
                        fpotpController.isFormValid.value && isFemale
                            ? AppColors.primary
                            : fpotpController.isFormValid.value && !isFemale
                            ? AppColors.primary
                            : !fpotpController.isFormValid.value && isFemale
                            ? Color(0xFFEBA8B5)
                            : AppColors.buttonColor2,
                    onPress:
                        fpotpController.isFormValid.value
                            ? () {
                              fpotpController.validatePin(email);
                            }
                            : null,
                    backgroundColor:
                        fpotpController.isFormValid.value && isFemale
                            ? femaleColorController.selectedColor
                            : fpotpController.isFormValid.value && !isFemale
                            ? AppColors.buttonColor2
                            : !fpotpController.isFormValid.value && isFemale
                            ? femaleColorController.selectedColor.withValues(
                              alpha: 0.1,
                            )
                            : AppColors.buttonColor2.withValues(alpha: 0.1),
                    borderColor:
                        isFemale
                            ? Colors.transparent
                            : fpotpController.isFormValid.value
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
      controller: fpotpController.pinController,
      appContext: context,
      onChanged: (value) {
        fpotpController.validateForm();
      },
    );
  }
}
