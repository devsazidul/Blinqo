import 'package:blinqo/features/role/event_planner/onboring/home_event_planner.dart';
import 'package:blinqo/features/role/service_provider/auth/controller/auth_controller.dart';
import 'package:blinqo/features/role/service_provider/onbording/screen/onbording_screen.dart';
import 'package:blinqo/features/role/service_provider/profile_setup_page/screeen/profile_setup_screen.dart';
import 'package:blinqo/features/role/venue_owner/onboarding_screen/screen/venue_onboarding_screen.dart';
import 'package:get/get.dart';

class RoleController extends GetxController {
  var selectedIndex = (-1).obs;
  void selectedRole(int index) {
    selectedIndex.value = index;
  }

  void navigateToRolePage() {
    switch (selectedIndex.value) {
      case 0:
        Get.to(() => HomeEventPlanner());
        break;
      case 1:
        Get.to(() => VenueOnboardingScreen());
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
        Get.snackbar(
          'Error',
          'Please select a role to continue.',
          snackPosition: SnackPosition.BOTTOM,
        );
        break;
    }
  }
}
