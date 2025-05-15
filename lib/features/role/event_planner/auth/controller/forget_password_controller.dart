import 'package:blinqo/core/urls/endpoint.dart';
import 'package:blinqo/features/role/event_planner/auth/screen/forget_password_otp_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ForgetPasswordController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  final ValueNotifier<int> focusedButtonIndex = ValueNotifier<int>(0);

  var isLoading = false.obs;
  var isFormValid2 = false.obs;

  Future<void> sendPasswordResetCode() async {
    try {
      debugPrint(
        '[ForgetPasswordController] Starting password reset process...',
      );
      await EasyLoading.show(
        status: 'Processing...',
        maskType: EasyLoadingMaskType.black,
      );
      isLoading(true);

      // Currently only email is enabled (as per your UI)
      final email = emailController.text.trim();
      debugPrint('[ForgetPasswordController] Email entered: $email');

      if (email.isEmpty) {
        debugPrint(
          '[ForgetPasswordController] Email validation failed: Empty email',
        );
        await EasyLoading.showError('Please enter your email');
        return;
      }

      debugPrint(
        '[ForgetPasswordController] Making API call to send password reset code',
      );
      final response = await http.post(
        Uri.parse(Urls.sendPasswordResetCode),
        body: {'email': email},
      );

      debugPrint(
        '[ForgetPasswordController] API Response: ${response.statusCode}',
      );
      debugPrint('[ForgetPasswordController] Response Body: ${response.body}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        debugPrint(
          '[ForgetPasswordController] Password reset code sent successfully',
        );
        await EasyLoading.showSuccess('Code sent successfully');
        emailController.clear();
        Get.to(() => FPOTPScreen(), arguments: email);
      } else {
        debugPrint(
          '[ForgetPasswordController] Failed to send reset code: ${response.statusCode}',
        );
        await EasyLoading.showError('Failed to send reset code');
      }
    } catch (e, stackTrace) {
      debugPrint('[ForgetPasswordController] Exception occurred: $e');
      debugPrint(stackTrace.toString());
      await EasyLoading.showError('An error occurred. Please try again');
    } finally {
      debugPrint('[ForgetPasswordController] Process completed');
      await EasyLoading.dismiss();
      isLoading(false);
    }
  }
}
