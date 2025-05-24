// create a controller to get all venues
// don't use obx
// use network call to get all venues
// use ep_venues_response_model to get the data
// use getx to manage the state
// use getx to manage the network call
// use getx to manage the state

import 'package:blinqo/core/services/network_caller.dart';
import 'package:blinqo/core/urls/endpoint.dart';
import 'package:blinqo/features/role/event_planner/auth/auth_service/auth_service.dart';
import 'package:blinqo/features/role/event_planner/ep_home/model/ep_venues_response_model.dart';
import 'package:get/get.dart';

class EpGetAllVenuesController extends GetxController {
  bool _isLoading = false;
  String _errorMessage = '';
  EpVenuesResponseModel? _homeResponseData;

  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;
  EpVenuesResponseModel? get homeResponseData => _homeResponseData;

  // @override
  // void onInit() async {
  //   super.onInit();
  //   await getAllVenues();
  // }

  Future<bool> getAllVenues() async {
    _isLoading = true;
    update();

    bool isSuccess = false;
    _homeResponseData = null;

    final response = await Get.find<NetworkCaller>().getRequest(
      Urls.getEventPlannerHomeData,
      accessToken: await AuthService.getToken(),
    );

    if (response.isSuccess) {
      _homeResponseData = EpVenuesResponseModel.fromJson(response.responseData);
      isSuccess = true;
    } else {
      _errorMessage = response.errorMessage;
      isSuccess = false;
    }

    _isLoading = false;
    update();
    return isSuccess;
  }
}
