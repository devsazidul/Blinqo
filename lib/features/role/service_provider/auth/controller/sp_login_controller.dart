import 'package:blinqo/core/urls/endpoint.dart';
import 'package:blinqo/features/role/service_provider/auth/model/auth_data_model.dart';
import 'package:blinqo/features/role/service_provider/auth/screen/sp_confirm_email_verify_otp_screen.dart';
import 'package:blinqo/features/role/service_provider/bottom_nav_bar/screen/sp_bottom_nav_bar.dart';
import 'package:blinqo/features/role/service_provider/common/controller/auth_controller.dart';
import 'package:blinqo/features/role/service_provider/common/controller/sp_get_user_info_controller.dart';
import 'package:blinqo/features/role/service_provider/profile_setup_page/controller/sp_profile_setup_controller.dart';
import 'package:blinqo/features/role/service_provider/profile_setup_page/screeen/sp_profile_setup_screen.dart';
import 'package:blinqo/features/role/service_provider/services/sp_network_caller.dart';
import 'package:blinqo/features/role/service_provider/services/sp_network_response.dart';
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

    final SpNetworkResponse response = await Get.find<SpNetworkCaller>()
        .postRequest(Urls.login, requestBody);

    if (response.isSuccess) {
      AuthDataModel authModel = AuthDataModel.fromJson(
        response.responseData['data'],
      );

      print('Login successful, access token: ${authModel.accessToken}');

      //* check if user role is "SERVICE_PROVIDER" then check if user profile is created or not
      //* if profile is not created then show profile setup screen
      // * if profile is created then show bottom navigation bar screen
      if (authModel.user?.roles?.contains("SERVICE_PROVIDER") == true) {
        await SpAuthController.saveUserInformation(
          accessToken: authModel.accessToken,
          user: authModel.user,
        );
        print('Token saved, current token: ${SpAuthController.token}');

        if (authModel.user?.isProfileCreated == true) {
          //* Save user profile information into shared preferences
          await Get.put(SpGetUserInfoController()).getUserInfo();
          Get.offAll(() => SpBottomNavBarScreen());
        } else {
          //* Get event preferences from server
          await Get.put(SpProfileSetupController()).getEventPreferences();

          Get.offAll(() => SpProfileSetupScreen());
        }
      } else {
        EasyLoading.dismiss();
        EasyLoading.showError(
          "Sorry, This email is not registered as a service provider",
        );
        isSuccess = false;
      }

      // if (!authModel.user!.roles!.contains('SERVICE_PROVIDER')) {
      //   EasyLoading.dismiss();
      //   bool? wantToBeServiceProvider = await Get.dialog<bool>(
      //     AlertDialog(
      //       title: const Text(
      //         'You are not a service provider user!',
      //         textAlign: TextAlign.center,
      //       ),
      //       titleTextStyle: const TextStyle(
      //         fontSize: 18,
      //         fontWeight: FontWeight.bold,
      //         color: Colors.red,
      //       ),
      //       content: const Text(
      //         'Do you want to create a profile as a service provider?',
      //       ),
      //       contentTextStyle: const TextStyle(
      //         fontSize: 16,
      //         color: Colors.black,
      //       ),
      //       actions: [
      //         TextButton(
      //           onPressed: () => Get.back(result: false),
      //           style: TextButton.styleFrom(
      //             backgroundColor: Colors.red,
      //             foregroundColor: Colors.white,
      //           ),
      //           child: const Text('No'),
      //         ),
      //         TextButton(
      //           onPressed: () => Get.back(result: true),
      //           style: TextButton.styleFrom(
      //             backgroundColor: Colors.green,
      //             foregroundColor: Colors.white,
      //           ),
      //           child: const Text('Yes'),
      //         ),
      //       ],
      //     ),
      //   );
      //   if (wantToBeServiceProvider == true) {
      //     // final response = await Get.find<SpNetworkCaller>().patchRequest(
      //     //   '${Urls.baseUrl}/auth/update-role',
      //     //   {'userId': authModel.user.id, 'role': 'SERVICE_PROVIDER'},
      //     // );

      //     // if (response.isSuccess) {
      //     //   await SpAuthController.saveUserInformation(
      //     //     accessToken: authModel.accessToken,
      //     //     user: authModel.user,
      //     //   );
      //     if (SpAuthController.userModel?.isProfileCreated == true) {
      //       Get.offAll(() => SpBottomNavBarScreen());
      //     } else {
      //       Get.offAll(() => const SpProfileSetupScreen());
      //     }
      //     //   return true;
      //     // } else {
      //     //   EasyLoading.showError(response.errorMessage);
      //     //   return false;
      //     // }
      //   }
      // } else {
      //   await SpAuthController.saveUserInformation(
      //     accessToken: authModel.accessToken,
      //     user: authModel.user,
      //   );
      //   await Get.find<SpGetUserInfoController>().getUserInfo();
      //   isSuccess = true;
      //   EasyLoading.showSuccess(response.responseData['message']);
      // }
    } else {
      if (response.errorMessage ==
          "A verification code has been sent to your email. Please verify your email") {
        Get.to(
          () =>
              SpConfirmEmailVerifyOtpScreen(email: emailController.text.trim()),
        );
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
    return await SpAuthController.isUserLoggedIn();
  }

  void clearFields() {
    emailController.clear();
    passwordController.clear();
  }
}
