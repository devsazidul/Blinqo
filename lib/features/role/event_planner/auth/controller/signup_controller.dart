// import 'dart:async';
// import 'package:blinqo/core/urls/endpoint.dart';
// import 'package:blinqo/features/role/event_planner/auth/controller/login_controller.dart';
// import 'package:blinqo/features/role/event_planner/auth/screen/otp_screen.dart';
// import 'package:flutter/widgets.dart';
// import 'package:flutter_easyloading/flutter_easyloading.dart';
// import 'package:get/get.dart';

// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

// import 'package:shared_preferences/shared_preferences.dart';

// // User Model
// class User {
//   final String email;
//   final String password;
//   final String name;
//   final String phone;
//   final List<String> roles;

//   User({
//     required this.email,
//     required this.password,
//     required this.name,
//     required this.phone,
//     required this.roles,
//   });

//   Map<String, dynamic> toJson() => {
//     'email': email,
//     'password': password,
//     'name': name,
//     'phone': phone,
//     'roles': roles,
//   };
// }

// class SignUpController extends GetxController {
//   // Constants
//   static const int minPasswordLength = 8;

//   // Controllers
//   final nameController = TextEditingController();
//   final phoneController1 = TextEditingController();
//   final emailController1 = TextEditingController();
//   final passwordController = TextEditingController();
//   final retypepasswordController = TextEditingController();

//   // States
//   final _isLoading = false.obs;
//   bool get isLoading => _isLoading.value;
//   final responseMessage = ''.obs;
//   final isPasswordVisible = false.obs;
//   final isPasswordVisible1 = false.obs;
//   final isFormValid = false.obs;

//   // Toggle methods
//   void togglePasswordVisibility() => isPasswordVisible.toggle();
//   void togglePasswordVisibility1() => isPasswordVisible1.toggle();

//   // Form validation
//   void validateForm() {
//     final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
//     final phoneRegex = RegExp(r'^[+]*[(]{0,1}[0-9]{1,4}[)]{0,1}[-\s\./0-9]*$');

//     isFormValid.value =
//         nameController.text.trim().isNotEmpty &&
//         nameController.text.trim().length >= 2 &&
//         phoneController1.text.trim().isNotEmpty &&
//         phoneRegex.hasMatch(phoneController1.text.trim()) &&
//         emailController1.text.trim().isNotEmpty &&
//         emailRegex.hasMatch(emailController1.text.trim()) &&
//         passwordController.text.isNotEmpty &&
//         passwordController.text.length >= minPasswordLength &&
//         retypepasswordController.text.isNotEmpty &&
//         passwordController.text == retypepasswordController.text;
//   }

//   // Sign-up API call with token handling
//   Future<void> registerUser() async {
//     debugPrint('Starting registerUser...');

//     // Show loading indicator
//     debugPrint('Setting _isLoading to true');
//     _isLoading.value = true;

//     // Clear any previous messages
//     debugPrint('Clearing responseMessage');
//     responseMessage.value = '';

//     // Show the loading screen
//     debugPrint('Showing EasyLoading with status: creating Profile...');
//     EasyLoading.show(status: 'Creating Profile...');

//     try {
//       // Prepare user data
//       debugPrint('Creating user map');
//       final user = {
//         'email': emailController1.text.trim(),
//         'password': passwordController.text,
//         'name': nameController.text.trim(),
//         'phone': phoneController1.text.trim(),
//         'roles': ['PLANNER'],
//       };
//       debugPrint('User map created: $user');

//       // Send HTTP POST request to register the user
//       debugPrint('Making HTTP POST request to ${Urls.register}');
//       final response = await http.post(
//         Uri.parse(Urls.register),
//         headers: {'Content-Type': 'application/json'},
//         body: jsonEncode(user),
//       );

//       debugPrint(
//         'HTTP response received with status code: ${response.statusCode}',
//       );
//       debugPrint('Response body: ${response.body}');

//       // Decode the response body
//       debugPrint('Decoding response body');
//       final responseData = jsonDecode(response.body);
//       debugPrint('Decoded response data: $responseData');

//       // Check the status code for success
//       if (response.statusCode == 200 || response.statusCode == 201) {
//         debugPrint('Success response (200 or 201), extracting access_token');
//         String accessToken = responseData["data"]["access_token"];
//         debugPrint('Access token: $accessToken');

//         // Get SharedPreferences instance to save the token
//         debugPrint('Getting SharedPreferences instance');
//         final prefs = await SharedPreferences.getInstance();

//         // Save the new token in SharedPreferences, this will overwrite the old one
//         debugPrint('Saving token to SharedPreferences');
//         await prefs.setString('access_token', accessToken);
//         debugPrint('Token saved to SharedPreferences');

//         // Navigate to OTP screen with the email argument
//         debugPrint(
//           'Navigating to OTPScreen with email: ${emailController1.text}',
//         );
//         Get.to(() => OTPScreen(), arguments: emailController1.text);
//       } else {
//         debugPrint('Non-success response, parsing error');
//         responseMessage.value = _parseError(responseData);
//         debugPrint('Error message set: ${responseMessage.value}');
//       }
//     } catch (e) {
//       // Catch any exceptions during the process
//       debugPrint('Exception caught: $e');
//       responseMessage.value = 'An unexpected error occurred';
//       debugPrint('Error message set: ${responseMessage.value}');
//     } finally {
//       // Final block to handle cleanup
//       debugPrint('Entering finally block');
//       debugPrint('Setting _isLoading to false');
//       _isLoading.value = false;

//       // Dismiss the EasyLoading screen
//       debugPrint('Dismissing EasyLoading');
//       EasyLoading.dismiss();
//       debugPrint('registerUser completed');
//     }
//   }

//   String _parseError(dynamic data) {
//     try {
//       if (data is Map) {
//         if (data['error'] != null) return data['error'].toString();
//         if (data['message'] != null) return data['message'].toString();
//         if (data['errors'] != null) {
//           return data['errors'].values.first.join('\n');
//         }
//       }
//       return 'Registration failed. Please try again.';
//     } catch (e) {
//       return 'Registration failed. Please try again.';
//     }
//   }

//   @override
//   void onClose() {
//     nameController.dispose();
//     phoneController1.dispose();
//     emailController1.dispose();
//     passwordController.dispose();
//     retypepasswordController.dispose();
//     super.onClose();
//   }
// }

import 'dart:async';
import 'dart:convert';
import 'package:blinqo/core/urls/endpoint.dart';
import 'package:blinqo/features/role/event_planner/auth/auth_service/auth_service.dart';
import 'package:blinqo/features/role/event_planner/auth/screen/otp_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class SignUpController extends GetxController {
  static const int minPasswordLength = 8;

  final nameController = TextEditingController();
  final phoneController1 = TextEditingController();
  final emailController1 = TextEditingController();
  final passwordController = TextEditingController();
  final retypePasswordController = TextEditingController();

  final isLoading = false.obs;
  final responseMessage = ''.obs;
  final isPasswordVisible = false.obs;
  final isConfirmPasswordVisible = false.obs;
  final isFormValid = false.obs;
  final isPasswordVisible1 = false.obs;

  void togglePasswordVisibility1() => isPasswordVisible1.toggle();

  void togglePasswordVisibility() => isPasswordVisible.toggle();
  void toggleConfirmPasswordVisibility() => isConfirmPasswordVisible.toggle();

  void validateForm() {
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    final phoneRegex = RegExp(r'^[+]*[(]{0,1}[0-9]{1,4}[)]{0,1}[-\s\./0-9]*$');

    isFormValid.value =
        nameController.text.trim().isNotEmpty &&
        nameController.text.trim().length >= 2 &&
        phoneController1.text.trim().isNotEmpty &&
        phoneRegex.hasMatch(phoneController1.text.trim()) &&
        emailController1.text.trim().isNotEmpty &&
        emailRegex.hasMatch(emailController1.text.trim()) &&
        passwordController.text.isNotEmpty &&
        passwordController.text.length >= minPasswordLength &&
        retypePasswordController.text.isNotEmpty &&
        passwordController.text == retypePasswordController.text;
  }

  Future<void> registerUser() async {
    debugPrint('Starting registerUser function');
    isLoading.value = true;
    debugPrint('Set isLoading to true');
    responseMessage.value = '';
    debugPrint('Cleared responseMessage');

    try {
      debugPrint('Entering try block');
      final user = {
        'email': emailController1.text.trim(),
        'password': passwordController.text,
        'name': nameController.text.trim(),
        'phone': phoneController1.text.trim(),
        'roles': ['PLANNER'],
      };
      debugPrint('User data prepared: ${jsonEncode(user)}');

      debugPrint('Sending HTTP POST request to ${Urls.register}');
      final response = await http.post(
        Uri.parse(Urls.register),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(user),
      );
      debugPrint('Received response with status code: ${response.statusCode}');

      final responseData = jsonDecode(response.body);
      debugPrint('Response data: $responseData');

      if (response.statusCode == 200 || response.statusCode == 201) {
        debugPrint('Successful response received');

        debugPrint('Clearing existing auth data');
        await AuthService.clearAuthData();

        debugPrint('Saving new auth data');
        await AuthService.saveAuthData(
          responseData["data"]["access_token"],
          responseData["data"]["id"] ?? '',
        );
        debugPrint('Auth data saved successfully');

        debugPrint(
          'Navigating to OTPScreen with email: ${emailController1.text}',
        );
        Get.to(() => OTPScreen(), arguments: emailController1.text);
      } else {
        debugPrint('Error response received');
        responseMessage.value = _parseError(responseData);
        debugPrint('Error message set: ${responseMessage.value}');
      }
    } catch (e) {
      debugPrint('Caught error: $e');
      responseMessage.value = 'An unexpected error occurred';
      debugPrint('Error message set: ${responseMessage.value}');
    } finally {
      isLoading.value = false;
      debugPrint('Set isLoading to false in finally block');
    }
    debugPrint('registerUser function completed');
  }

  String _parseError(dynamic data) {
    try {
      if (data is Map) {
        if (data['error'] != null) return data['error'].toString();
        if (data['message'] != null) return data['message'].toString();
        if (data['errors'] != null) {
          return data['errors'].values.first.join('\n');
        }
      }
      return 'Registration failed. Please try again.';
    } catch (e) {
      return 'Registration failed. Please try again.';
    }
  }

  @override
  void onClose() {
    nameController.dispose();
    phoneController1.dispose();
    emailController1.dispose();
    passwordController.dispose();
    retypePasswordController.dispose();
    super.onClose();
  }
}
