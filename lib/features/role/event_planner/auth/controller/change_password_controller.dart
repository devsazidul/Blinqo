import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:blinqo/features/role/event_planner/auth/screen/login_screen.dart';

class ChangePasswordController extends GetxController {
  final newPasswordEditingController = TextEditingController();
  final confirmPasswordEditingController = TextEditingController();

  var newPasswordError = ''.obs;
  var confirmPasswordError = ''.obs;

  String? email;
  String? otp;

  // Set email and OTP received from FPOTPController
  void setEmailAndOtp(String? email, String? otp) {
    this.email = email;
    this.otp = otp;
  }

  void clearErrors() {
    newPasswordError.value = '';
    confirmPasswordError.value = '';
  }

  bool validatePasswords() {
    clearErrors();

    if (newPasswordEditingController.text.isEmpty) {
      newPasswordError.value = 'Password cannot be empty';
      return false;
    }

    if (confirmPasswordEditingController.text.isEmpty) {
      confirmPasswordError.value = 'Confirm Password cannot be empty';
      return false;
    }

    if (newPasswordEditingController.text !=
        confirmPasswordEditingController.text) {
      confirmPasswordError.value = 'Passwords do not match';
      return false;
    }

    if (newPasswordEditingController.text.length < 8) {
      newPasswordError.value = 'Password should be at least 8 characters';
      return false;
    }

    return true;
  }

  Future<void> resetPassword() async {
    debugPrint('[resetPassword] Starting password reset process...');

    if (!validatePasswords()) {
      debugPrint('[resetPassword] Password validation failed');
      return;
    }

    try {
      debugPrint('[resetPassword] Showing loading indicator');
      EasyLoading.show(status: 'Resetting Password...');

      final requestBody = {
        "email": email,
        "newPassword": newPasswordEditingController.text,
        "code": otp,
      };
      debugPrint('[resetPassword] Request body: $requestBody');

      debugPrint('[resetPassword] Making API call to reset password');
      final response = await http.post(
        Uri.parse('https://freepik.softvenceomega.com/auth/reset-password'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(requestBody),
      );

      debugPrint('[resetPassword] API call completed');
      debugPrint('[resetPassword] Response Body: ${response.body}');
      debugPrint('[resetPassword] Status Code: ${response.statusCode}');

      if (response.statusCode >= 200 && response.statusCode < 300) {
        debugPrint('[resetPassword] Password reset successful');
        EasyLoading.showSuccess('Password Reset Successfully');

        debugPrint('[resetPassword] Clearing password fields');
        newPasswordEditingController.clear();
        confirmPasswordEditingController.clear();

        debugPrint('[resetPassword] Navigating to LoginScreen');
        Get.off(() => LogInScreen());
      } else {
        debugPrint(
          '[resetPassword] Password reset failed with status ${response.statusCode}',
        );
        var responseData = jsonDecode(response.body);
        var errorMessage = responseData['message'] ?? 'An error occurred';
        debugPrint('[resetPassword] Error message: $errorMessage');
        EasyLoading.showError(errorMessage);
      }
    } catch (e) {
      debugPrint('[resetPassword] Exception occurred: $e');
      EasyLoading.showError('Something went wrong: $e');
      debugPrint('Error: $e');
    } finally {
      debugPrint('[resetPassword] Dismissing loading indicator');
      EasyLoading.dismiss();
      debugPrint('[resetPassword] Process completed');
    }
  }

  @override
  void onClose() {
    newPasswordEditingController.dispose();
    confirmPasswordEditingController.dispose();
    super.onClose();
  }
}
