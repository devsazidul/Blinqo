import 'package:blinqo/core/services/network_caller.dart';
import 'package:blinqo/core/urls/endpoint.dart';
import 'package:blinqo/features/role/event_planner/event_home_page/models/additional_services.dart';
import 'package:get/get.dart';
import '../../../auth/auth_service/auth_service.dart';

class EpAdditionalServiceProviderController extends GetxController {
  var isLoading = false.obs;
  Rx<Rx<AdditionalService>> service =
      Rx<AdditionalService>(
        AdditionalService(data: [], message: '', statusCode: 0, success: false),
      ).obs;

  @override
  void onInit() {
    super.onInit();
    fetchData();
  }

  Future<void> fetchData() async {
    isLoading(true);
    final accessToken = await AuthService.getToken();

    final response = await NetworkCaller().getRequest(
      Urls.getServiceProvider,
      token: 'Bearer $accessToken',
    );

    if (response.statusCode == 200) {

      service.value = Rx<AdditionalService>(
        AdditionalService.fromJson(response.responseData),
      );
    }
    isLoading(false);
  }
}
