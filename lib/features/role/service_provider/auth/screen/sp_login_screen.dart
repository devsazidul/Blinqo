import 'dart:io';

import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/common/widgets/auth_custom_textfield.dart';
import 'package:blinqo/core/common/widgets/custom_continue_button.dart';
import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:blinqo/features/role/service_provider/auth/controller/sp_login_controller.dart';
import 'package:blinqo/features/role/service_provider/auth/screen/sp_forget_password_screen.dart';
import 'package:blinqo/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class SpLoginScreen extends StatelessWidget {
  const SpLoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SpLoginController loginController = Get.put(SpLoginController());

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        forceMaterialTransparency: true,
        title: Text(
          'Log In',
          style: getTextStyle(
            color: Color(0xFF333333),
            fontSize: 24,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
          child: Form(
            key: loginController.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 32),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Email',
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
                  onChanged: (value) {},
                  controller: loginController.emailController,
                  keyboardType: TextInputType.emailAddress,
                  text: 'Enter your email',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Email is required';
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
                      'Password',
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
                  onChanged: (value) {
                    loginController.validateForm();
                  },
                  text: 'Enter your password',

                  controller: loginController.passwordController,
                  obscureText: loginController.isPasswordVisible.value,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Password is required';
                    }
                    return null;
                  },
                ),

                SizedBox(height: 32),

                Obx(
                  () => CustomContinueButton(
                    title: 'Log In',
                    textColor:
                        loginController.isFormValid.value
                            ? Colors.white
                            : Color(0xFF003366),

                    backgroundColor:
                        loginController.isFormValid.value
                            ? Color(0xFF003366)
                            : Color(0xFF003366).withValues(alpha: 0.1),
                    borderColor:
                        loginController.isFormValid.value
                            ? Color(0xFF003366)
                            : Color(0xFF003366).withValues(alpha: 0.1),
                    onPress: () async {
                      if (loginController.formKey.currentState!.validate()) {
                        await loginController.login();
                        EasyLoading.dismiss();
                        // bool isSuccess = await loginController.login();
                        // if (isSuccess) {
                        //   await Get.put(
                        //     SpProfileSetupController(),
                        //   ).getEventPreferences();
                        //   Get.offAll(
                        //     SpProfileSetupScreen(),
                        //     predicate: (route) => false,
                        //   );
                        // }
                      }
                    },
                  ),
                ),
                SizedBox(height: 16),
                Align(
                  alignment: Alignment.center,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SpForgetPasswordScreen(),
                        ),
                      );
                    },
                    child: Text(
                      'Forgot Password?',
                      style: getTextStyle(
                        color: AppColors.textColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 36),
                // CustomDivider(),
                SizedBox(height: 32),
                if (Platform.isAndroid || Platform.isIOS) ...[
                  // GestureDetector(
                  //   onTap: () {
                  //     //
                  //   },
                  //   child: Container(
                  //     width: double.infinity,
                  //     padding: EdgeInsets.symmetric(vertical: 8),
                  //     decoration: BoxDecoration(
                  //       color: Color(0XFF5384EE),
                  //       borderRadius: BorderRadius.circular(4),
                  //     ),
                  //     child: Row(
                  //       mainAxisAlignment: MainAxisAlignment.center,
                  //       children: [
                  //         Image.asset(IconPath.google, width: 24, height: 24),
                  //         SizedBox(width: 12),
                  //         Text(
                  //           "Continue with Google",
                  //           style: globalTextStyle(
                  //             color: Colors.white,
                  //             fontWeight: FontWeight.w600,
                  //             fontSize: 16,
                  //           ),
                  //         ),
                  //       ],
                  //     ),
                  //   ),
                  // ),
                ],
                SizedBox(height: 16),
                if (Platform.isIOS) ...[
                  // GestureDetector(
                  //   onTap: () {
                  //     //
                  //   },
                  //   child: Container(
                  //     width: double.infinity,
                  //     padding: EdgeInsets.symmetric(vertical: 8),
                  //     decoration: BoxDecoration(
                  //       color: Colors.black,
                  //       borderRadius: BorderRadius.circular(4),
                  //     ),
                  //     child: Row(
                  //       mainAxisAlignment: MainAxisAlignment.center,
                  //       children: [
                  //         Image.asset(IconPath.apple, width: 24, height: 24),
                  //         SizedBox(width: 12),
                  //         Text(
                  //           "Continue with Apple",
                  //           style: globalTextStyle(
                  //             color: Colors.white,
                  //             fontWeight: FontWeight.w600,
                  //             fontSize: 16,
                  //           ),
                  //         ),
                  //       ],
                  //     ),
                  //   ),
                  // ),
                ],
                SizedBox(height: MediaQuery.of(context).size.height * 0.14),
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
                        Get.toNamed(AppRoute.spSignupScreen);
                      },
                      child: Text(
                        "Sign Up",
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
