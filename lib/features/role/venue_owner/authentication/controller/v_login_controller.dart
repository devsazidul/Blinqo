import 'package:blinqo/features/role/venue_owner/authentication/model/login_model.dart';
import 'package:blinqo/features/role/venue_owner/authentication/screen/singup_otp_screen.dart';
import 'package:blinqo/features/role/venue_owner/bottom_nav_bar/screen/vanueOwner_bottom_nav_bar.dart';
import 'package:blinqo/features/role/venue_owner/owern_network_caller/even_authcontroller.dart';
import 'package:blinqo/features/role/venue_owner/profile_page/screen/v_profile_setup_screen.dart';
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
      // Parse the login response into the LoginResponse model
      LoginResponse loginResponse = LoginResponse.fromJson(response.body);

      // Check the role before proceeding with login
      if (loginResponse.success == true &&
          loginResponse.data?.user?.roles?.contains('VENUE_OWNER') == true) {
        // Save the authentication token after a successful login
        String token = response.body['data']?['access_token'];
        var roles = response.body['data']?['user']?['roles'];
        EventUser user = EventUser.fromJson(response.body['data']['user']);

        // ignore: unnecessary_null_comparison
        if (token != null && roles != null && roles.isNotEmpty) {
          String role = roles[0];
          await EventAuthController.saveAuthToken(token, role, user);
          Logger().i('user info: ${user.toJson()}');
        } else {
          // Handle error if token or roles are null or empty
          EasyLoading.showError('Failed to retrieve valid token or role.');
          return;
        }
        Logger().i(
          'Login successful token: ${loginResponse.data?.accessToken}',
        );
        if (user.isProfileCreated == false) {
          EasyLoading.showSuccess('Login successful');
          Get.to(VenueProfileScreen());
        } else {
          EasyLoading.showSuccess('Login successful');
          Get.to(VanueOwnerBottomNavBar());
        }
      } else {
        // If role doesn't match, show error
        errorMessage.value = 'Unauthorized: Incorrect role';
        EasyLoading.showError(errorMessage.value);
      }
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
