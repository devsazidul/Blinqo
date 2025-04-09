import 'package:blinqo/features/role/service_provider/service_profile_page/controller/service_user_edit_profile_controller.dart';
import 'package:get/get.dart';

class ControllerBinder extends Bindings {
  @override
  void dependencies() {
    // Get.lazyPut<LogInController>(
    //       () => LogInController(),
    //   fenix: true,
    // );
    Get.put(ServiceUserEditProfileController());
  }
}
