import 'package:blinqo/core/urls/endpoint.dart';
import 'package:blinqo/features/role/service_provider/services/sp_network_caller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class SpOtpVerificationController extends GetxController {
  Rx<TextEditingController> pinController = TextEditingController().obs;
  bool _isLoading = false;
  String _errorMessage = '';
  bool _isSuccess = false;

  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;
  bool get isSuccess => _isSuccess;

  var isValidate = false.obs;

  void validateOtpLength() {
    isValidate.value = pinController.value.text.length == 6;
    update();
  }

  Future<bool> verifyOtp(String email) async {
    EasyLoading.show(status: "Verifying OTP....");
    _isLoading = true;
    update();

    Map<String, dynamic> requestBody = {
      "identifier": email,
      "code": pinController.value.text,
    };

    final response = await Get.find<SpNetworkCaller>().postRequest(
      Urls.otpVerification,
      requestBody,
    );

    if (response.isSuccess) {
      _isSuccess = true;
      _errorMessage = '';

      EasyLoading.showSuccess(response.responseData['message']);
    } else {
      _isSuccess = false;
      _errorMessage = response.errorMessage;
      EasyLoading.showError(response.errorMessage);
    }
    EasyLoading.dismiss();
    _isLoading = false;
    update();
    return _isSuccess;
  }
}
