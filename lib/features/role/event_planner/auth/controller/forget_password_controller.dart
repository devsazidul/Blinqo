import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgetPasswordController extends GetxController {
  TextEditingController pinController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  // Form validation flag
  var isFormValid2 = false.obs;

  void validdateForm2() {
    isFormValid2.value = pinController.text.length == 6;
  }

  @override
  void onClose() {
    // Remove the duplicate pinController.dispose()
    pinController.dispose();
    emailController.dispose();
    phoneController.dispose();
    super.onClose();
    debugPrint("Pin Controller disposed");
  }
}
