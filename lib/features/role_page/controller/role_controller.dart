import 'package:blinqo/features/role/event_planner/onboring/home_event_planner.dart';
import 'package:blinqo/features/role/service_provider/bottom_nav_bar/screen/sp_bottom_nav_bar.dart';
import 'package:blinqo/features/role/service_provider/common/controller/auth_controller.dart';
import 'package:blinqo/features/role/service_provider/common/controller/sp_get_user_info_controller.dart';
import 'package:blinqo/features/role/service_provider/onbording/screen/sp_onbording_screen.dart';
import 'package:blinqo/features/role/service_provider/profile_setup_page/controller/sp_profile_setup_controller.dart';
import 'package:blinqo/features/role/service_provider/profile_setup_page/screeen/sp_profile_setup_screen.dart';
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
    bool isLoggedIn = await EvenAuthController.isUserLoggedIn();
    String? role = await EvenAuthController.getUserRole();
    EventUser? eventUser = await EvenAuthController.getUserInfo();

    switch (selectedIndex.value) {
      case 0:
        Get.to(() => HomeEventPlanner());
        break;
      case 1:
        if (isLoggedIn && role == 'VENUE_OWNER') {
          if (eventUser?.isProfileCreated == false) {
            Get.offAll(() => VanueOwnerBottomNavBar());
          }
          Get.offAll(() => VenueProfileScreen());
        } else {
          Get.to(() => VenueOnboardingScreen());
        }
        break;
      case 2:
        if (await SpAuthController.isUserLoggedIn()) {
          if (SpAuthController.userModel?.isProfileCreated == true) {
            await Get.find<SpGetUserInfoController>().getUserInfo();
            Get.to(() => SpBottomNavBarScreen());
          } else {
            await Get.put(SpProfileSetupController()).getEventPreferences();
            Get.to(() => SpProfileSetupScreen());
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
