import 'package:blinqo/features/role/event_planner/ep_home/controller/ep_get_all_venues_controller.dart';
import 'package:blinqo/features/role/event_planner/ep_home/controller/ep_service_provider_type_controller.dart';
import 'package:get/get.dart';

class EpHomeScreenController extends GetxController {
  // initialize the controller
  final EpGetAllVenuesController epGetAllVenuesController = Get.find();
  final EpServiceProviderTypeController epServiceProviderTypeController =
      Get.find();

  void getHomeData() async {
    await epGetAllVenuesController.getAllVenues();
    await epServiceProviderTypeController.fetchAllServiceProviderTypes();
  }
}
