import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;

class LoginController extends GetxController {
  LoginController({String? token}) {
    _token = token;
  }

  String? _token;
  // Text controllers
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  // Token Manager Instance
  // State variables
  final isLoading = false.obs;
  final errorMessage = ''.obs;
  final isPasswordVisible = false.obs;
  final isFormValid = false.obs;

  // Constants
  static const String loginUrl =
      'https://freepik.softvenceomega.com/auth/login';

  // Toggle password visibility
  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  // Validate form
  void validateForm() {
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    isFormValid.value =
        emailController.text.isNotEmpty &&
        emailRegex.hasMatch(emailController.text) &&
        passwordController.text.isNotEmpty &&
        passwordController.text.length >= 8;
  }

  // Login API call
  Future<bool> login() async {
    isLoading.value = true;
    errorMessage.value = '';

    debugPrint("login: token : $_token");

    try {
      final response = await http
          .post(
            Uri.parse(loginUrl),
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer $_token',
            },
            body: jsonEncode({
              'email': emailController.text.trim(),
              'password': passwordController.text.trim(),
            }),
          )
          .timeout(const Duration(seconds: 30));

      final responseData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        // Handle successful login
        // ignore: unused_local_variable
        final token = responseData['token'] ?? '';
        final roles = List<String>.from(responseData['roles'] ?? []);

        if (!roles.contains('PLANNER')) {
          errorMessage.value = 'Please sign up as a service provider';
          return false;
        }

        // Save user information (implement your storage method)
        // await saveUserInformation(token, responseData['user']);

        return true;
      } else {
        // Handle API errors
        errorMessage.value = responseData['message'] ?? 'Login failed';

        // Special case for email verification
        if (responseData['message']?.contains('verification code') ?? false) {
          // Get.to(() => OtpSendScreen(email: emailController.text.trim()));
        }

        return false;
      }
    } on http.ClientException catch (e) {
      errorMessage.value = 'Network error: ${e.message}';
      return false;
    } on TimeoutException {
      errorMessage.value = 'Request timed out';
      return false;
    } on FormatException {
      errorMessage.value = 'Invalid server response';
      return false;
    } catch (e) {
      errorMessage.value = 'An unexpected error occurred';
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();

    super.onClose();
  }
}

// class LoginController extends GetxController {
//   TextEditingController passwordControler = TextEditingController();
//   TextEditingController emailController = TextEditingController();
//   var isLoading = false.obs;
//   var errorMessage = ''.obs;
//   var isPasswordVisible = false.obs;
//   void togglePasswordVisibility() {
//     isPasswordVisible.value = !isPasswordVisible.value;
//   }

//   // Controller for the text field
//   TextEditingController categoryController = TextEditingController();

//   // Dummy userId for new category (replace with actual userId)
//   String userId = "user123";

//   var isFromValid = false.obs;
//   void validateFrom() {
//     isFromValid.value =
//         emailController.text.isNotEmpty && passwordControler.text.isNotEmpty;
//   }

//   Future<bool> login() async {
//     EasyLoading.show(status: 'Logging in...');
//     bool isSuccess = false;
//     isLoading.value = true;
//     update();

//     Map<String, dynamic> requestBody = {
//       'email': emailController.text.trim(),
//       'password': passwordControler.text.trim(),
//     };

//     final response = await Get.find<EvenNetworkCaller>().postRequest(
//       Urls.login,
//       requestBody,
//     );

//     if (response.isSuccess) {
//       AuthModel authModel = AuthModel.fromJson(response.responseData['data']);
//       // if (!authModel.user.isVerified) {
//       //   // Get.to(() => SpOtpSendScreen(email: authModel.user.email));
//       //   EasyLoading.showSuccess('Please verify your email address');
//       //   _errorMessage = 'Please verify your email address';
//       //   // Get.to(SpOtpSendScreen(email: authModel.user.email));
//       //   isSuccess = true;
//       // } else
//       if (!authModel.user.roles.contains('PLANNER')) {
//         EasyLoading.showError('You are not a service provider user');
//         errorMessage.value = 'Please sign up as a service provider';
//         return false;
//       } else {
//         await EvenAuthSharedPreferencesSave.saveUserInformation(
//           authModel.accessToken,
//           authModel.user,
//         );
//         isSuccess = true;
//         EasyLoading.showSuccess(response.responseData['message']);
//       }
//     } else {
//       if (response.errorMessage ==
//           "A verification code has been sent to your email. Please verify your email") {
//         // Get.to(() => SpOtpSendScreen(email: emailController.text.trim()));
//         errorMessage.value = response.errorMessage;
//         EasyLoading.showSuccess(response.errorMessage);
//         isSuccess = false;
//       } else {
//         isSuccess = false;
//         errorMessage.value = response.errorMessage;
//         EasyLoading.showError(response.errorMessage);
//       }
//     }
//     isLoading.value = false;
//     update();
//     return isSuccess;
//   }

//   // Fetch categories from the API
// }
