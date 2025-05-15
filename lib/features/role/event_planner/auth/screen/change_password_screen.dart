import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/common/widgets/auth_custom_textfield.dart';
import 'package:blinqo/core/common/widgets/custom_button.dart';
import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:blinqo/features/profile/controller/pick_color_controller.dart';
import 'package:blinqo/features/role/event_planner/auth/controller/change_password_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChangePasswordScreen extends StatelessWidget {
  final String? email;
  final String? otp;

  const ChangePasswordScreen({super.key, this.email, this.otp});

  @override
  Widget build(BuildContext context) {
    final femaleColorController = Get.find<PickColorController>();
    final bool isFemale = femaleColorController.isFemale.value;

    final ChangePasswordController changePasswordController = Get.put(
      ChangePasswordController(),
    );

    // Set email and OTP in the controller
    changePasswordController.setEmailAndOtp(email, otp);

    debugPrint("email: $email, otp: $otp");

    return Scaffold(
      backgroundColor: AppColors.loginBg,
      appBar: AppBar(
        centerTitle: true,
        forceMaterialTransparency: true,
        title: Text(
          'Change Password',
          style: getTextStyle(
            color: AppColors.textColor,
            fontSize: 24,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
          child: Form(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                Text(
                  'New Password',
                  style: getTextStyle(
                    color: AppColors.textColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 8),
                AuthCustomTextField(
                  controller:
                      changePasswordController.newPasswordEditingController,
                  text: 'Enter your Password',
                  obscureText: true,
                  onChanged: (value) {
                    changePasswordController.validatePasswords();
                  },
                  validator:
                      (value) =>
                          changePasswordController
                                  .newPasswordError
                                  .value
                                  .isNotEmpty
                              ? changePasswordController.newPasswordError.value
                              : null,
                ),
                const SizedBox(height: 20),
                Text(
                  'Confirm Password',
                  style: getTextStyle(
                    color: AppColors.textColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 8),
                AuthCustomTextField(
                  controller:
                      changePasswordController.confirmPasswordEditingController,
                  text: 'Enter your Password',
                  obscureText: true,
                  onChanged: (value) {
                    changePasswordController.validatePasswords();
                  },
                  validator:
                      (value) =>
                          changePasswordController
                                  .confirmPasswordError
                                  .value
                                  .isNotEmpty
                              ? changePasswordController
                                  .confirmPasswordError
                                  .value
                              : null,
                ),
                const SizedBox(height: 68),
                CustomButton(
                  title: 'Change',
                  backgroundColor:
                      isFemale
                          ? femaleColorController.selectedColor
                          : AppColors.buttonColor2,
                  borderColor:
                      isFemale
                          ? femaleColorController.selectedColor
                          : AppColors.buttonColor2,
                  textColor: AppColors.primary,
                  onPress: () {
                    if (changePasswordController.validatePasswords()) {
                      changePasswordController.resetPassword();
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
