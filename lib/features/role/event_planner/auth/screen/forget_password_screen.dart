import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/common/widgets/auth_custom_textfield.dart';
import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:blinqo/features/role/event_planner/auth/controller/forget_password_controller.dart';
import 'package:blinqo/features/role/event_planner/profile/controller/pick_color_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final femaleColorController = Get.find<PickColorController>();
    final bool isFemale = femaleColorController.isFemale.value;
    // Get the controller instance using Get.find()
    final ForgetPasswordController forgetPasswordController = Get.put(
      ForgetPasswordController(),
    );

    return Scaffold(
      backgroundColor: AppColors.loginBg,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Forget Password",
          style: getTextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: AppColors.textColor,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 60),
            Center(
              child: Text(
                "Please Enter your email address or phone",
                style: getTextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: AppColors.textColor2,
                ),
              ),
            ),
            Center(
              child: Text(
                "number for confirmation code.",
                style: getTextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: AppColors.textColor2,
                ),
              ),
            ),
            SizedBox(height: 18),
            SizedBox(
              height: 44,
              width: 190,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: () {
                      forgetPasswordController.focusedButtonIndex.value = 0;
                    },
                    child: ValueListenableBuilder<int>(
                      valueListenable:
                          forgetPasswordController.focusedButtonIndex,
                      builder: (context, value, child) {
                        return Container(
                          height: 44,
                          width: 93,
                          decoration: BoxDecoration(
                            color:
                                value == 0
                                    ? AppColors.textColor
                                    : Colors.transparent,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Center(
                            child: Text(
                              "Email",
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 16,
                                color:
                                    value == 0
                                        ? AppColors.primary
                                        : AppColors.textColor,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  // GestureDetector(
                  //   onTap: () {
                  //     forgetPasswordController.focusedButtonIndex.value = 1;
                  //   },
                  //   child: ValueListenableBuilder<int>(
                  //     valueListenable:
                  //         forgetPasswordController.focusedButtonIndex,
                  //     builder: (context, value, child) {
                  //       return Container(
                  //         height: 44,
                  //         width: 93,
                  //         decoration: BoxDecoration(
                  //           color:
                  //               value == 1
                  //                   ? AppColors.textColor
                  //                   : Colors.transparent,
                  //           borderRadius: BorderRadius.circular(4),
                  //         ),
                  //         child: Center(
                  //           child: Text(
                  //             "Phone",
                  //             style: TextStyle(
                  //               fontWeight: FontWeight.w400,
                  //               fontSize: 16,
                  //               color:
                  //                   value == 1
                  //                       ? AppColors.primary
                  //                       : AppColors.textColor,
                  //             ),
                  //           ),
                  //         ),
                  //       );
                  //     },
                  //   ),
                  // ),
                ],
              ),
            ),
            SizedBox(height: 31),
            ValueListenableBuilder<int>(
              valueListenable: forgetPasswordController.focusedButtonIndex,
              builder: (context, value, child) {
                return Column(
                  children: [
                    if (value == 0)
                      Padding(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  "Email",
                                  style: getTextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    color: AppColors.textColor,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 8),
                            AuthCustomTextField(
                              controller:
                                  forgetPasswordController.emailController,
                              text: "Enter your Email",
                            ),
                          ],
                        ),
                      ),
                    // if (value == 1)
                    //   Padding(
                    //     padding: const EdgeInsets.all(12),
                    //     child: Column(
                    //       children: [
                    //         Row(
                    //           mainAxisAlignment: MainAxisAlignment.start,
                    //           children: [
                    //             Text(
                    //               "Phone",
                    //               style: getTextStyle(
                    //                 fontSize: 16,
                    //                 fontWeight: FontWeight.w400,
                    //                 color: AppColors.textColor,
                    //               ),
                    //             ),
                    //           ],
                    //         ),
                    //         SizedBox(height: 8),
                    //         AuthCustomTextField(
                    //           controller:
                    //               forgetPasswordController.phoneController,
                    //           text: "Enter your phone number",
                    //         ),
                    //       ],
                    //     ),
                    //   ),
                  ],
                );
              },
            ),
            SizedBox(height: 50),
            Padding(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: SizedBox(
                height: 48,
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        isFemale
                            ? femaleColorController.selectedColor
                            : AppColors.buttonColor2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {
                    forgetPasswordController.sendPasswordResetCode();
                  },
                  child: Text(
                    "Send",
                    style: TextStyle(
                      color: AppColors.primary,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
