import 'package:blinqo/features/profile/controller/pick_color_controller.dart';
import 'package:blinqo/features/profile/controller/profile_controller.dart';
import 'package:blinqo/features/role/event_planner/auth/controller/change_password_controller.dart';
import 'package:blinqo/features/role/event_planner/auth/controller/forget_password_controller.dart';
import 'package:blinqo/features/role/event_planner/auth/controller/login_controller.dart';
import 'package:blinqo/features/role/event_planner/auth/controller/signup_controller.dart';
import 'package:blinqo/features/role/service_provider/bottom_nav_bar/controller/bottom_nav_controller.dart';
import 'package:blinqo/features/role/service_provider/common/controller/sp_get_user_info_controller.dart';
import 'package:blinqo/features/role/service_provider/profile_setup_page/controller/sp_profile_setup_controller.dart';
import 'package:blinqo/features/role/service_provider/services/sp_network_caller.dart';
import 'package:blinqo/features/role/service_provider/sp_profile/controller/sp_edit_profile_controller.dart';
import 'package:blinqo/features/role/service_provider/sp_profile/controller/sp_get_all_works_controller.dart';
import 'package:blinqo/features/role/service_provider/sp_profile/controller/sp_profile_controller.dart';
import 'package:blinqo/features/role/service_provider/sp_profile/controller/sp_work_details_controller.dart';
import 'package:get/get.dart';

class ControllerBinder extends Bindings {
  @override
  void dependencies() {
    // Get.lazyPut<LogInController>(
    //       () => LogInController(),
    //   fenix: true,
    // );

    // Event Planner
    Get.put(PickColorController());
    Get.put(ProfileController());
    Get.put(PickColorController());

    Get.put(SpEditProfileController());

    // Service Provider
    Get.put(SpNetworkCaller());
    Get.put(SpGetUserInfoController());
    Get.put(SpProfileController());
    Get.put(SpProfileSetupController());
    Get.put(SpGetAllWorksController());
    Get.put(SpWorkDetailsController());

    ///
    Get.put(BottomNavController());
    Get.put(LoginController());
    Get.put(SignUpController());
    Get.put(ForgetPasswordController());
    Get.put(ChangePasswordController());
  }
}
