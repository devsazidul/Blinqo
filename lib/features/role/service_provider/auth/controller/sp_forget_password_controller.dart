import 'package:blinqo/core/models/network_response.dart';
import 'package:blinqo/core/services/network_caller.dart';
import 'package:blinqo/core/urls/endpoint.dart';
import 'package:blinqo/features/role/service_provider/auth/screen/forget_password_verify_otp_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class SpForgetPasswordController extends GetxController {
  String _errorMessage = "";
  String get errorMessage => _errorMessage;

  final formKey = GlobalKey<FormState>();
  TextEditingController pinController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  // Form validation flag
  var isFormValid2 = false.obs;

  void validdateForm2() {
    isFormValid2.value = pinController.text.length == 6;
  }

  Future<bool> forgetPasswordOtpSend() async {
    EasyLoading.show(status: "Loading...");
    bool isSuccess = false;

    final NetworkResponse response = await Get.find<NetworkCaller>()
        .postRequest(Urls.sendPasswordResetCode, {
          'email': emailController.text,
        });

    if (response.isSuccess) {
      isSuccess = true;
      EasyLoading.showSuccess("OTP sent successfully");
      Get.to(
        () => SpForgetPasswordVerifyOtpScreen(email: emailController.text),
      );
    } else {
      _errorMessage = response.errorMessage;
      EasyLoading.showError(_errorMessage);
    }

    return isSuccess;
  }

  @override
  void dispose() {
    pinController.dispose();
    emailController.dispose();
    phoneController.dispose();

    super.dispose();
  }
}
