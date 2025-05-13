import 'package:blinqo/core/urls/endpoint.dart';
import 'package:blinqo/features/role/service_provider/common/controller/auth_controller.dart';
import 'package:blinqo/features/role/service_provider/common/models/sp_user_model.dart';
import 'package:blinqo/features/role/service_provider/services/sp_network_caller.dart';
import 'package:blinqo/features/role/service_provider/services/sp_network_response.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SpGetUserInfoController extends GetxController {
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  // UserInfoModel? _userInfoModel;

  // UserInfoModel? get userInfoModel => _userInfoModel;
  // ProfileInfoModel? get profileInfoModel => _userInfoModel?.profile;

  //*----------------- Get user info -----------------
  Future<bool> spGetUserInfo() async {
    bool isSuccess = false;
    _isLoading = true;
    update();

    final SpNetworkResponse response = await Get.find<SpNetworkCaller>()
        .getRequest(Urls.getUserInfo);

    if (response.isSuccess) {
      //* Get user info from server
      SpUser spUser = SpUser.fromJson(response.responseData["data"]);
      await SpAuthController.saveUserInformation(spUser: spUser);

      //* Get profile info if available
      // if (response.responseData["data"]["profile"] != null) {
      //   ProfileInfoModel profileInfo = ProfileInfoModel.fromJson(
      //     response.responseData["data"]["profile"],
      //   );
      //   await SpAuthController.saveUserInformation(
      //     spUser: spUser,
      //     profileInfo: profileInfo,
      //   );
      // } else {
      //   await SpAuthController.saveUserInformation(spUser: spUser);
      // }

      isSuccess = true;
    } else {
      // show popup error
      Get.snackbar(
        'Error',
        response.errorMessage,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      isSuccess = false;
    }

    _isLoading = false;
    update();
    return isSuccess;
  }
}
