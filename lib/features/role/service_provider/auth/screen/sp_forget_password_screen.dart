import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/common/widgets/auth_custom_textfield.dart';
import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:blinqo/features/role/service_provider/auth/controller/sp_forget_password_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class SpForgetPasswordScreen extends StatelessWidget {
  const SpForgetPasswordScreen({super.key});

  // var isLoading = false.obs;

  @override
  Widget build(BuildContext context) {
    final SpForgetPasswordController forgetPasswordController = Get.put(
      SpForgetPasswordController(),
    );
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
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
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 60),
              Center(
                child: Text(
                  "Please Enter your email address \nfor confirmation code.",
                  style: getTextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Color(0xff5F5F5F),
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 32),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Email",
                  style: getTextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Color(0xff333333),
                  ),
                ),
              ),
              SizedBox(height: 8),
              Form(
                key: forgetPasswordController.formKey,
                child: AuthCustomTextField(
                  controller: forgetPasswordController.emailController,
                  text: "Enter your Email",
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter your email";
                    }
                    if (!GetUtils.isEmail(value)) {
                      return "Please enter a valid email";
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(height: 63),
              SizedBox(
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
                  onPressed: () async {
                    if (forgetPasswordController.formKey.currentState!
                        .validate()) {
                      await forgetPasswordController.forgetPasswordOtpSend();
                    }
                  },
                  child: Text("Send", style: getTextStyle(color: Colors.white)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
