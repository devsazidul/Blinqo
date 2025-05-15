// import 'package:blinqo/core/common/styles/global_text_style.dart';
// import 'package:blinqo/core/common/widgets/auth_custom_textfield.dart';
// import 'package:blinqo/core/common/widgets/custom_button.dart';
// import 'package:blinqo/core/utils/constants/colors.dart';
// import 'package:blinqo/features/profile/controller/pick_color_controller.dart';
// import 'package:blinqo/features/role/event_planner/auth/controller/login_controller.dart';
// import 'package:blinqo/features/role/event_planner/auth/screen/forget_password_screen.dart';
// import 'package:blinqo/features/role/event_planner/auth/screen/signup_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// // ignore: must_be_immutable

// class LogInScreen extends StatelessWidget {
//   LogInScreen({super.key});

//   final LoginController loginController = Get.find<LoginController>();

//   @override
//   Widget build(BuildContext context) {
//     final screenHeight = MediaQuery.of(context).size.height;
//     final PickColorController femaleColorController = Get.put(
//       PickColorController(),
//     );

//     return Scaffold(
//       backgroundColor: AppColors.loginBg,
//       appBar: AppBar(
//         centerTitle: true,
//         forceMaterialTransparency: true,
//         title: Text(
//           'Log In',
//           style: getTextStyle(
//             color: AppColors.textColor,
//             fontSize: 24,
//             fontWeight: FontWeight.w600,
//           ),
//         ),
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
//           child: Form(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 const SizedBox(height: 20),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       'Email',
//                       style: getTextStyle(
//                         color: AppColors.textColor,
//                         fontSize: 16,
//                         fontWeight: FontWeight.w400,
//                       ),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 8),
//                 AuthCustomTextField(
//                   onChanged: (value) {
//                     loginController.validateForm();
//                   },
//                   controller: loginController.emailController,
//                   text: 'Enter your email',
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'Please enter your email';
//                     }
//                     return null;
//                   },
//                 ),
//                 const SizedBox(height: 20),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       'Password',
//                       style: getTextStyle(
//                         color: const Color(0xFF333333),
//                         fontSize: 16,
//                         fontWeight: FontWeight.w400,
//                       ),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 8),
//                 Obx(
//                   () => AuthCustomTextField(
//                     onChanged: (value) {
//                       loginController.validateForm();
//                     },
//                     text: 'Enter your password',
//                     controller: loginController.passwordController,
//                     obscureText: !loginController.isPasswordVisible.value,
//                     suffixIcon: IconButton(
//                       icon: Icon(
//                         loginController.isPasswordVisible.value
//                             ? Icons.visibility
//                             : Icons.visibility_off,
//                         color: AppColors.textColor,
//                       ),
//                       onPressed: loginController.togglePasswordVisibility,
//                     ),
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return 'Please enter your password';
//                       }
//                       return null;
//                     },
//                   ),
//                 ),
//                 const SizedBox(height: 20),
//                 Obx(
//                   () =>
//                       loginController.errorMessage.isNotEmpty
//                           ? Padding(
//                             padding: const EdgeInsets.only(bottom: 16),
//                             child: Text(
//                               loginController.errorMessage.value,
//                               style: getTextStyle(
//                                 color: Colors.red,
//                                 fontSize: 14,
//                                 fontWeight: FontWeight.w400,
//                               ),
//                             ),
//                           )
//                           : const SizedBox.shrink(),
//                 ),
//                 Obx(() {
//                   final bool isFemale = femaleColorController.isFemale.value;
//                   return CustomButton(
//                     title:
//                         loginController.isLoading.value
//                             ? 'Logging In...'
//                             : 'Log In',
//                     textColor:
//                         loginController.isFormValid.value && isFemale
//                             ? AppColors.primary
//                             : loginController.isFormValid.value && !isFemale
//                             ? AppColors.primary
//                             : !loginController.isFormValid.value && isFemale
//                             ? const Color(0xFFEBA8B5)
//                             : AppColors.buttonColor2,
//                     // onPress:
//                     // loginController.isFormValid.value &&
//                     //         !loginController.isLoading.value
//                     //     ? () async {
//                     //       final success = await loginController.login(context);
//                     //       if (success) {
//                     //         Get.offAll(() => const EventBottomNavBar());
//                     //       }
//                     //     }
//                     //     : null,
//                     onPress: () {
//                       loginController.login(context);
//                     },

//                     backgroundColor:
//                         loginController.isFormValid.value && isFemale
//                             ? femaleColorController.selectedColor
//                             : loginController.isFormValid.value && !isFemale
//                             ? const Color.fromARGB(255, 31, 63, 96)
//                             : !loginController.isFormValid.value && isFemale
//                             ? femaleColorController.selectedColor.withValues(
//                               alpha: 0.1,
//                             )
//                             : AppColors.buttonColor2.withValues(alpha: 0.1),
//                     borderColor:
//                         isFemale
//                             ? Colors.transparent
//                             : loginController.isFormValid.value
//                             ? AppColors.buttonColor2
//                             : AppColors.buttonColor2.withValues(alpha: 0.1),
//                   );
//                 }),
//                 const SizedBox(height: 16),
//                 Align(
//                   alignment: Alignment.center,
//                   child: GestureDetector(
//                     onTap: () {
//                       Get.to(() => const ForgetPasswordScreen());
//                     },
//                     child: Text(
//                       'Forgot Password?',
//                       style: getTextStyle(
//                         color: AppColors.textColor,
//                         fontSize: 14,
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                   ),
//                 ),
//                 SizedBox(height: screenHeight * 0.25),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Text(
//                       "Don't have an account?",
//                       style: getTextStyle(
//                         color: AppColors.textColor,
//                         fontSize: 14,
//                         fontWeight: FontWeight.w400,
//                       ),
//                     ),
//                     const SizedBox(width: 8),
//                     GestureDetector(
//                       onTap: () {
//                         Get.to(() => const SignUpScreen());
//                       },
//                       child: Obx(
//                         () => Text(
//                           "Sign Up",
//                           style: getTextStyle(
//                             color:
//                                 femaleColorController.isFemale.value
//                                     ? femaleColorController.selectedColor
//                                     : AppColors.buttonColor2,
//                             fontSize: 14,
//                             fontWeight: FontWeight.w500,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }


import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/common/widgets/auth_custom_textfield.dart';
import 'package:blinqo/core/common/widgets/custom_button.dart';
import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:blinqo/features/profile/controller/pick_color_controller.dart';
import 'package:blinqo/features/role/event_planner/auth/controller/login_controller.dart';
import 'package:blinqo/features/role/event_planner/auth/screen/forget_password_screen.dart';
import 'package:blinqo/features/role/event_planner/auth/screen/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LogInScreen extends StatelessWidget {
  LogInScreen({super.key});

  final LoginController loginController = Get.find<LoginController>();

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final PickColorController femaleColorController = Get.put(
      PickColorController(),
    );

    return Scaffold(
      backgroundColor: AppColors.loginBg,
      appBar: AppBar(
        centerTitle: true,
        forceMaterialTransparency: true,
        title: Text(
          'Log In',
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
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Email',
                      style: getTextStyle(
                        color: AppColors.textColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                AuthCustomTextField(
                  onChanged: (value) {
                    loginController.validateForm();
                  },
                  controller: loginController.emailController,
                  text: 'Enter your email',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Password',
                      style: getTextStyle(
                        color: const Color(0xFF333333),
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Obx(
                  () => AuthCustomTextField(
                    onChanged: (value) {
                      loginController.validateForm();
                    },
                    text: 'Enter your password',
                    controller: loginController.passwordController,
                    obscureText: !loginController.isPasswordVisible.value,
                    suffixIcon: IconButton(
                      icon: Icon(
                        loginController.isPasswordVisible.value
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: AppColors.textColor,
                      ),
                      onPressed: loginController.togglePasswordVisibility,
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 20),
                Obx(
                  () =>
                      loginController.errorMessage.isNotEmpty
                          ? Padding(
                            padding: const EdgeInsets.only(bottom: 16),
                            child: Text(
                              loginController.errorMessage.value,
                              style: getTextStyle(
                                color: Colors.red,
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          )
                          : const SizedBox.shrink(),
                ),
                Obx(() {
                  final bool isFemale = femaleColorController.isFemale.value;
                  return CustomButton(
                    title:
                        loginController.isLoading.value
                            ? 'Logging In...'
                            : 'Log In',
                    onPress: () {
                      loginController.login(context);
                    },
                    backgroundColor: loginController.isLoading.value
                        ? AppColors.buttonColor2.withOpacity(0.5)
                        : AppColors.buttonColor2,
                  );
                }),
                const SizedBox(height: 16),
                Align(
                  alignment: Alignment.center,
                  child: GestureDetector(
                    onTap: () {
                      Get.to(() => const ForgetPasswordScreen());
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
                SizedBox(height: screenHeight * 0.25),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account?",
                      style: getTextStyle(
                        color: AppColors.textColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(width: 8),
                    GestureDetector(
                      onTap: () {
                        Get.to(() => const SignUpScreen());
                      },
                      child: Obx(
                        () => Text(
                          "Sign Up",
                          style: getTextStyle(
                            color:
                                femaleColorController.isFemale.value
                                    ? femaleColorController.selectedColor
                                    : AppColors.buttonColor2,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
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
