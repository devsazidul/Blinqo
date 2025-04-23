import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OTPController extends GetxController {
  // OTP related controllers
  TextEditingController pinController = TextEditingController();

  // Track OTP form validity
  var isFormValid = false.obs;

  // Validate if the OTP form is filled correctly
  void validateForm() {
    isFormValid.value = pinController.text.length == 6;
  }
}
