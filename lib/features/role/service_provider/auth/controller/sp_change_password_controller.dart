import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class SpChangePasswordController extends GetxController {
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

  // Validate OTP and change password
  // void changePassword(String? email) async {
  //   debugPrint("Parsing email: $email");
  //   debugPrint("New password: ${newPasswordEditingController.text}");
  //   debugPrint("Confirm password: ${confirmPasswordEditingController.text}");

  //   if (!validatePasswords()) {
  //     return; // Don't proceed if validation fails
  //   }

  //   try {
  //     EasyLoading.show(status: 'Verifying OTP...');

  //     Map<String, String> requestBody = {
  //       "password": newPasswordEditingController.text,
  //       "confirmPassword": confirmPasswordEditingController.text,
  //     };

  //     final response = await http.put(
  //       Uri.parse(Urls.updatePassword(email)),
  //       body: requestBody,
  //     );

  //     debugPrint('Response Body: ${response.body}');
  //     debugPrint("Status Code: ${response.statusCode}");

  //     if (response.statusCode == 200) {
  //       EasyLoading.showSuccess('Password Changed Successfully');
  //       // print('Password changed successfully: ${response.body}');
  //       // Optionally, reset fields after success
  //       Get.toNamed(AppRoute.loginScreen);
  //       newPasswordEditingController.clear();
  //       confirmPasswordEditingController.clear();
  //     } else {
  //       var responseData = jsonDecode(response.body);
  //       var errorMessage = responseData['message'] ?? 'An error occurred';

  //       if (errorMessage.contains('Invalid or expired OTP')) {
  //         EasyLoading.showError("Invalid or expired OTP. Please try again.");
  //       } else {
  //         EasyLoading.showError(errorMessage);
  //       }
  //     }
  //   } catch (e) {
  //     EasyLoading.showError("Something went wrong: $e");
  //   } finally {
  //     EasyLoading.dismiss();
  //   }
  // }
}
