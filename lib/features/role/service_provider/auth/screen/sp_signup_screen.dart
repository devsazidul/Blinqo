import 'dart:io';

import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/common/widgets/auth_custom_textfield.dart';
import 'package:blinqo/core/common/widgets/custom_continue_button.dart';
import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:blinqo/features/role/service_provider/auth/controller/sp_signup_controller.dart';
import 'package:blinqo/features/role/service_provider/auth/screen/sp_confirm_email_verify_otp_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class SpSignupScreen extends StatelessWidget {
  SpSignupScreen({super.key});
  SpSignupController signUpController = Get.put(SpSignupController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        forceMaterialTransparency: true,
        title: Text(
          'Sign Up',
          style: getTextStyle(
            color: Color(0xFF082B09),
            fontSize: 24,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20),
          //* ---------------------- Form --------------------
          child: Form(
            key: signUpController.formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                Text(
                  'Name',
                  style: getTextStyle(
                    color: Color(0xFF333333),
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(height: 8),

                //* ---------------------- Name Text Field --------------------
                AuthCustomTextField(
                  text: 'Enter your Name',
                  onChanged: (value) => signUpController.validateFrom(),
                  controller: signUpController.nameController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Enter Your Name';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                Text(
                  'Phone Number',
                  style: getTextStyle(
                    color: Color(0xFF333333),
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(height: 8),

                //* ---------------------- Phone Number Text Field --------------------
                AuthCustomTextField(
                  controller: signUpController.phoneController1,
                  text: 'Enter your Phone Number',
                  onChanged: (value) => signUpController.validateFrom(),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Enter Phone Number';
                    }
                    // RegExp phoneRegex = RegExp(r'^\+8801[3-9][0-9]{8}$');
                    // if (!phoneRegex.hasMatch(value)) {
                    //   return 'Invalid phone number format. Use +8801XXXXXXXXX';
                    // }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                Text(
                  'Email',
                  style: getTextStyle(
                    color: Color(0xFF333333),
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(height: 8),

                //* ---------------------- Email Text Field --------------------
                AuthCustomTextField(
                  controller: signUpController.emailController1,
                  text: 'Enter your Email',
                  onChanged: (value) => signUpController.validateFrom(),
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
                SizedBox(height: 16),
                Text(
                  'Password',
                  style: getTextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF333333),
                  ),
                ),
                SizedBox(height: 8),

                //* ---------------------- Password Text Field --------------------
                Obx(
                  () => AuthCustomTextField(
                    onChanged: (value) => signUpController.validateFrom(),
                    controller: signUpController.passwordController,
                    text: 'Enter your Password',
                    suffixIcon: IconButton(
                      icon: Icon(
                        signUpController.isPasswordVisible.value
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                        color: Color(0xFF003366),
                      ),
                      onPressed: signUpController.togglePasswordVisibility,
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
                    color: Color(0xFF333333),
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(height: 8),

                //* ---------------------- Retype Password Text Field --------------------
                Obx(
                  () => AuthCustomTextField(
                    onChanged: (value) => signUpController.validateFrom(),
                    controller: signUpController.retypePasswordController,
                    text: 'Enter your Password',
                    obscureText: signUpController.isPasswordVisible1.value,
                    suffixIcon: IconButton(
                      icon: Icon(
                        signUpController.isPasswordVisible1.value
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                        color: Color(0xFF003366),
                      ),
                      onPressed: signUpController.togglePasswordVisibility1,
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please confirm your password';
                      }
                      if (value != signUpController.passwordController.text) {
                        return 'Passwords do not match';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(height: 32),

                //* ---------------------- Sign Up Button --------------------
                Obx(
                  () => CustomContinueButton(
                    title: 'Sign Up',
                    textColor:
                        signUpController.isFromValid.value
                            ? Colors.white
                            : Color(0xFF003366),
                    onPress: () {
                      // signUpController.validateFrom();
                      if (signUpController.isFromValid.value) {
                        signUpController.signUp();
                      }
                    },

                    backgroundColor:
                        signUpController.isFromValid.value
                            ? Color(0xFF003366)
                            // ignore: deprecated_member_use
                            : Color(0xFF003366).withOpacity(0.1),
                    borderColor:
                        signUpController.isFromValid.value
                            ? Color(0xFF003366)
                            // ignore: deprecated_member_use
                            : Color(0xFF003366).withOpacity(0.1),
                  ),
                ),

                SizedBox(height: 28),
                SizedBox(height: 32),
                if (Platform.isAndroid || Platform.isIOS) ...[],
                SizedBox(height: 16),
                if (Platform.isIOS) ...[],
                SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account?",
                      style: getTextStyle(
                        color: Color(0xFF333333),
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(width: 8),
                    GestureDetector(
                      onTap: () {
                        Get.to(SpConfirmEmailVerifyOtpScreen(email: ""));
                        // Get.toNamed(AppRoute.spLoginScreen);
                      },
                      child: Text(
                        "Sign In",
                        style: getTextStyle(
                          color: Color(0xFF003366),
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
