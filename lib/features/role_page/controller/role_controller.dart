import 'package:blinqo/features/role/event_planner/onboring/home_event_planner.dart';
import 'package:blinqo/features/role/service_provider/auth/controller/auth_controller.dart';
import 'package:blinqo/features/role/service_provider/onbording/screen/onbording_screen.dart';
import 'package:blinqo/features/role/service_provider/profile_setup_page/screeen/profile_setup_screen.dart';
import 'package:blinqo/features/role/venue_owner/bottom_nav_bar/screen/vanueOwner_bottom_nav_bar.dart';
import 'package:blinqo/features/role/venue_owner/onboarding_screen/screen/venue_onboarding_screen.dart';
import 'package:blinqo/features/role/venue_owner/owern_network_caller/even_authcontroller.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class RoleController extends GetxController {
  var selectedIndex = (-1).obs;

  void selectedRole(int index) {
    selectedIndex.value = index;
  }

  Future<void> navigateToRolePage() async {
    // Check if user is logged in and has a valid token
    bool isLoggedIn = await EvenAuthController.isUserLoggedIn();
    String? role = await EvenAuthController.getUserRole();

    switch (selectedIndex.value) {
      case 0:
        Get.to(() => HomeEventPlanner());
        break;
      case 1:
        if (isLoggedIn && role == 'VENUE_OWNER') {
          Get.to(() => VanueOwnerBottomNavBar());
        } else {
          Get.to(() => VenueOnboardingScreen());
        }
        break;
      case 2:
        if (SpAuthController.token != null &&
            SpAuthController.userModel!.roles.contains('SERVICE_PROVIDER')) {
          Get.to(() => ProfileSetupScreen());
        } else {
          Get.to(() => OnbordingScreen());
        }
        break;
      default:
        EasyLoading.showError('Please select a valid role to continue.');
        break;
    }
  }

  @override
  void onInit() {
    super.onInit();
  }
}
