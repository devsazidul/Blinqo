import 'package:blinqo/core/urls/endpoint.dart';
import 'package:blinqo/features/role/service_provider/auth/model/login_model.dart';
import 'package:blinqo/features/role/service_provider/bottom_nav_bar/screen/sp_bottom_nav_bar.dart';
import 'package:blinqo/features/role/service_provider/common/controller/auth_controller.dart';
import 'package:blinqo/features/role/service_provider/common/controller/sp_get_user_info_controller.dart';
import 'package:blinqo/features/role/service_provider/profile_setup_page/controller/sp_profile_setup_controller.dart';
import 'package:blinqo/features/role/service_provider/profile_setup_page/screeen/sp_profile_setup_screen.dart';
import 'package:blinqo/features/role/service_provider/services/sp_network_caller.dart';
import 'package:blinqo/features/role/service_provider/services/sp_network_response.dart';
import 'package:blinqo/features/role/service_provider/sp_profile/controller/sp_get_all_works_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class SpLoginController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  bool _isLoading = false;
  // ignore: prefer_final_fields
  String _errorMessage = '';
  LoginModel? _loginModel;

  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;
  LoginModel? get loginModel => _loginModel;
  // form key

  var isPasswordVisible = true.obs;
  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  var isFormValid = false.obs;
  void validateForm() {
    isFormValid.value =
        emailController.text.isNotEmpty && passwordController.text.isNotEmpty;
  }

  //-------------------------- Login --------------------------
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
      //* Get login model from server
      LoginModel loginModel = LoginModel.fromJson(
        response.responseData['data'],
      );

      _loginModel = loginModel;

      if (loginModel.user?.roles.contains("SERVICE_PROVIDER") == true) {
        await SpAuthController.saveUserInformation(
          accessToken: loginModel.accessToken,
          spUser: SpAuthController.spUser?.copyWith(
            id: loginModel.user?.id,
            email: loginModel.user?.email,
            role: loginModel.user?.roles,
            isVerified: loginModel.user?.isVerified,
          ),
        );

        if (loginModel.user?.isProfileCreated == true) {
          //* Save user profile information into shared preferences
          await Get.put(SpGetUserInfoController()).spGetUserInfo();
          await Get.find<SpGetAllWorksController>().getAllWorks();
          EasyLoading.dismiss();
          Get.offAll(() => SpBottomNavBarScreen());
        } else {
          //* Get event preferences from server
          await Get.put(SpProfileSetupController()).getEventPreferences();
          EasyLoading.dismiss();
          Get.offAll(() => SpProfileSetupScreen());
        }
        isSuccess = true;
      } else {
        EasyLoading.dismiss();
        EasyLoading.showError(
          "Sorry, This email is not registered as a service provider",
        );
        isSuccess = false;
      }
    } else {
      EasyLoading.dismiss();
      EasyLoading.showError(response.errorMessage);
      isSuccess = false;
    }
    _isLoading = false;
    EasyLoading.dismiss();
    update();

    return isSuccess;
  }

  /// Get user information
  Future<void> getUserInformation() async {
    await SpAuthController.getUserInformation();
  }

  /// Check if user already logged in
  Future<bool> checkIfUserLoggedIn() async {
    return await SpAuthController.isLoggedIn();
  }

  void clearFields() {
    emailController.clear();
    passwordController.clear();
  }

  spLogin() {}
}
