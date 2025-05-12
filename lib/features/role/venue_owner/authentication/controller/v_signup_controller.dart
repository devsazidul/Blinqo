import 'dart:async';

import 'package:blinqo/features/role/venue_owner/authentication/screen/singup_otp_screen.dart'
    // ignore: library_prefixes
    as singupOtp;
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:blinqo/core/urls/endpoint.dart';
import 'package:blinqo/features/role/venue_owner/owern_network_caller/owner_network_caller.dart';

class VSignupController extends GetxController {
  // Text field controllers
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController1 = TextEditingController();
  final TextEditingController emailController1 = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController retypepasswordController =
      TextEditingController();

  // State variables
  var isPasswordVisible = false.obs;
  var isPasswordVisible1 = false.obs;
  var isFormValid = false.obs;
  var errorMessage = ''.obs;
  var fieldErrors = <String, String?>{}.obs;

  @override
  void onInit() {
    // Add listeners to trigger validation on text changes
    nameController.addListener(validateForm);
    phoneController1.addListener(validateForm);
    emailController1.addListener(validateForm);
    passwordController.addListener(validateForm);
    retypepasswordController.addListener(validateForm);
    super.onInit();
  }

  @override
  void onClose() {
    // Dispose controllers
    nameController.dispose();
    phoneController1.dispose();
    // emailController1.dispose();
    passwordController.dispose();
    retypepasswordController.dispose();
    super.onClose();
  }

  // Toggle password visibility
  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  void togglePasswordVisibility1() {
    isPasswordVisible1.value = !isPasswordVisible1.value;
  }

  // Validate form fields
  String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      fieldErrors['name'] = 'Enter Your Name';
      return 'Enter Your Name';
    }
    fieldErrors['name'] = null;
    return null;
  }

  String? validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      fieldErrors['phone'] = 'Enter Phone Number e.g:+8801234567891';
      return 'Enter Phone Number e.g:+8801234567891';
    }
    RegExp phoneRegex = RegExp(r'^\+8801[3-9][0-9]{8}$');
    if (!phoneRegex.hasMatch(value)) {
      fieldErrors['phone'] = 'Invalid phone number format. Use +8801XXXXXXXXX';
      return 'Invalid phone number format. Use +8801XXXXXXXXX';
    }
    fieldErrors['phone'] = null;
    return null;
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      fieldErrors['email'] = 'Enter a valid email address';
      return 'Enter a valid email address';
    }
    RegExp emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    if (!emailRegex.hasMatch(value)) {
      fieldErrors['email'] = 'Invalid email format. Example: example@mail.com';
      return 'Invalid email format. Example: example@mail.com';
    }
    fieldErrors['email'] = null;
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      fieldErrors['password'] = 'Password is required';
      return 'Password is required';
    }
    if (value.length < 8) {
      fieldErrors['password'] = 'Password must be at least 8 characters';
      return 'Password must be at least 8 characters';
    }
    fieldErrors['password'] = null;
    return null;
  }

  String? validateRetypePassword(String? value) {
    if (value == null || value.isEmpty) {
      fieldErrors['retypePassword'] = 'Please confirm your password';
      return 'Please confirm your password';
    }
    if (value != passwordController.text) {
      fieldErrors['retypePassword'] = 'Passwords do not match';
      return 'Passwords do not match';
    }
    fieldErrors['retypePassword'] = null;
    return null;
  }

  // Check if form is valid and update error message
  void validateForm() {
    isFormValid.value =
        validateName(nameController.text) == null &&
        validatePhone(phoneController1.text) == null &&
        validateEmail(emailController1.text) == null &&
        validatePassword(passwordController.text) == null &&
        validateRetypePassword(retypepasswordController.text) == null;

    // Update error message based on first invalid field
    errorMessage.value =
        fieldErrors.values.firstWhere(
          (error) => error != null,
          orElse: () => '',
        ) ??
        '';
  }

  // Handle signup API call
  Future<void> signup() async {
    // Validate all fields before proceeding
    validateForm();
    if (!isFormValid.value) {
      EasyLoading.showError(
        errorMessage.value.isNotEmpty
            ? errorMessage.value
            : 'Please fill all fields correctly',
      );
      return;
    }

    final response = await OwnerNetworkCaller().postRequest(
      Url: Urls.register,
      body: {
        'name': nameController.text,
        'phone': phoneController1.text,
        'email': emailController1.text,
        'password': passwordController.text,
        'roles': ['VENUE_OWNER'],
      },
    );

    if (response.isSuccess) {
      EasyLoading.showSuccess('Verification code sent to your email');
      Get.to(
        () => singupOtp.VerificationCodeScreen(email: emailController1.text),
      );
    } else {
      errorMessage.value = response.errorMessage ?? 'Registration failed';
      EasyLoading.showError(errorMessage.value);
    }
  }
}
