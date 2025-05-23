import 'package:blinqo/features/role/service_provider/auth/controller/sp_otp_verify_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

// ignore: must_be_immutable
class SpCustomPinField extends StatelessWidget {
  final TextEditingController controller;

  const SpCustomPinField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return PinCodeTextField(
      autoDisposeControllers: false,
      controller: controller,
      appContext: context,
      length: 6,
      onChanged: (value) {
        controller.text = value;
        Get.put(SpOtpVerifyController()).validateForm();
      },
      pinTheme: PinTheme(
        fieldHeight: 50,
        fieldWidth: 50,
        selectedBorderWidth: 1,
        selectedColor: Color(0xFF003366),
        activeColor: Color(0xFFA7A7A7),
        inactiveColor: Color(0xFFEBFAEB),
        activeBorderWidth: 1,
        inactiveBorderWidth: 1,
        shape: PinCodeFieldShape.box,
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}
