// import 'package:blinqo/features/role/event_planner/auth/auth_service/auth_service.dart';
// import 'package:blinqo/features/role/service_provider/bottom_nav_bar/screen/sp_bottom_nav_bar.dart';
// import 'package:blinqo/features/role/service_provider/common/controller/auth_controller.dart';
// import 'package:blinqo/features/role/service_provider/common/controller/sp_get_user_info_controller.dart';
// import 'package:blinqo/features/role/service_provider/onbording/screen/sp_onbording_screen.dart';
// import 'package:blinqo/features/role/service_provider/profile_setup_page/controller/sp_profile_setup_controller.dart';
// import 'package:blinqo/features/role/service_provider/profile_setup_page/screeen/sp_profile_setup_screen.dart';
// import 'package:blinqo/features/role/venue_owner/authentication/model/login_model.dart';
// import 'package:blinqo/features/role/venue_owner/bottom_nav_bar/screen/vanueOwner_bottom_nav_bar.dart';
// import 'package:blinqo/features/role/venue_owner/onboarding_screen/screen/venue_onboarding_screen.dart';
// import 'package:blinqo/features/role/venue_owner/owern_network_caller/even_authcontroller.dart';
// import 'package:blinqo/features/role/venue_owner/profile_page/screen/v_profile_setup_screen.dart';
// import 'package:flutter_easyloading/flutter_easyloading.dart';
// import 'package:get/get.dart';
// import 'package:logger/logger.dart';

// class RoleController extends GetxController {
//   Logger logger = Logger();
//   var selectedIndex = (-1).obs;

//   void selectedRole(int index) {
//     selectedIndex.value = index;
//   }

//   Future<void> navigateToRolePage() async {
//     // Check if user is logged in and has a valid token
//     bool isLoggedIn = await EventAuthController.isUserLoggedIn();
//     String? role = await EventAuthController.getUserRole();
//     EventUser? eventUser = await EventAuthController.getUserInfo();
//     bool isELoggedin = await AuthService.isAuthenticated();
//     String Erole = await AuthService.isRole();

//     switch (selectedIndex.value) {
//       case 0:
//         if (isELoggedin && Erole == 'PLANNER') {
//           if (eventUser?.isProfileCreated == false) {
//             Get.offAll(() => VenueProfileScreen());
//           } else {
//             Get.offAll(() => VanueOwnerBottomNavBar());
//           }
//         } else {
//           Get.to(() => VenueOnboardingScreen());
//         }
//         break;
//       case 1:
//         if (isLoggedIn && role == 'VENUE_OWNER') {
//           if (eventUser?.isProfileCreated == false) {
//             Get.offAll(() => VenueProfileScreen());
//           } else {
//             Get.offAll(() => VanueOwnerBottomNavBar());
//           }
//         } else {
//           Get.to(() => VenueOnboardingScreen());
//         }
//         break;
//       case 2:
//         // check is user logged in?
//         // It will check is token exists on local storage.
//         // if exists then get SpUser data from local storage and save on the spUser variable in AuthController
//         if (await SpAuthController.isLoggedIn()) {
//           // get user info from server and save on the spUser variable in AuthController
//           await Get.find<SpGetUserInfoController>().spGetUserInfo();

//           // check is profile id exists?
//           if (SpAuthController.spUser?.profile?.id != null) {
//             // if profile id exists it means profile is already created
//             Get.to(() => SpBottomNavBarScreen());
//           } else {
//             // if profile id not exists it means profile is not created
//             // So we will get event preferences from server and go to profile setup screen to create profile
//             await Get.put(SpProfileSetupController()).getEventPreferences();
//             Get.to(() => SpProfileSetupScreen());
//           }
//         } else {
//           // if user is not logged in then go to onboarding screen
//           Get.to(() => SpOnBoardingScreen());
//         }

//         break;
//       default:
//         EasyLoading.showError('Please select a valid role to continue.');
//         break;
//     }
//   }
// }

import 'package:blinqo/features/role/event_planner/auth/auth_service/auth_service.dart';
import 'package:blinqo/features/role/event_planner/bottom_nav_bar/screen/event_bottom_nav_bar.dart';
import 'package:blinqo/features/role/event_planner/onboring/home_event_planner.dart';
import 'package:blinqo/features/role/event_planner/profile_setup/screens/profile_setup.dart';
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
import 'package:flutter/cupertino.dart';
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
    bool isELoggedin = await AuthService.isAuthenticated();
    bool erole =
        await AuthService.isRole(); // Now, we get the role as a string
    bool isProfileCreated = await AuthService.isProfileCreated();

    switch (selectedIndex.value) {
      case 0:
        // ignore: unrelated_type_equality_checks
        debugPrint("Shakil============is login: $isELoggedin");
        debugPrint("Shakil============ is role: $erole");
        debugPrint("Shakil============ is profile: $isProfileCreated");
        if (isELoggedin && erole == true) {
          if (isProfileCreated == false) {
            Get.offAll(() => ProfileSetup());
          } else {
            Get.offAll(() => EventBottomNavBar());
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
          await Get.find<SpGetUserInfoController>().spGetUserInfo();

          if (SpAuthController.spUser?.profile?.id != null) {
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
