import 'package:blinqo/core/services/network_caller.dart';
import 'package:blinqo/core/urls/endpoint.dart';
import 'package:blinqo/features/role/service_provider/auth/screen/sp_login_screen.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class SpChangePasswordController extends GetxController {
  String _errorMassage = '';
  String get errorMessage => _errorMassage;

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

  Future<bool> resetPassword(String email, String otp) async {
    EasyLoading.show(status: 'Resetting Password...');
    bool isSuccess = false;
    update();

    Map<String, String> requestBody = {
      "email": email,
      "code": otp,
      "newPassword": confirmPasswordEditingController.text,
    };

    final response = await Get.find<NetworkCaller>().postRequest(
      Urls.resetPassword,
      requestBody,
    );

    if (response.isSuccess) {
      isSuccess = true;
      Get.to(() => SpLoginScreen());
      EasyLoading.showSuccess(response.responseData['message']);
    } else {
      isSuccess = false;
      _errorMassage = response.errorMessage;
      EasyLoading.showError(response.errorMessage);
    }
    EasyLoading.dismiss();
    update();
    return isSuccess;
  }
}
