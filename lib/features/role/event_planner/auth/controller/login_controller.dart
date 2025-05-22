import 'dart:async';
import 'dart:convert';

import 'package:blinqo/core/urls/endpoint.dart';
import 'package:blinqo/features/role/event_planner/auth/auth_service/auth_service.dart';
import 'package:blinqo/features/role/event_planner/auth/screen/otp_screen.dart';
import 'package:blinqo/features/role/event_planner/home/controller/ep_home_screen_controller.dart';
import 'package:blinqo/features/role/event_planner/main_layout/screen/ep_main_layout_screen.dart';
import 'package:blinqo/features/role/event_planner/profile_setup/screens/profile_setup.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class LoginController extends GetxController {
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  final isLoading = false.obs;
  final errorMessage = ''.obs;
  final isPasswordVisible = false.obs;
  final isFormValid = false.obs;

  // Toggles password visibility
  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  // Validates form (email & password)
  void validateForm() {
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    isFormValid.value =
        emailController.text.isNotEmpty &&
        emailRegex.hasMatch(emailController.text) &&
        passwordController.text.isNotEmpty &&
        passwordController.text.length >= 8;

    debugPrint('Form valid: ${isFormValid.value}');
  }

  Future<bool> login(BuildContext context) async {
    isLoading.value = true;
    errorMessage.value = '';

    try {
      debugPrint("Starting login process...");

      final response = await http
          .post(
            Uri.parse(Urls.login),
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode({
              'email': emailController.text.trim(),
              'password': passwordController.text.trim(),
            }),
          )
          .timeout(const Duration(seconds: 30));

      debugPrint("Response Status Code: ${response.statusCode}");
      debugPrint("Response Body: ${response.body}");

      final responseData = jsonDecode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        if (responseData['success'] == true &&
            responseData['message'] == 'Login Successful') {
          final userData = responseData['data']['user'];
          final roles = List<String>.from(userData['roles'] ?? []);

          if (!roles.contains('PLANNER')) {
            errorMessage.value = 'Please sign up as a service provider';
            return false;
          }

          // Convert roles list to a comma-separated string
          String rolesString = roles.join(',');

          // Save auth data
          await AuthService.clearAuthData(); // Clear previous data first
          await AuthService.saveAuthData(
            responseData['data']['access_token'],

            responseData['data']['user']['id'] ??
                '', // Default to an empty string if null
            rolesString, // Save roles as a comma-separated string
            responseData['data']['user']['isProfileCreated'].toString(),
            responseData['data']['user']['profileId'] ?? '',
          );

          // Handle navigation based on user state
          if (userData['isProfileCreated'] == false) {
            Get.offAll(() => ProfileSetup());
          } else if (userData['isVerified'] == false) {
            Get.offAll(() => OTPScreen());
          } else {
            Get.offAll(() => EventPlannerMainLayoutScreen());
          }

          // Clear text fields after successful login
          emailController.clear();
          passwordController.clear();
          Get.find<EpHomeScreenController>().getHomeData;
          return true;
        }
      }

      errorMessage.value = responseData['message'] ?? 'Login failed';

      if (responseData['message']?.contains('verification code') ?? false) {
        Get.to(() => OTPScreen(), arguments: emailController.text.trim());
      }

      return false;
    } catch (e) {
      debugPrint("Login error: $e");
      errorMessage.value = 'An error occurred during login';
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

//==========================================================
