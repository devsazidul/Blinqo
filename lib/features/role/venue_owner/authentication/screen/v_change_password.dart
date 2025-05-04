import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/common/widgets/auth_custom_textfield.dart';
import 'package:blinqo/core/common/widgets/custom_button.dart';
import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:blinqo/features/role/venue_owner/authentication/controller/v_change_password_controller.dart';
import 'package:blinqo/features/role/venue_owner/authentication/controller/v_forget_password_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VChangePassword extends StatelessWidget {
  final String? email;

  const VChangePassword({super.key, this.email});

  @override
  Widget build(BuildContext context) {
    // Instantiate the ChangedPasswordController using GetX
    final ChangedPasswordController controller = Get.put(
      ChangedPasswordController(),
    );
    final VForgetPasswordController vForgetPasswordController = Get.find();

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
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Password cannot be empty';
                    }
                    if (value.length < 8) {
                      return 'Password should be at least 8 characters';
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
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Confirm Password cannot be empty';
                    }
                    if (value.length < 8) {
                      return 'Password should be at least 8 characters';
                    }
                    if (controller.newPasswordEditingController.text !=
                        controller.confirmPasswordEditingController.text) {
                      return 'Passwords have to match';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 44.0),
                CustomButton(
                  title: 'Change Password',
                  textColor: Colors.white,
                  onPress: () {
                    controller.changePassword(
                      vForgetPasswordController.emailController.text,
                    );
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
