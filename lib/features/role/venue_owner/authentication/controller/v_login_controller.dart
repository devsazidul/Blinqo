import 'package:blinqo/features/role/venue_owner/authentication/screen/singup_otp_screen.dart';
import 'package:blinqo/features/role/venue_owner/bottom_nav_bar/screen/vanueOwner_bottom_nav_bar.dart';
import 'package:blinqo/features/role/venue_owner/owern_network_caller/even_authcontroller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:blinqo/core/urls/endpoint.dart';
import 'package:blinqo/features/role/venue_owner/owern_network_caller/owner_network_caller.dart';
import 'package:logger/logger.dart';

class VenueLoginController extends GetxController {
  TextEditingController passwordControler = TextEditingController();
  TextEditingController emailController = TextEditingController();
  var isPasswordVisible = false.obs;
  var isFromValid = false.obs;
  var errorMessage = ''.obs;

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  void validateFrom() {
    isFromValid.value =
        emailController.text.isNotEmpty && passwordControler.text.isNotEmpty;
  }

  // Login API call
  Future<void> login() async {
    validateFrom();

    if (!isFromValid.value) {
      EasyLoading.showError('Please enter valid credentials');
      return;
    }

    final response = await OwnerNetworkCaller().postRequest(
      Url: Urls.login,
      body: {'email': emailController.text, 'password': passwordControler.text},
    );

    if (response.isSuccess) {
      // Save the authentication token after a successful login
      await EvenAuthController.saveAuthToken(
        response.body['data']['access_token'],
      );
      Logger().i(
        'Login successful token: ${response.body['data']['access_token']}',
      );

      EasyLoading.showSuccess('Login successful');
      Get.to(VanueOwnerBottomNavBar());
    } else {
      if (response.errorMessage ==
          "A verification code has been sent to your email. Please verify your email") {
        errorMessage.value =
            "Your account is not verified. Please verify your email.";
        EasyLoading.showError(errorMessage.value);
        Get.to(VerificationCodeScreen(email: emailController.text));
      } else {
        errorMessage.value = response.errorMessage ?? 'Login failed';
        EasyLoading.showError(errorMessage.value);
      }
    }
  }

  void clearFields() {
    emailController.clear();
    passwordControler.clear();
  }
}
