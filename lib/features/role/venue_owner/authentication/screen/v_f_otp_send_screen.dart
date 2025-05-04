import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/common/widgets/custom_button.dart';
import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:blinqo/features/role/venue_owner/authentication/controller/v_forget_password_controller.dart';
class VForgetOTPScreen extends StatelessWidget {
  final String email;

  const VForgetOTPScreen({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    final VForgetPasswordController vForgetPasswordController = Get.put(
      VForgetPasswordController(),
    );

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Enter the\nconfirmation code',
                  style: getTextStyle(
                    color: const Color(0xFF082B09),
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 32),
                PinCodeTextField(
                  autoDisposeControllers: false,
                  appContext: context,
                  length: 6,
                  controller: vForgetPasswordController.pinController,
                  onChanged: (value) => vForgetPasswordController.isValidForm(),
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
                const SizedBox(height: 20),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text:
                            'Verification code has been sent to the email Your ',
                        style: getTextStyle(
                          color: const Color(0xFF333333),
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      TextSpan(
                        text:
                            '${email.substring(0, 3)}****@${email.split('@')[1]}',
                        style: getTextStyle(
                          color: const Color(0xFF00BA0B),
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 32),

                // Reactive Button (Changed color based on OTP length)
                Obx(
                  () => CustomButton(
                    title: 'Continue',
                    textColor:
                        vForgetPasswordController.isFormValid2.value
                            ? Colors.white
                            : const Color(0xFF003366),
                    onPress:
                        vForgetPasswordController.isFormValid2.value
                            ? () {
                              vForgetPasswordController.verifyOTP();
                            }
                            : null,
                    backgroundColor:
                        vForgetPasswordController.isFormValid2.value
                            ? const Color(0xFF003366)
                            : const Color(0xFF003366).withOpacity(0.1),
                    borderColor:
                        vForgetPasswordController.isFormValid2.value
                            ? const Color(0xFF003366)
                            : const Color(0xFF003366).withOpacity(0.1),
                  ),
                ),
                const SizedBox(height: 32),
                // i want a resende text button where 2 minutes will be there after 2 minutes the button will be active again
                Obx((){
                  return vForgetPasswordController.timeCountdown.value > 0
                      ? Text(
                          'Resend OTP in ${vForgetPasswordController.timeCountdown.value} seconds',
                          style: getTextStyle(
                            color: const Color(0xFF333333),
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        )
                      : GestureDetector(
                          onTap: () {
                            vForgetPasswordController.sendOTP();
                          },
                          child:  Text(
                            'Resend OTP',
                            style: getTextStyle(
                              color: const Color(0xFF00BA0B),
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        );
                })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
