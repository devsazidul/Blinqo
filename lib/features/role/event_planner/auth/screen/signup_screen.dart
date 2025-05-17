import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/common/widgets/auth_custom_textfield.dart';
import 'package:blinqo/core/common/widgets/custom_button.dart';
import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:blinqo/features/role/event_planner/auth/controller/signup_controller.dart';
import 'package:blinqo/features/role/event_planner/auth/screen/login_screen.dart';
import 'package:blinqo/features/role/event_planner/event_checkout_page/screens/even_profile_setup_screen.dart';
import 'package:blinqo/features/role/event_planner/profile/controller/pick_color_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final SignUpController signupController = Get.find<SignUpController>();
    final PickColorController colorController = Get.find<PickColorController>();

    final bool isFemale = colorController.isFemale.value;
    final Color selectedColor = colorController.selectedColor;

    return Scaffold(
      backgroundColor: AppColors.loginBg,
      appBar: AppBar(
        centerTitle: true,
        forceMaterialTransparency: true,
        title: Text(
          'Sign Up',
          style: getTextStyle(
            color: AppColors.textColor,
            fontSize: 24,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            // Name Field
            Text(
              'Name',
              style: getTextStyle(
                color: AppColors.textColor,
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(height: 8),
            AuthCustomTextField(
              text: 'Enter your Name',
              onChanged: (_) => signupController.validateForm(),
              controller: signupController.nameController,
              validator:
                  (value) => value?.isEmpty ?? true ? 'Enter Your Name' : null,
            ),
            const SizedBox(height: 20),
            // Phone Field
            Text(
              'Phone Number',
              style: getTextStyle(
                color: AppColors.textColor,
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(height: 8),
            AuthCustomTextField(
              controller: signupController.phoneController1,
              text: 'Enter your Phone Number',
              onChanged: (_) => signupController.validateForm(),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Enter Phone Number e.g:+8801234567891';
                }
                if (!RegExp(r'^\+8801[3-9][0-9]{8}$').hasMatch(value)) {
                  return 'Invalid phone number format. Use +8801XXXXXXXXX';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            // Email Field
            Text(
              'Email',
              style: getTextStyle(
                color: AppColors.textColor,
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(height: 8),
            AuthCustomTextField(
              controller: signupController.emailController1,
              text: 'Enter your Email',
              onChanged: (_) => signupController.validateForm(),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Enter a valid email address';
                }
                if (!RegExp(
                  r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
                ).hasMatch(value)) {
                  return 'Invalid email format. Example: example@mail.com';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            // Password Field
            Text(
              'Password',
              style: getTextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: AppColors.textColor,
              ),
            ),
            const SizedBox(height: 8),
            Obx(
              () => AuthCustomTextField(
                text: 'Enter your Password',
                onChanged: (_) => signupController.validateForm(),
                controller: signupController.passwordController,
                obscureText: signupController.isPasswordVisible.value,
                suffixIcon: IconButton(
                  icon: Icon(
                    signupController.isPasswordVisible.value
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined,
                    color: isFemale ? selectedColor : AppColors.buttonColor2,
                  ),
                  onPressed: signupController.togglePasswordVisibility,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Password is required';
                  }
                  if (value.length < 8) {
                    return 'Password must be at least 8 characters';
                  }
                  return null;
                },
              ),
            ),
            const SizedBox(height: 16),
            // Retype Password Field
            Text(
              'Retype Password',
              style: getTextStyle(
                color: AppColors.textColor,
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(height: 8),
            Obx(
              () => AuthCustomTextField(
                controller: signupController.retypePasswordController,
                text: 'Enter your Password',
                onChanged: (_) => signupController.validateForm(),
                obscureText: signupController.isPasswordVisible1.value,
                suffixIcon: IconButton(
                  icon: Icon(
                    signupController.isPasswordVisible1.value
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined,
                    color: isFemale ? selectedColor : AppColors.buttonColor2,
                  ),
                  onPressed: signupController.togglePasswordVisibility1,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please confirm your password';
                  }
                  if (value != signupController.passwordController.text) {
                    return 'Passwords do not match';
                  }
                  return null;
                },
              ),
            ),
            const SizedBox(height: 30),
            // Sign Up Button
            Obx(() {
              final isValid = signupController.isFormValid.value;
              return CustomButton(
                title: 'Sign Up',
                textColor:
                    isValid
                        ? AppColors.primary
                        : isFemale
                        ? const Color(0xFFEBA8B5)
                        : AppColors.buttonColor2,
                onPress:
                    isValid
                        ? () async {
                          await signupController.registerUser();
                          if (signupController.responseMessage.value.contains(
                            'success',
                          )) {
                            Get.to(() => EvenProfileSetupScreen());
                          }
                        }
                        : null,
                backgroundColor:
                    isValid
                        ? (isFemale ? selectedColor : AppColors.buttonColor2)
                        : (isFemale
                            ? selectedColor.withValues(alpha: 0.1)
                            : AppColors.buttonColor2.withValues(alpha: 0.1)),
                borderColor:
                    isFemale
                        ? Colors.transparent
                        : (isValid
                            ? AppColors.buttonColor2
                            : AppColors.buttonColor2.withValues(alpha: 0.1)),
              );
            }),
            const SizedBox(height: 60),
            // Sign In Link
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Already have an account?",
                  style: getTextStyle(
                    color: AppColors.textColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(width: 8),
                GestureDetector(
                  onTap: () => Get.to(() => LogInScreen()),
                  child: Text(
                    "Sign In",
                    style: getTextStyle(
                      color: isFemale ? selectedColor : AppColors.buttonColor2,
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
    );
  }
}
