import 'package:get/get.dart';
import 'package:blinqo/features/role_page/screen/role_screen.dart';

class SplashoScreenController extends GetxController {
  @override
  void onInit() {
    navigateAfterDelay();
    super.onInit();
  }

  void navigateAfterDelay() {
    Future.delayed(Duration(seconds: 3), () {
      Get.offAll(() => RoleScreen());
    });
  }
}
