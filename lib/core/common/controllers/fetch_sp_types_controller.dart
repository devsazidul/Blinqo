import 'package:blinqo/core/common/models/sp_type_model.dart';
import 'package:blinqo/core/services/network_caller.dart';
import 'package:blinqo/core/urls/endpoint.dart';
import 'package:blinqo/features/role/event_planner/auth/auth_service/auth_service.dart';
import 'package:blinqo/features/role/service_provider/common/controller/auth_controller.dart';
import 'package:get/get.dart';

class ServiceProviderTypesController extends GetxController {
  bool _isLoading = false;
  String _errorMessage = '';
  List<ServiceProviderTypeModel> _types = [];

  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;
  List<ServiceProviderTypeModel> get types => _types;

  // @override
  // void onInit() {
  //   fetchServiceProviderTypes();
  //   super.onInit();
  // }

  Future<bool> fetchServiceProviderTypes() async {
    _isLoading = true;
    bool isSuccess = false;
    update();

    try {
      final response = await Get.find<NetworkCaller>().getRequest(
        Urls.getServiceProviderTypes,
        accessToken:
            SpAuthController.token ?? await AuthService.getToken() ?? "",
      );

      if (response.isSuccess && response.responseData["data"] != null) {
        final data = response.responseData["data"];
        _types =
            data
                .map<ServiceProviderTypeModel>(
                  (e) => ServiceProviderTypeModel.fromJson(e),
                )
                .toList();
        isSuccess = true;
      }
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      update();
    }
    return isSuccess;
  }
}
