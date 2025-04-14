import 'package:blinqo/features/role/service_provider/service_profile_page/controller/service_user_edit_profile_controller.dart';
import 'package:get/get.dart';

import '../../features/role/service_provider/bottom_nav_bar/controller/bottom_nav_controller.dart';
import '../../features/role/service_provider/service_profile_page/controller/service_user_profile_controler.dart'
    show SpProfileController;

class ControllerBinder extends Bindings {
  @override
  void dependencies() {
    // Get.lazyPut<LogInController>(
    //       () => LogInController(),
    //   fenix: true,
    // );
    Get.put(ServiceUserEditProfileController());

    Get.put(SpProfileController());

    Get.put(BottomNavController());
  }
}
