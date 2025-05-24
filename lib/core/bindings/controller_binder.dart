import 'package:blinqo/core/common/controllers/fetch_sp_types_controller.dart';
import 'package:blinqo/core/services/network_caller.dart';
import 'package:blinqo/features/role/event_planner/auth/controller/change_password_controller.dart';
import 'package:blinqo/features/role/event_planner/auth/controller/forget_password_controller.dart';
import 'package:blinqo/features/role/event_planner/auth/controller/login_controller.dart';
import 'package:blinqo/features/role/event_planner/auth/controller/signup_controller.dart';
import 'package:blinqo/features/role/event_planner/ep_booking/controllers/ep_booking_controller.dart';
import 'package:blinqo/features/role/event_planner/ep_common/controllers/ep_bottom_nav_controller.dart';
import 'package:blinqo/features/role/event_planner/ep_home/controller/ep_get_all_venues_controller.dart';
import 'package:blinqo/features/role/event_planner/ep_home/controller/ep_get_sp_works_controller.dart';
import 'package:blinqo/features/role/event_planner/ep_home/controller/ep_home_screen_controller.dart';
import 'package:blinqo/features/role/event_planner/ep_home/controller/ep_service_provider_type_controller.dart';
import 'package:blinqo/features/role/event_planner/ep_home/controller/ep_venue_compare_controller.dart';
import 'package:blinqo/features/role/event_planner/profile/controller/pick_color_controller.dart';
import 'package:blinqo/features/role/event_planner/profile/controller/profile_controller.dart';
import 'package:blinqo/features/role/service_provider/bottom_nav_bar/controller/bottom_nav_controller.dart';
import 'package:blinqo/features/role/service_provider/common/controller/sp_get_user_info_controller.dart';
import 'package:blinqo/features/role/service_provider/profile_setup_and_edit/controller/sp_profile_update_setup_controller.dart';
import 'package:blinqo/features/role/service_provider/sp_profile/controller/sp_edit_profile_controller.dart';
import 'package:blinqo/features/role/service_provider/sp_profile/controller/sp_get_all_works_controller.dart';
import 'package:blinqo/features/role/service_provider/sp_profile/controller/sp_profile_controller.dart';
import 'package:blinqo/features/role/service_provider/sp_profile/controller/sp_work_details_controller.dart';
import 'package:get/get.dart';

class ControllerBinder extends Bindings {
  @override
  void dependencies() {
    // -------------------------------------------------------------------
    //* Event Planner
    // -------------------------------------------------------------------
    Get.put(PickColorController());
    // common controllers
    Get.put(EventBottomNavController());
    Get.put(ProfileController());
    Get.put(PickColorController());
    Get.put(EpVenueCompareController());
    Get.put(EpBookingController());
    Get.put(SpEditProfileController());
    Get.put(EpGetAllVenuesController());
    Get.put(EpServiceProviderTypeController());
    Get.put(EpGetSpWorksController());
    // Event planner home controllers
    Get.put(EpHomeScreenController());

    // -------------------------------------------------------------------
    //* Service Provider
    // -------------------------------------------------------------------
    Get.put(NetworkCaller());
    Get.put(SpGetUserInfoController());
    Get.put(SpProfileController());
    Get.put(SpProfileUpdateSetupController());
    Get.put(SpGetAllWorksController());
    Get.put(SpWorkDetailsController());
    Get.put(ServiceProviderTypesController());

    ///
    Get.put(BottomNavController());
    Get.put(LoginController());
    Get.put(SignUpController());
    Get.put(ForgetPasswordController());
    Get.put(ChangePasswordController());
  }
}
