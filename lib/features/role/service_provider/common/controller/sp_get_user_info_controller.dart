import 'package:blinqo/core/urls/endpoint.dart';
import 'package:blinqo/features/role/service_provider/common/controller/auth_controller.dart';
import 'package:blinqo/features/role/service_provider/common/models/profile_info_model.dart';
import 'package:blinqo/features/role/service_provider/common/models/user_info_model.dart';
import 'package:blinqo/features/role/service_provider/services/sp_network_caller.dart';
import 'package:blinqo/features/role/service_provider/services/sp_network_response.dart';
import 'package:get/get.dart';

class SpGetUserInfoController extends GetxController {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  UserInfoModel? _userInfoModel;
  UserInfoModel? get userInfoModel => _userInfoModel;

  ProfileInfoModel? get profileInfoModel => _userInfoModel?.profile;

  Future<bool> getUserInfo() async {
    bool isSuccess = false;
    _isLoading = true;
    update();
    // bool isSuccess = false;

    final SpNetworkResponse response = await Get.find<SpNetworkCaller>()
        .getRequest(Urls.getUserInfo);

    if (response.isSuccess) {
      UserInfoModel userInfo = UserInfoModel.fromJson(
        response.responseData["data"],
      );
      _userInfoModel = userInfo;
      await SpAuthController.saveUserInformation(profileInfo: userInfo.profile);
      isSuccess = true;
    } else {
      isSuccess = false;
    }

    _isLoading = false;
    update();
    return isSuccess;
  }
}
