import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/common/widgets/auth_custom_textfield.dart';
import 'package:blinqo/core/common/widgets/custom_button.dart';
import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:blinqo/features/role/event_planner/auth/controller/change_password_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChangePasswordScreen extends StatelessWidget {
  final String? email;
  const ChangePasswordScreen({super.key, this.email});

  @override
  Widget build(BuildContext context) {
    final ChangePasswordController changePasswordController =
        Get.find<ChangePasswordController>();

    debugPrint("email: $email");

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        centerTitle: true,
        forceMaterialTransparency: true,
        title: Text(
          'Changed Password',
          style: getTextStyle(
            color: Color(0xFF082B09),
            fontSize: 24,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
          child: Form(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 18.0),
                Text(
                  'Enter Verification Code:',
                  style: getTextStyle(
                    color: Color(0xFF082B09),
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(height: 32),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'New Password',
                      style: getTextStyle(
                        color: Color(0xFF333333),
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                AuthCustomTextField(
                  controller:
                      changePasswordController.newPasswordEditingController,
                  text: 'Enter your Password',
                  onChanged: (value) {
                    changePasswordController.newPasswordError.value =
                        ''; // Reset error on change
                  },
                  validator: (value) {
                    if (changePasswordController
                        .newPasswordError
                        .value
                        .isNotEmpty) {
                      return changePasswordController.newPasswordError.value;
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Confirm Password',
                      style: getTextStyle(
                        color: Color(0xFF333333),
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                AuthCustomTextField(
                  controller:
                      changePasswordController.confirmPasswordEditingController,
                  text: 'Confirm your Password',
                  onChanged: (value) {
                    changePasswordController.confirmPasswordError.value =
                        ''; // Reset error on change
                  },
                  validator: (value) {
                    if (changePasswordController
                        .confirmPasswordError
                        .value
                        .isNotEmpty) {
                      return changePasswordController
                          .confirmPasswordError
                          .value;
                    }
                    return null;
                  },
                ),
                SizedBox(height: 44.0),
                CustomButton(
                  title: 'Change Password',
                  textcolor: Colors.white,
                  onPress: () {
                    // controller.changePassword(email);
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
