import 'package:blinqo/core/urls/endpoint.dart';
import 'package:blinqo/features/role/service_provider/auth/controller/auth_controller.dart';
import 'package:blinqo/features/role/service_provider/auth/model/auth_model.dart';
import 'package:blinqo/features/role/service_provider/auth/screen/sp_otp_send_screen.dart';
import 'package:blinqo/features/role/service_provider/services/sp_network_caller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class SpLoginController extends GetxController {
  bool _isLoading = false;
  String _errorMessage = '';

  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;

  // form key
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  var isPasswordVisible = true.obs;
  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  // Controller for the text field
  TextEditingController categoryController = TextEditingController();

  // Dummy userId for new category (replace with actual userId)
  // String userId = "user123";

  var isFromValid = false.obs;
  void validateFrom() {
    isFromValid.value =
        emailController.text.isNotEmpty && passwordController.text.isNotEmpty;
  }

  Future<bool> login() async {
    EasyLoading.show(status: 'Logging in...');
    bool isSuccess = false;
    _isLoading = true;
    update();

    Map<String, dynamic> requestBody = {
      'email': emailController.text.trim(),
      'password': passwordController.text.trim(),
    };

    final response = await Get.find<SpNetworkCaller>().postRequest(
      Urls.login,
      requestBody,
    );

    if (response.isSuccess) {
      AuthModel authModel = AuthModel.fromJson(response.responseData['data']);
      // if (!authModel.user.isVerified) {
      //   // Get.to(() => SpOtpSendScreen(email: authModel.user.email));
      //   EasyLoading.showSuccess('Please verify your email address');
      //   _errorMessage = 'Please verify your email address';
      //   // Get.to(SpOtpSendScreen(email: authModel.user.email));
      //   isSuccess = true;
      // } else
      if (!authModel.user.roles.contains('SERVICE_PROVIDER')) {
        EasyLoading.showError('You are not a service provider user');
        _errorMessage = 'Please sign up as a service provider';
        return false;
      } else {
        await SpAuthController.saveUserInformation(
          authModel.accessToken,
          authModel.user,
        );
        isSuccess = true;
        EasyLoading.showSuccess(response.responseData['message']);
      }
    } else {
      if (response.errorMessage ==
          "A verification code has been sent to your email. Please verify your email") {
        Get.to(() => SpOtpSendScreen(email: emailController.text.trim()));
        _errorMessage = response.errorMessage;
        EasyLoading.showSuccess(response.errorMessage);
        isSuccess = false;
      } else {
        isSuccess = false;
        _errorMessage = response.errorMessage;
        EasyLoading.showError(response.errorMessage);
      }
    }
    _isLoading = false;
    update();
    return isSuccess;
  }

  /// Get user information
  Future<void> getUserInformation() async {
    await SpAuthController.getUserInformation();
  }

  /// Check if user already logged in
  Future<bool> checkIfUserLoggedIn() async {
    return await SpAuthController.checkIfUserLoggedIn();
  }

  void clearFields() {
    emailController.clear();
    passwordController.clear();
  }
}
