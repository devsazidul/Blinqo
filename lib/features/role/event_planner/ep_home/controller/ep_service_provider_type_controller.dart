import 'package:blinqo/core/services/network_caller.dart';
import 'package:blinqo/core/urls/endpoint.dart';
import 'package:blinqo/features/role/event_planner/auth/auth_service/auth_service.dart';
import 'package:blinqo/core/common/models/sp_type_model.dart';
import 'package:get/get.dart';

class EpServiceProviderTypeController extends GetxController {
  bool _isLoading = false;
  String _errorMessage = '';
  final List<ServiceProviderTypeModel> _serviceTypes = [];

  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;
  List<ServiceProviderTypeModel> get serviceTypes => _serviceTypes;

  Future<bool> fetchAllServiceProviderTypes() async {
    _isLoading = true;
    bool isSuccess = false;

    final response = await Get.find<NetworkCaller>().getRequest(
      Urls.getServiceProviderTypes,
      accessToken: await AuthService.getToken(),
    );

    if (response.isSuccess) {
      final List<dynamic>? data = response.responseData["data"];
      if (data != null) {
        _serviceTypes.clear();
        _serviceTypes.addAll(
          data
              .map<ServiceProviderTypeModel>(
                (e) => ServiceProviderTypeModel.fromJson(e),
              )
              .toList(),
        );
      }

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
