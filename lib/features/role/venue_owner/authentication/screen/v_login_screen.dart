// ignore_for_file: deprecated_member_use

import 'dart:io';

import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/common/widgets/auth_custom_textfield.dart';
import 'package:blinqo/core/common/widgets/custom_button.dart';
import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:blinqo/features/role/venue_owner/authentication/controller/v_login_controller.dart';
import 'package:blinqo/features/role/venue_owner/authentication/screen/v_forget_password.dart';
import 'package:blinqo/routes/app_routes.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../bottom_nav_bar/screen/vanueOwner_bottom_nav_bar.dart'
    show VanueOwnerBottomNavBar;

// ignore: must_be_immutable
class VLoginScreen extends StatelessWidget {
  VLoginScreen({super.key});
  VenueLoginController loginController = Get.put(VenueLoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                // Text(
                //   'Log In',
                //   style: globalTextStyle(
                //     color: Color(0xFF082B09),
                //     fontSize: 24,
                //     fontWeight: FontWeight.w600,
                //   ),
                // ),
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
                  text: 'Enter your email',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Incorrect email or password';
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
                Obx(() {
                  return AuthCustomTextField(
                    onChanged: (value) {
                      loginController.validateFrom();
                    },
                    text: 'Enter your password',
                    controller: loginController.passwordControler,
                    obscureText: loginController.isPasswordVisible.value,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Incorrect email or password';
                      }
                      return null;
                    },
                  );
                }),
                SizedBox(height: 32),
                Obx(
                  () => CustomButton(
                    title: 'Log In',
                    textcolor:
                        loginController.isFromValid.value
                            ? Colors.white
                            : Color(0xFF003366),
                    onPress: () {
                      Get.to(VanueOwnerBottomNavBar());
                    },
                    backgroundColor:
                        loginController.isFromValid.value
                            ? Color(0xFF003366)
                            : Color(0xFF003366).withOpacity(0.1),
                    borderColor:
                        loginController.isFromValid.value
                            ? Color(0xFF003366)
                            : Color(0xFF003366).withOpacity(0.1),
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
                          builder: (context) => VForgetPassword(),
                        ),
                      );
                    },
                    child: Text(
                      'Forgot Password?',
                      style: getTextStyle(
                        color: Color(0xFFD4AF37),
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
                        Get.toNamed(AppRoute.vsignupscreen);
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
