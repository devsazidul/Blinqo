import 'dart:async';

import 'package:blinqo/core/urls/endpoint.dart';
import 'package:blinqo/features/role/service_provider/auth/screen/sp_change_password_screen.dart';
import 'package:blinqo/features/role/service_provider/auth/screen/sp_login_screen.dart';
import 'package:blinqo/features/role/service_provider/services/sp_network_caller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class SpOtpVerifyController extends GetxController {
  String _errorMessage = '';
  String get errorMessage => _errorMessage;

  TextEditingController pinController = TextEditingController();

  RxBool isFormValid = false.obs;
  RxInt resendTimer = 120.obs; // 2 minutes in seconds
  Timer? _timer;

  void validateForm() {
    isFormValid.value = pinController.text.length == 6;
    update();
  }

  /// Forget Password Verify Otp
  Future<bool> forgetPasswordVerifyOtp({required String email}) async {
    EasyLoading.show(status: "Verifying OTP....");
    bool isSuccess = false;
    update();

    Map<String, dynamic> requestBody = {
      "email": email,
      "code": pinController.text,
    };

    final response = await Get.find<SpNetworkCaller>().postRequest(
      Urls.verifyResetCode,
      requestBody,
    );

    if (response.isSuccess) {
      isSuccess = true;
      _errorMessage = '';
      Get.to(
        () => SpChangePasswordScreen(email: email, otp: pinController.text),
      );
      EasyLoading.showSuccess(response.responseData['message']);
    } else {
      isSuccess = false;
      _errorMessage = response.errorMessage;
      EasyLoading.showError(response.errorMessage);
    }
    EasyLoading.dismiss();
    update();
    return isSuccess;
  }

  /// Confirm Email Verify Otp
  Future<bool> confirmEmailVerifyOtp({required String email}) async {
    EasyLoading.show(status: "Verifying OTP....");
    bool isSuccess = false;
    update();

    try {
      Map<String, dynamic> requestBody = {
        "identifier": email,
        "code": pinController.text,
      };

      final response = await Get.find<SpNetworkCaller>().postRequest(
        Urls.verifyEmail,
        requestBody,
      );

      if (response.isSuccess) {
        isSuccess = true;
        _errorMessage = '';
        // Clear the navigation stack and go to login screen
        await EasyLoading.showSuccess(response.responseData['message']);
        Get.offAll(() => SpLoginScreen());
      } else {
        isSuccess = false;
        _errorMessage = response.errorMessage;
        EasyLoading.showError(response.errorMessage);
      }
    } catch (e) {
      isSuccess = false;
      _errorMessage = 'An error occurred. Please try again.';
      EasyLoading.showError(_errorMessage);
    } finally {
      EasyLoading.dismiss();
      update();
    }
    return isSuccess;
  }

  /// Resend Otp
  Future<bool> resendOtp({required String email}) async {
    EasyLoading.show(status: "Resending OTP....");
    bool isSuccess = false;
    update();

    Map<String, dynamic> requestBody = {"email": email};

    final response = await Get.find<SpNetworkCaller>().postRequest(
      Urls.resendPasswordResetCode,
      requestBody,
    );

    if (response.isSuccess) {
      isSuccess = true;
      startResendTimer(); // Restart the timer when OTP is resent
      EasyLoading.showSuccess(response.responseData['message']);
    } else {
      isSuccess = false;
      EasyLoading.showError(response.errorMessage);
    }
    EasyLoading.dismiss();
    update();
    return isSuccess;
  }

  void startResendTimer() {
    resendTimer.value = 120; // Reset to 2 minutes
    _timer?.cancel();
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (resendTimer.value > 0) {
        resendTimer.value--;
      } else {
        _timer?.cancel();
      }
    });
  }

  bool get canResend => resendTimer.value == 0;

  @override
  void onInit() {
    super.onInit();
    startResendTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    pinController.dispose();
    super.dispose();
  }
}
