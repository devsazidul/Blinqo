import 'dart:async';
import 'dart:io';
import 'package:blinqo/features/role/event_planner/auth/controller/login_controller.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// User Model
class User {
  final String email;
  final String password;
  final String name;
  final String phone;
  final List<String> roles;

  User({
    required this.email,
    required this.password,
    required this.name,
    required this.phone,
    required this.roles,
  });

  Map<String, dynamic> toJson() => {
    'email': email,
    'password': password,
    'name': name,
    'phone': phone,
    'roles': roles,
  };
}

class SignUpController extends GetxController {
  // Constants
  static const String apiUrl =
      'https://freepik.softvenceomega.com/auth/register';
  static const int minPasswordLength = 8;

  // Controllers
  final nameController = TextEditingController();
  final phoneController1 = TextEditingController();
  final emailController1 = TextEditingController();
  final passwordController = TextEditingController();
  final retypepasswordController = TextEditingController();

  // States
  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;
  final responseMessage = ''.obs;
  final isPasswordVisible = false.obs;
  final isPasswordVisible1 = false.obs;
  final isFormValid = false.obs;

  // Toggle methods
  void togglePasswordVisibility() => isPasswordVisible.toggle();
  void togglePasswordVisibility1() => isPasswordVisible1.toggle();

  // Form validation
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
        retypepasswordController.text.isNotEmpty &&
        passwordController.text == retypepasswordController.text;
  }

  // Sign-up API call with token handling
  Future<void> registerUser() async {
    _isLoading.value = true;
    responseMessage.value = '';

    try {
      final user = {
        'email': emailController1.text.trim(),
        'password': passwordController.text,
        'name': nameController.text.trim(),
        'phone': phoneController1.text.trim(),
        'roles': ['PLANNER'],
      };

      final response = await http
          .post(
            Uri.parse(apiUrl),
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode(user),
          )
          .timeout(const Duration(seconds: 30));

      final responseData = jsonDecode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        String token = jsonDecode(response.body)["data"]["access_token"];
        LoginController(token: token);
        print(token);
      } else {
        responseMessage.value = _parseError(responseData);
      }
    } on SocketException {
      responseMessage.value = 'No internet connection';
    } on TimeoutException {
      responseMessage.value = 'Request timed out';
    } on http.ClientException catch (e) {
      responseMessage.value = 'Network error: ${e.message}';
    } on FormatException {
      responseMessage.value = 'Invalid server response';
    } catch (e) {
      responseMessage.value = 'An unexpected error occurred';
      debugPrint('Registration error: $e');
    } finally {
      _isLoading.value = false;
    }
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
    retypepasswordController.dispose();
    super.onClose();
  }
}
