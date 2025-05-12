import 'dart:async';

import 'package:blinqo/features/role/venue_owner/authentication/screen/v_change_password.dart';
import 'package:blinqo/features/role/venue_owner/authentication/screen/v_f_otp_send_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:blinqo/features/role/venue_owner/owern_network_caller/owner_network_caller.dart';
import 'package:blinqo/core/urls/endpoint.dart';

class VForgetPasswordController extends GetxController {
  TextEditingController pinController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  // RxBool to track if form is valid
  var isFormValid2 = false.obs;

  var timeCountdown = 120.obs;
  Timer? countdownTimer;

  // Function to start the countdown timer
  void startTimer() {
    countdownTimer?.cancel();
    timeCountdown.value = 120;
    countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (timeCountdown.value > 0) {
        timeCountdown.value--;
      } else {
        timer.cancel();
      }
    });
  }

  @override
  void onInit() {
    startTimer();
    pinController.addListener(isValidForm);
    super.onInit();
  }

  @override
  void onClose() {
    // pinController.dispose();
    super.onClose();
  }

  // Validate OTP length
  void isValidForm() {
    isFormValid2.value = pinController.text.length == 6;
  }

  // API call to send OTP
  Future<void> sendOTP() async {
    startTimer();
    try {
      final response = await OwnerNetworkCaller().postRequest(
        Url: Urls.passwordReset,
        body: {'email': emailController.text.trim()},
      );
      if (response.isSuccess) {
        EasyLoading.showSuccess('OTP sent successfully, check your email');
        // Navigate to OTP screen with email passed
        Get.to(() => VForgetOTPScreen(email: emailController.text.trim()));
      } else {
        EasyLoading.showError('Failed to send OTP');
      }
    } catch (e) {
      EasyLoading.showError('Failed to send OTP: $e');
    }
  }

  // API call to verify OTP
  Future<void> verifyOTP() async {
    try {
      final response = await OwnerNetworkCaller().postRequest(
        Url: Urls.verifyResetCode,
        body: {
          'email': emailController.text.trim(),
          'code': pinController.text,
        },
      );
      if (response.isSuccess) {
        EasyLoading.showSuccess('OTP verified successfully');
        Get.offAll(() => VChangePassword());
      } else {
        EasyLoading.showError('OTP verification failed');
      }
    } catch (e) {
      EasyLoading.showError('Failed to verify OTP: $e');
    }
  }
}
