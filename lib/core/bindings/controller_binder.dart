import 'package:blinqo/features/profile/controller/pick_color_controller.dart';
import 'package:blinqo/features/profile/controller/profile_controller.dart';
import 'package:blinqo/features/role/event_planner/auth/controller/change_password_controller.dart';
import 'package:blinqo/features/role/event_planner/auth/controller/forget_password_controller.dart';
import 'package:blinqo/features/role/event_planner/auth/controller/login_controller.dart';
import 'package:blinqo/features/role/event_planner/auth/controller/signup_controller.dart';
import 'package:blinqo/features/role/service_provider/bottom_nav_bar/controller/bottom_nav_controller.dart';
import 'package:blinqo/features/role/service_provider/service_profile_page/controller/service_user_edit_profile_controller.dart';
import 'package:blinqo/features/role/service_provider/service_profile_page/controller/service_user_profile_controler.dart';
import 'package:blinqo/features/role/service_provider/services/sp_network_caller.dart';
import 'package:get/get.dart';

class ControllerBinder extends Bindings {
  @override
  void dependencies() {
    // Get.lazyPut<LogInController>(
    //       () => LogInController(),
    //   fenix: true,
    // );
    Get.put(SpNetworkCaller());
    Get.put(PickColorController());
    Get.put(ProfileController());
    Get.put(PickColorController());

    Get.put(ServiceUserEditProfileController());

    Get.put(SpProfileController());

    Get.put(BottomNavController());
    Get.put(LoginController());
    Get.put(SignUpController());
    Get.put(ForgetPasswordController());
    Get.put(ChangePasswordController());
  }
}
