import 'package:blinqo/core/urls/endpoint.dart';
import 'package:blinqo/features/role/service_provider/common/controller/auth_controller.dart';
import 'package:blinqo/features/role/service_provider/common/models/user_info_model.dart';
import 'package:blinqo/features/role/service_provider/services/sp_network_caller.dart';
import 'package:get/get.dart';

class SpGetUserInfoController extends GetxController {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  UserInfoModel? _userInfoModel;
  UserInfoModel? get userInfoModel => _userInfoModel;

  Future<void> getUserInfo() async {
    _isLoading = true;
    // bool isSuccess = false;

    final response = await Get.find<SpNetworkCaller>().getRequest(
      Urls.getUserInfo,
    );

    if (response.isSuccess) {
      _userInfoModel = UserInfoModel.fromJson(response.responseData);
      SpAuthController.saveUserInformation(userInfo: _userInfoModel);
      // isSuccess = true;
    }

    _isLoading = false;
    update();
  }
}
