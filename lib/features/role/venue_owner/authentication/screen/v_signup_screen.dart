import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/common/widgets/auth_custom_textfield.dart';
import 'package:blinqo/core/common/widgets/custom_button.dart';
import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:blinqo/features/role/service_provider/auth/screen/sp_login_screen.dart';
import 'package:blinqo/features/role/venue_owner/authentication/controller/v_signup_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VSignupScreen extends StatelessWidget {
  const VSignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize the controller
    final controller = Get.put(VSignupController());

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        forceMaterialTransparency: true,
        title: Text(
          'Sign Up',
          style: getTextStyle(
            color: const Color(0xFF082B09),
            fontSize: 24,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Form(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                Text(
                  'Name',
                  style: getTextStyle(
                    color: const Color(0xFF333333),
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 8),
                AuthCustomTextField(
                  text: 'Enter your Name',
                  onChanged: (value) => controller.validateForm(),
                  controller: controller.nameController,
                  validator: controller.validateName,
                ),
                const SizedBox(height: 16),
                Text(
                  'Phone Number',
                  style: getTextStyle(
                    color: const Color(0xFF333333),
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 8),
                AuthCustomTextField(
                  controller: controller.phoneController1,
                  text: 'Enter your Phone Number',
                  onChanged: (value) => controller.validateForm(),
                  validator: controller.validatePhone,
                ),
                const SizedBox(height: 16),
                Text(
                  'Email',
                  style: getTextStyle(
                    color: const Color(0xFF333333),
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 8),
                AuthCustomTextField(
                  controller: controller.emailController1,
                  text: 'Enter your Email',
                  onChanged: (value) => controller.validateForm(),
                  validator: controller.validateEmail,
                ),
                const SizedBox(height: 16),
                Text(
                  'Password',
                  style: getTextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xFF333333),
                  ),
                ),
                const SizedBox(height: 8),
                AuthCustomTextField(
                  text: 'Enter your Password',
                  onChanged: (value) => controller.validateForm(),
                  controller: controller.passwordController,
                  obscureText: controller.isPasswordVisible.value,
                  suffixIcon: IconButton(
                    icon: Icon(
                      controller.isPasswordVisible.value
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                      color: const Color(0xFF003366),
                    ),
                    onPressed: controller.togglePasswordVisibility,
                  ),
                  validator: controller.validatePassword,
                ),
                const SizedBox(height: 16),
                Text(
                  'Retype Password',
                  style: getTextStyle(
                    color: const Color(0xFF333333),
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 8),
                AuthCustomTextField(
                  controller: controller.retypepasswordController,
                  text: 'Enter your Password',
                  onChanged: (value) => controller.validateForm(),
                  obscureText: controller.isPasswordVisible1.value,
                  suffixIcon: IconButton(
                    icon: Icon(
                      controller.isPasswordVisible1.value
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                      color: const Color(0xFF003366),
                    ),
                    onPressed: controller.togglePasswordVisibility1,
                  ),
                  validator: controller.validateRetypePassword,
                ),
                const SizedBox(height: 32),
                Obx(() {
                  return CustomButton(
                    title: 'Sign Up',
                    textColor: controller.isFormValid.value
                        ? Colors.white
                        : const Color(0xFF003366),
                    onPress: () {
                      if (controller.isFormValid.value) {
                        controller.signup();
                      } else {
                        controller.validateForm(); // Ensure error message is updated
                      }
                    },
                    backgroundColor: controller.isFormValid.value
                        ? const Color(0xFF003366)
                        : const Color(0xFF003366).withValues( alpha: 0.1),
                    borderColor: controller.isFormValid.value
                        ? const Color(0xFF003366)
                        : const Color(0xFF003366).withValues( alpha: 0.1),
                  );
                }),
                const SizedBox(height: 28),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an account?",
                      style: getTextStyle(
                        color: const Color(0xFF333333),
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(width: 8),
                    GestureDetector(
                      onTap: () => Get.to(() => SpLoginScreen()),
                      child: Text(
                        "Sign In",
                        style: getTextStyle(
                          color: const Color(0xFF003366),
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
