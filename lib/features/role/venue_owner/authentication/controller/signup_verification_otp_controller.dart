import 'package:blinqo/features/role/venue_owner/authentication/controller/v_signup_controller.dart' show VSignupController;
import 'package:blinqo/features/role/venue_owner/authentication/screen/v_login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:blinqo/core/urls/endpoint.dart';
import 'package:blinqo/features/role/venue_owner/owern_network_caller/owner_network_caller.dart';

class VerificationCodeController extends GetxController {

  final TextEditingController codeController = TextEditingController();
  var isFormValid = false.obs;
  var errorMessage = ''.obs;

  @override
  void onInit() {
    // Add listener to trigger validation on text changes
    codeController.addListener(validateForm);
    super.onInit();
  }

  @override
  void onClose() {
    codeController.dispose();
    super.onClose();
  }

  // Validate verification code
  String? validateCode(String? value) {
    if (value == null || value.isEmpty) {
      errorMessage.value = 'Enter the 6-digit code';
      return 'Enter the 6-digit code';
    }
    if (value.length != 6 || !RegExp(r'^\d{6}$').hasMatch(value)) {
      errorMessage.value = 'Code must be a 6-digit number';
      return 'Code must be a 6-digit number';
    }
    errorMessage.value = '';  // Clear error if valid
    return null;
  }

  // Check if form is valid
  void validateForm() {
    isFormValid.value = validateCode(codeController.text) == null;
  }

  // Handle verification API call
  Future<void> verifyCode(String email) async {
    if (!isFormValid.value) {
      errorMessage.value = 'Please enter a valid 6-digit code';
      EasyLoading.showError(errorMessage.value);
      return;
    }

    final response = await OwnerNetworkCaller().postRequest(
      Url: Urls.verifyEmail,
      body: {
        'identifier': email,
        'code': codeController.text,
      },
    );

    if (response.isSuccess) {
      EasyLoading.showSuccess('Account verified successfully!');
      Get.offAll(() => VLoginScreen());
    } else {
      errorMessage.value = response.errorMessage ?? 'Verification failed';
      EasyLoading.showError(errorMessage.value);
    }
  }

// Handle resend code API call
// Future<void> resendCode() async {
//   final response = await OwnerNetworkCaller().postRequest(
//     Url: Urls.resendCode,
//     body: {
//       'email': email,
//     },
//   );
//
//   if (response.isSuccess) {
//     EasyLoading.showSuccess('Verification code resent successfully!');
//   } else {
//     errorMessage.value = response.errorMessage ?? 'Failed to resend code';
//     EasyLoading.showError(errorMessage.value);
//   }
// }
}
