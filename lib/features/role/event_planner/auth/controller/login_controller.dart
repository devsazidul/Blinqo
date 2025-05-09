import 'dart:async';
import 'package:blinqo/core/urls/endpoint.dart';
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
  debugPrint("Attempting to log in...");
  
  try {
    debugPrint('Sending login request...');
    final response = await http
        .post(
          Uri.parse(Urls.login),
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

    debugPrint('Response status code: ${response.statusCode}');
    debugPrint('Response body: ${response.body}');

    final responseData = jsonDecode(response.body);
    debugPrint('Decoded response data: $responseData');

    if (response.statusCode == 200) {
      // Handle successful login
      final token = responseData['token'] ?? '';
      final roles = List<String>.from(responseData['roles'] ?? []);
      debugPrint('Token: $token');
      debugPrint('Roles: $roles');

      if (!roles.contains('PLANNER')) {
        errorMessage.value = 'Please sign up as a service provider';
        debugPrint('Error: Please sign up as a service provider');
        return false;
      }

      debugPrint('Login successful');
      return true;
    } else {
      errorMessage.value = responseData['message'] ?? 'Login failed';
      debugPrint('Error message: ${errorMessage.value}');

      // Special case for email verification
      if (responseData['message']?.contains('verification code') ?? false) {
        debugPrint('Special case: Email verification required');
        // Get.to(() => OtpSendScreen(email: emailController.text.trim()));
      }

      return false;
    }
  } on http.ClientException catch (e) {
    errorMessage.value = 'Network error: ${e.message}';
    debugPrint('Network error: ${e.message}');
    return false;
  } on TimeoutException {
    errorMessage.value = 'Request timed out';
    debugPrint('TimeoutException: Request timed out');
    return false;
  } on FormatException {
    errorMessage.value = 'Invalid server response';
    debugPrint('FormatException: Invalid server response');
    return false;
  } catch (e) {
    errorMessage.value = 'An unexpected error occurred';
    debugPrint('Unexpected error: $e');
    return false;
  } finally {
    isLoading.value = false;
    debugPrint('Loading finished');
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
