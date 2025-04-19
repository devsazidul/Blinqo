import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/common/widgets/auth_custom_textfield.dart';
import 'package:blinqo/core/common/widgets/custom_button.dart';
import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:blinqo/features/role/event_planner/auth/controller/signup_controller.dart';
import 'package:blinqo/features/role/event_planner/auth/screen/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});
  SignUpController singupController = Get.find<SignUpController>();
  @override
  Widget build(BuildContext context) {
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
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.01),
              Text(
                'Name',
                style: getTextStyle(
                  color: AppColors.textColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(height: 8),
              AuthCustomTextField(
                text: 'Enter your Name',
                onChanged: (value) {
                  singupController.validateFrom();
                },
                controller: singupController.nameController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Enter Your Name';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              Text(
                'Phone Number',
                style: getTextStyle(
                  color: AppColors.textColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(height: 8),
              AuthCustomTextField(
                controller: singupController.phoneController1,
                text: 'Enter your Phone Number',
                onChanged: (value) {
                  singupController.validateFrom();
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Enter Phone Number e.g:+8801234567891';
                  }
                  RegExp phoneRegex = RegExp(r'^\+8801[3-9][0-9]{8}$');
                  if (!phoneRegex.hasMatch(value)) {
                    return 'Invalid phone number format. Use +8801XXXXXXXXX';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              Text(
                'Email',
                style: getTextStyle(
                  color: AppColors.textColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(height: 8),
              AuthCustomTextField(
                controller: singupController.emailController1,
                text: 'Enter your Email',
                onChanged: (value) {
                  singupController.validateFrom();
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Enter a valid email address';
                  }

                  RegExp emailRegex = RegExp(
                    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
                  );
                  if (!emailRegex.hasMatch(value)) {
                    return 'Invalid email format. Example: example@mail.com';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              Text(
                'Password',
                style: getTextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: AppColors.textColor,
                ),
              ),
              SizedBox(height: 8),
              Obx(
                () => AuthCustomTextField(
                  text: 'Enter your Password',
                  onChanged: (value) {
                    singupController.validateFrom();
                  },
                  controller: singupController.passwordController,
                  obscureText: singupController.isPasswordVisible.value,
                  suffixIcon: IconButton(
                    icon: Icon(
                      singupController.isPasswordVisible.value
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                      color: AppColors.buttonColor2,
                    ),
                    onPressed: singupController.togglePasswordVisibility,
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
              SizedBox(height: 16),
              Text(
                'Retype Password',
                style: getTextStyle(
                  color: AppColors.textColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(height: 8),
              Obx(
                () => AuthCustomTextField(
                  controller: singupController.retypepasswordController,
                  text: 'Enter your Password',
                  onChanged: (value) {
                    singupController.validateFrom();
                  },
                  obscureText: singupController.isPasswordVisible1.value,
                  suffixIcon: IconButton(
                    icon: Icon(
                      singupController.isPasswordVisible1.value
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                      color: AppColors.buttonColor2,
                    ),
                    onPressed: singupController.togglePasswordVisibility1,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please confirm your password';
                    }
                    if (value != singupController.passwordController.text) {
                      return 'Passwords do not match';
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(height: 30),
              Obx(
                () => CustomButton(
                  title: 'Sign Up',
                  textcolor:
                      singupController.isFromValid.value
                          ? Colors.white
                          : AppColors.buttonColor2,
                  onPress: singupController.isFromValid.value ? () {} : null,
                  backgroundColor:
                      singupController.isFromValid.value
                          ? AppColors.buttonColor2
                          : AppColors.buttonColor2.withValues(alpha: 0.1),
                  borderColor:
                      singupController.isFromValid.value
                          ? AppColors.buttonColor2
                          : AppColors.buttonColor2.withValues(alpha: 0.1),
                ),
              ),
              SizedBox(height: 60),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don not have an account?",
                    style: getTextStyle(
                      color: AppColors.textColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(width: 8),
                  GestureDetector(
                    onTap: () {
                      Get.to(() => LogInScreen());
                    },
                    child: Text(
                      "Sign In",
                      style: getTextStyle(
                        color: AppColors.buttonColor2,
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
    );
  }
}
