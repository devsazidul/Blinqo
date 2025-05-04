import 'package:blinqo/core/urls/endpoint.dart';
import 'package:blinqo/features/role/venue_owner/authentication/controller/v_forget_password_controller.dart';
import 'package:blinqo/features/role/venue_owner/authentication/screen/v_login_screen.dart';
import 'package:blinqo/features/role/venue_owner/owern_network_caller/owner_network_caller.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class ChangedPasswordController extends GetxController {
  VForgetPasswordController vForgetPasswordController = Get.find();
  final newPasswordEditingController = TextEditingController();
  final confirmPasswordEditingController = TextEditingController();

  var newPasswordError = ''.obs;
  var confirmPasswordError = ''.obs;

  // Clear error messages
  void clearErrors() {
    newPasswordError.value = '';
    confirmPasswordError.value = '';
  }

  // Validate passwords
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

  Future<void> changePassword(String email) async {
    // Implement your password change logic here
    try {
      final response = await OwnerNetworkCaller().postRequest(
        Url: Urls.resetPassword,
        body: {
          'email': email,
          'newPassword': confirmPasswordEditingController.text,
        },
      );
      if (response.isSuccess) {
        EasyLoading.showSuccess('Password changed successfully');
        Get.offAll(VLoginScreen());
        clear();
      } else {
        EasyLoading.showError('$response.errorMessage');
      }
    } catch (e) {
      EasyLoading.showError('Failed to change password: $e');
    }
  }

  clear() {
    newPasswordEditingController.clear();
    confirmPasswordEditingController.clear();
    vForgetPasswordController.emailController.clear();
    vForgetPasswordController.pinController.clear();
  }
}
