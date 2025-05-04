import 'package:blinqo/core/urls/endpoint.dart';
import 'package:blinqo/features/role/service_provider/auth/screen/change_password_screen.dart';
import 'package:blinqo/features/role/service_provider/services/sp_network_caller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class SpForgetPasswordOtpVerifyController extends GetxController {
  String _errorMessage = '';
  String get errorMessage => _errorMessage;

  final formKey = GlobalKey<FormState>();
  TextEditingController pinController = TextEditingController();

  RxBool isFormValid = false.obs;

  void validateForm() {
    isFormValid.value = pinController.text.length == 6;
    update();
  }

  Future<bool> verifyOtp({required String email}) async {
    EasyLoading.show(status: "Verifying OTP....");
    bool isSuccess = false;
    update();

    Map<String, dynamic> requestBody = {
      "email": email,
      "code": pinController.text,
    };

    final response = await Get.find<SpNetworkCaller>().postRequest(
      Urls.verifyResetCode,
      requestBody,
    );

    if (response.isSuccess) {
      isSuccess = true;
      _errorMessage = '';
      Get.to(() => SpChangePasswordScreen(email: email));
      EasyLoading.showSuccess(response.responseData['message']);
    } else {
      isSuccess = false;
      _errorMessage = response.errorMessage;
      EasyLoading.showError(response.errorMessage);
    }
    EasyLoading.dismiss();
    update();
    return isSuccess;
  }

  @override
  void dispose() {
    pinController.dispose();
    super.dispose();
  }
}
