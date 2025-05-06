import 'package:blinqo/features/role/service_provider/common/controller/auth_controller.dart';
import 'package:blinqo/features/role_page/screen/role_screen.dart';
import 'package:get/get.dart';

class SplashoScreenController extends GetxController {
  @override
  void onInit() async {
    await SpAuthController.getUserInformation();

    navigateAfterDelay();
    super.onInit();
  }

  void navigateAfterDelay() {
    Future.delayed(Duration(seconds: 3), () {
      Get.offAll(() => RoleScreen());
    });
  }
}
