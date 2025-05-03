import 'package:blinqo/features/role/venue_owner/authentication/controller/signup_verification_otp_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/common/widgets/custom_button.dart';
import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class VerificationCodeScreen extends StatelessWidget {
  final String email;

  const VerificationCodeScreen({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(VerificationCodeController());

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        toolbarHeight: 65,
        centerTitle: true,
        automaticallyImplyLeading: false,
        forceMaterialTransparency: true,
        title: Text(
          'Enter the confirmation\n code',
          textAlign: TextAlign.center,
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.01),
              Text(
                'Verification code has been sent to the email Your ${email.substring(0, 3)}****@${email.split('@')[1]}',
                style: getTextStyle(
                  color: const Color(0xFF333333),
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  lineHeight: 1.5,
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 32),
              PinCodeTextField(
                appContext: context,
                length: 6,
                controller: controller.codeController,
                onChanged: (value) => controller.validateForm(),
                keyboardType: TextInputType.number,
                pinTheme: PinTheme(
                  shape: PinCodeFieldShape.box,
                  borderRadius: BorderRadius.circular(5),
                  fieldHeight: 50,
                  fieldWidth: 50,
                  selectedColor: Color(0xFF003366),
                  activeColor: Color(0xFFA7A7A7),
                  inactiveColor: Color(0xFFE5E6EB),
                ),
              ),
              const SizedBox(height: 16),
              Obx(() {
                return controller.errorMessage.isNotEmpty
                    ? Text(
                      controller.errorMessage.value,
                      style: getTextStyle(
                        color: Colors.red,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    )
                    : const SizedBox();
              }),
              const SizedBox(height: 32),
              Obx(() {
                return CustomButton(
                  title: 'Verify',
                  textColor:
                      controller.isFormValid.value
                          ? Colors.white
                          : const Color(0xFF003366),
                  onPress:(){
                    if (controller.isFormValid.value) {
                      controller.verifyCode(email);
                    }
                  },
                  backgroundColor:
                      controller.isFormValid.value
                          ? const Color(0xFF003366)
                          : const Color(0xFF003366).withOpacity(0.1),
                  borderColor:
                      controller.isFormValid.value
                          ? const Color(0xFF003366)
                          : const Color(0xFF003366).withOpacity(0.1),
                );
              }),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Didn't receive a code?",
                    style: getTextStyle(
                      color: const Color(0xFF333333),
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(width: 8),
                  GestureDetector(
                    // onTap: controller.resendCode,
                    child: Text(
                      "Resend",
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
    );
  }
}
