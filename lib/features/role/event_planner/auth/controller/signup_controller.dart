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
        // await AuthService.saveAuthData(
        //   responseData["data"]["access_token"],
        //   responseData["data"]["role"],
        //   responseData["data"]["isProfileCreated"],
        //   responseData["data"]["id"] ?? '',
        // );
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
