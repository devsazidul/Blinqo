import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/common/widgets/auth_custom_textfield.dart';
import 'package:blinqo/features/role/venue_owner/authentication/controller/v_forget_password_controller.dart';
import 'package:blinqo/features/role/venue_owner/authentication/screen/v_opt_send_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class VForgetPassword extends StatelessWidget {
  VForgetPassword({super.key});
  final ValueNotifier<int> focusedButtonIndex = ValueNotifier<int>(0);

  final VForgetPasswordController forgetPasswordController = Get.put(
    VForgetPasswordController(),
  );
  var isLoading = false.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(
          "Forget Password",
          style: getTextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: Color(0xff333333),
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
                  color: Color(0xff5F5F5F),
                ),
              ),
            ),
            SizedBox(height: 10),
            Center(
              child: Text(
                "number for confirmation code.",
                style: getTextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Color(0xff5F5F5F),
                ),
              ),
            ),
            SizedBox(height: 18),
            Container(
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(4)),
              height: 44,
              width: 190,

              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: () {
                      focusedButtonIndex.value = 0;
                    },
                    child: ValueListenableBuilder<int>(
                      valueListenable: focusedButtonIndex,
                      builder: (context, value, child) {
                        return Container(
                          height: 44,
                          width: 93,
                          decoration: BoxDecoration(
                            color:
                                value == 0
                                    ? Color(0xff333333)
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
                                        ? Colors.white
                                        : Color(0xff082B09),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      focusedButtonIndex.value = 1;
                    },
                    child: ValueListenableBuilder<int>(
                      valueListenable: focusedButtonIndex,
                      builder: (context, value, child) {
                        return Container(
                          height: 44,
                          width: 93,
                          decoration: BoxDecoration(
                            color:
                                value == 1
                                    ? Color(0xff333333)
                                    : Colors.transparent,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Center(
                            child: Text(
                              "Phone",
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 16,
                                color:
                                    value == 1
                                        ? Colors.white
                                        : Color(0xff082B09),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 31),
            ValueListenableBuilder<int>(
              valueListenable: focusedButtonIndex,
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
                                    color: Color(0xff333333),
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
                    if (value == 1)
                      Padding(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  "Phone",
                                  style: getTextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xff333333),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 8),
                            AuthCustomTextField(
                              controller:
                                  forgetPasswordController.phoneController,
                              text: "Enter your phone number",
                            ),
                          ],
                        ),
                      ),
                  ],
                );
              },
            ),
            SizedBox(height: 63),
            Padding(
              padding: const EdgeInsets.all(12),
              child: SizedBox(
                height: 48,
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.all(0),
                    backgroundColor: Color(0xff003366),
                    minimumSize: Size(double.infinity, 48),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {
                    // if (emailController.text.isEmpty) {
                    //   EasyLoading.showError('Please enter your email');
                    // } else {
                    //   forgetPasswordController.emailController.value =
                    //       emailController.text;
                    //   forgetPasswordController.sendOtp(emailController.text);
                    // }
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => VOptSendScreen()),
                    );
                  },
                  child: Text("Send", style: TextStyle(color: Colors.white)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
