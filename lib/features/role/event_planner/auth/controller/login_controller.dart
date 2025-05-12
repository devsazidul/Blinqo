// import 'dart:async';
// import 'package:blinqo/core/urls/endpoint.dart';
// import 'package:blinqo/features/role/event_planner/auth/screen/otp_screen.dart';
// import 'package:blinqo/features/role/event_planner/bottom_nav_bar/screen/event_bottom_nav_bar.dart';
// import 'package:blinqo/features/role/event_planner/profile_setup/screens/profile_setup.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'dart:convert';
// import 'package:http/http.dart' as http;

// class LoginController extends GetxController {
//   LoginController({String? token}) {
//     _token = token;
//   }

//   String? _token;
//   // Text controllers
//   final TextEditingController passwordController = TextEditingController();
//   final TextEditingController emailController = TextEditingController();
//   // Token Manager Instance
//   // State variables
//   final isLoading = false.obs;
//   final errorMessage = ''.obs;
//   final isPasswordVisible = false.obs;
//   final isFormValid = false.obs;

//   // Toggle password visibility
//   void togglePasswordVisibility() {
//     isPasswordVisible.value = !isPasswordVisible.value;
//   }

//   // Validate form
//   void validateForm() {
//     final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
//     isFormValid.value =
//         emailController.text.isNotEmpty &&
//         emailRegex.hasMatch(emailController.text) &&
//         passwordController.text.isNotEmpty &&
//         passwordController.text.length >= 8;
//   }

//   Future<bool> login(BuildContext context) async {
//     isLoading.value = true;
//     debugPrint("login: token : $_token");
//     debugPrint("Attempting to log in...");

//     try {
//       debugPrint('Sending login request...');
//       final response = await http
//           .post(
//             Uri.parse(Urls.login),
//             headers: {
//               'Content-Type': 'application/json',
//               if (_token != null && _token!.isNotEmpty)
//                 'Authorization': 'Bearer $_token',
//             },
//             body: jsonEncode({
//               'email': emailController.text.trim(),
//               'password': passwordController.text.trim(),
//             }),
//           )
//           .timeout(const Duration(seconds: 30));

//       debugPrint('Response status code: ${response.statusCode}');
//       debugPrint('Response body: ${response.body}');

//       final responseData = jsonDecode(response.body);
//       debugPrint('Decoded response data: $responseData');

//       if (response.statusCode == 200 || response.statusCode == 201) {
//         // Check if login was successful from the response
//         if (responseData['success'] == true &&
//             responseData['message'] == 'Login Successful') {
//           // Get user data from response
//           final userData = responseData['data']['user'];
//           final roles = List<String>.from(userData['roles'] ?? []);

//           // Check if user has PLANNER role
//           if (!roles.contains('PLANNER')) {
//             errorMessage.value = 'Please sign up as a service provider';
//             return false;
//           }
//           // Check if profile is created
//           if (userData['isProfileCreated'] == false) {
//             Get.to(() => ProfileSetup());
//           } else if (userData['isVerified'] == false) {
//             Get.to(() => OTPScreen());
//           } else {
//             Get.offAll(() => EventBottomNavBar());
//           }

//           return true;
//         } else {
//           errorMessage.value = responseData['message'] ?? 'Login failed';
//           return false;
//         }
//       } else {
//         errorMessage.value = responseData['message'] ?? 'Login failed';

//         // Special case for email verification
//         if (responseData['message']?.contains('verification code') ?? false) {
//           Get.to(() => OTPScreen(), arguments: emailController.text.trim());
//         }

//         return false;
//       }
//     } on http.ClientException catch (e) {
//       errorMessage.value = 'Network error: ${e.message}';
//       debugPrint('Network error: ${e.message}');
//       return false;
//     } on TimeoutException {
//       errorMessage.value = 'Request timed out';
//       debugPrint('TimeoutException: Request timed out');
//       return false;
//     } on FormatException {
//       errorMessage.value = 'Invalid server response';
//       debugPrint('FormatException: Invalid server response');
//       return false;
//     } catch (e) {
//       errorMessage.value = 'An unexpected error occurred';
//       debugPrint('Unexpected error: $e');
//       return false;
//     } finally {
//       isLoading.value = false;
//       debugPrint('Loading finished');
//     }
//   }

//   @override
//   void onClose() {
//     emailController.dispose();
//     passwordController.dispose();

//     super.onClose();
//   }
// }

import 'dart:async';
import 'dart:convert';

import 'package:blinqo/core/urls/endpoint.dart';
import 'package:blinqo/features/role/event_planner/auth/screen/otp_screen.dart';
import 'package:blinqo/features/role/event_planner/bottom_nav_bar/screen/event_bottom_nav_bar.dart';
import 'package:blinqo/features/role/event_planner/profile_setup/screens/profile_setup.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends GetxController {
  LoginController({String? token}) {
    _token = token;
  }

  String? _token;
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  final isLoading = false.obs;
  final errorMessage = ''.obs;
  final isPasswordVisible = false.obs;
  final isFormValid = false.obs;

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  void validateForm() {
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    isFormValid.value =
        emailController.text.isNotEmpty &&
        emailRegex.hasMatch(emailController.text) &&
        passwordController.text.isNotEmpty &&
        passwordController.text.length >= 8;
  }

  Future<bool> login(BuildContext context) async {
    isLoading.value = true;
    errorMessage.value = '';

    try {
      debugPrint("Starting login process...");
      debugPrint("Token: $_token"); // Print the token

      final response = await http
          .post(
            Uri.parse(Urls.login),
            headers: {
              'Content-Type': 'application/json',
              if (_token != null && _token!.isNotEmpty)
                'Authorization': 'Bearer $_token',
            },
            body: jsonEncode({
              'email': emailController.text.trim(),
              'password': passwordController.text.trim(),
            }),
          )
          .timeout(const Duration(seconds: 30));

      debugPrint("Response Status Code: ${response.statusCode}");
      debugPrint("Response Body: ${response.body}");

      final responseData = jsonDecode(response.body);
      debugPrint("Response Data: $responseData");

      if (response.statusCode == 200 || response.statusCode == 201) {
        if (responseData['success'] == true &&
            responseData['message'] == 'Login Successful') {
          final userData = responseData['data']['user'];
          final roles = List<String>.from(userData['roles'] ?? []);
          debugPrint("User Roles: $roles");

          if (!roles.contains('PLANNER')) {
            errorMessage.value = 'Please sign up as a service provider';
            return false;
          }

          if (userData['isProfileCreated'] == false) {
            debugPrint("Profile not created. Redirecting to Profile Setup.");
            Get.offAll(() => ProfileSetup());
          } else if (userData['isVerified'] == false) {
            debugPrint("User is not verified. Redirecting to OTP screen.");
            Get.offAll(() => OTPScreen());
          } else {
            debugPrint(
              "Login successful. Redirecting to Event Bottom Nav Bar.",
            );
            Get.offAll(() => EventBottomNavBar());
          }

          // Save the access token to SharedPreferences
          String accessToken =
              responseData['data']['access_token']; // Assuming the token is in 'data' -> 'access_token'
          String id =
              responseData['data']['id'];
          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setString('access_token', accessToken); // Store the token
          await prefs.setString('id', id); // Store the token

          // Debug print to confirm token is stored
          String? storedToken = prefs.getString('access_token');
          debugPrint(
            "Stored Access Token: $storedToken",
          ); // Print the stored token

          return true;
        }
      }

      errorMessage.value = responseData['message'] ?? 'Login failed';

      if (responseData['message']?.contains('verification code') ?? false) {
        debugPrint("Verification code needed. Redirecting to OTP screen.");
        Get.to(() => OTPScreen(), arguments: emailController.text.trim());
      }

      return false;
    } catch (e) {
      debugPrint("Error occurred: $e");
      errorMessage.value = 'An error occurred during login';
      return false;
    } finally {
      isLoading.value = false;
      debugPrint("Login process completed.");
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
