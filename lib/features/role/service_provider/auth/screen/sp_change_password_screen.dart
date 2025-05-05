import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/common/widgets/auth_custom_textfield.dart';
import 'package:blinqo/core/common/widgets/custom_button.dart';
import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:blinqo/features/role/service_provider/auth/controller/change_password_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SpChangePasswordScreen extends StatelessWidget {
  const SpChangePasswordScreen({
    super.key,
    required this.email,
    required this.otp,
  });

  final String email;
  final String otp;

  @override
  Widget build(BuildContext context) {
    // Instantiate the ChangedPasswordController using GetX
    final SpChangePasswordController controller = Get.put(
      SpChangePasswordController(),
    );

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
                  controller: controller.newPasswordEditingController,
                  text: 'Enter your Password',
                  onChanged: (value) {
                    controller.newPasswordError.value =
                        ''; // Reset error on change
                  },
                  validator: (value) {
                    if (controller.newPasswordError.value.isNotEmpty) {
                      return controller.newPasswordError.value;
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
                  controller: controller.confirmPasswordEditingController,
                  text: 'Confirm your Password',
                  onChanged: (value) {
                    controller.confirmPasswordError.value =
                        ''; // Reset error on change
                  },
                  validator: (value) {
                    if (controller.confirmPasswordError.value.isNotEmpty) {
                      return controller.confirmPasswordError.value;
                    }
                    return null;
                  },
                ),
                SizedBox(height: 44.0),
                CustomButton(
                  title: 'Change Password',
                  textColor: Colors.white,
                  onPress: () async {
                    await controller.resetPassword(email, otp);
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
