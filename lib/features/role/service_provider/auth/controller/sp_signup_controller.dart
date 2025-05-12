// ignore_for_file: prefer_final_fields

import 'package:blinqo/core/urls/endpoint.dart';
import 'package:blinqo/features/role/service_provider/auth/screen/sp_confirm_email_verify_otp_screen.dart';
import 'package:blinqo/features/role/service_provider/services/sp_network_caller.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class SpSignupController extends GetxController {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController1 = TextEditingController();
  TextEditingController emailController1 = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController retypePasswordController = TextEditingController();

  bool _isLoading = false;

  String _errorMessage = '';
  bool _isSuccess = false;

  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;
  bool get isSuccess => _isSuccess;

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
    if (formKey.currentState?.validate() ?? false) {
      isFromValid.value = true;
    } else {
      isFromValid.value = false;
    }
    update();
    debugPrint("isFromValid: $isFromValid");
  }

  Future<bool> signUp() async {
    EasyLoading.show(status: "Signing up....");
    _isLoading = true;
    bool isSuccess = false;
    update();

    // request body
    Map<String, dynamic> requestBody = {
      "email": emailController1.text.trim(),
      "password": passwordController.text.trim(),
      "name": nameController.text.trim(),
      "phone": phoneController1.text.trim(),
      "roles": ["SERVICE_PROVIDER"], // Replace this with a valid role
    };

    final response = await Get.find<SpNetworkCaller>().postRequest(
      Urls.register,
      requestBody,
    );

    if (response.isSuccess) {
      EasyLoading.showSuccess(response.responseData["message"]);
      Get.to(SpConfirmEmailVerifyOtpScreen(email: emailController1.text));
      isSuccess = true;
    } else {
      EasyLoading.showError(response.errorMessage);
      isSuccess = false;
    }
    _isLoading = false;
    update();
    return isSuccess;
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
