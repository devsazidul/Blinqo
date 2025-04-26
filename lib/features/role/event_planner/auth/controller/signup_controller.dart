import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class SignUpController extends GetxController {
  // Declare the controllers for text fields
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController1 = TextEditingController();
  TextEditingController emailController1 = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController retypepasswordController = TextEditingController();
  // TextEditingController pinController = TextEditingController();

  var isPasswordVisible = false.obs;
  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  var isPasswordVisible1 = false.obs;
  void togglePasswordVisibility1() {
    isPasswordVisible1.value = !isPasswordVisible1.value;
  }

  var isFromValid = false.obs;
  void validateFrom() {
    isFromValid.value =
        nameController.text.isNotEmpty &&
        phoneController1.text.isNotEmpty &&
        emailController1.text.isNotEmpty &&
        passwordController.text.isNotEmpty &&
        retypepasswordController.text.isNotEmpty;
  }

  // var isFormValid2 = false.obs;
  // void validdateForm2() {
  //   isFormValid2.value = pinController.text.length == 6;
  // }

  @override
  // ignore: unnecessary_overrides
  void onClose() {
    super.onClose();
  }
  // Properly dispose of controllers when the controller is disposed
}
