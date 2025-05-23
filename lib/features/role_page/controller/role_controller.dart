import 'package:blinqo/core/services/notification_service.dart';
import 'package:blinqo/features/role/event_planner/auth/auth_service/auth_service.dart';
import 'package:blinqo/features/role/event_planner/ep_home/controller/ep_home_screen_controller.dart';
import 'package:blinqo/features/role/event_planner/main_layout/screen/ep_main_layout_screen.dart';
import 'package:blinqo/features/role/event_planner/onboring/home_event_planner.dart';
import 'package:blinqo/features/role/event_planner/profile_setup/screens/profile_setup.dart';
import 'package:blinqo/features/role/service_provider/bottom_nav_bar/screen/sp_bottom_nav_bar.dart';
import 'package:blinqo/features/role/service_provider/common/controller/auth_controller.dart';
import 'package:blinqo/features/role/service_provider/common/controller/sp_get_user_info_controller.dart';
import 'package:blinqo/features/role/service_provider/onbording/screen/sp_onbording_screen.dart';
import 'package:blinqo/features/role/service_provider/profile_setup_and_edit/controller/sp_profile_update_setup_controller.dart';
import 'package:blinqo/features/role/service_provider/profile_setup_and_edit/screeen/sp_profile_setup_&_edit_screen.dart';
import 'package:blinqo/features/role/service_provider/sp_profile/controller/sp_get_all_works_controller.dart';
import 'package:blinqo/features/role/venue_owner/authentication/model/login_model.dart';
import 'package:blinqo/features/role/venue_owner/bottom_nav_bar/screen/vanueOwner_bottom_nav_bar.dart';
import 'package:blinqo/features/role/venue_owner/onboarding_screen/screen/venue_onboarding_screen.dart';
import 'package:blinqo/features/role/venue_owner/owern_network_caller/even_authcontroller.dart';
import 'package:blinqo/features/role/venue_owner/profile_page/screen/v_profile_setup_screen.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

class RoleController extends GetxController {
  Logger logger = Logger();
  var selectedIndex = (-1).obs;

  void selectedRole(int index) {
    selectedIndex.value = index;
  }

  Future<void> navigateToRolePage() async {
    // Check if user is logged in and has a valid token
    bool isLoggedIn = await EventAuthController.isUserLoggedIn();
    String? role = await EventAuthController.getUserRole();
    EventUser? eventUser = await EventAuthController.getUserInfo();
    bool isEpLoggedIn = await AuthService.isAuthenticated();
    bool epRole =
        await AuthService.isRole(); // Now, we get the role as a string
    bool isProfileCreated = await AuthService.isProfileCreated();

    switch (selectedIndex.value) {
      case 0:
        if (isEpLoggedIn && epRole == true) {
          if (isProfileCreated == false) {
            Get.offAll(() => ProfileSetup());
          } else {
            Get.find<EpHomeScreenController>().getHomeData();
            Get.offAll(() => EventPlannerMainLayoutScreen());
          }
        } else {
          Get.to(() => HomeEventPlanner());
        }
        break;
      case 1:
        if (isLoggedIn && role == 'VENUE_OWNER') {
          if (eventUser?.isProfileCreated == false) {
            Get.offAll(() => VenueProfileScreen());
          } else {
            Get.offAll(() => VanueOwnerBottomNavBar());
          }
        } else {
          Get.to(() => VenueOnboardingScreen());
        }
        break;
      case 2:
        if (await SpAuthController.isLoggedIn()) {
          // sent fcm token to server
          await NotificationService.tryToSendTokenToServer(
            accessToken: SpAuthController.token,
          );
          await Get.find<SpGetUserInfoController>().spGetUserInfo();

          if (SpAuthController.spUser?.profile?.id != null) {
            // if profile id exists it means profile is already created
            await Get.find<SpGetAllWorksController>().getAllWorks();

            Get.to(() => SpBottomNavBarScreen());
          } else {
            await Get.put(
              SpProfileUpdateSetupController(),
            ).getEventPreferences();
            Get.to(() => SpProfileSetupAndEditScreen());
          }
        } else {
          Get.to(() => SpOnBoardingScreen());
        }
        break;
      default:
        EasyLoading.showError('Please select a valid role to continue.');
        break;
    }
  }
}
