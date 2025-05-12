import 'package:blinqo/core/common/widgets/logger_view.dart';
import 'package:blinqo/core/urls/endpoint.dart';
import 'package:blinqo/features/role/venue_owner/authentication/screen/v_login_screen.dart';
import 'package:blinqo/features/role/venue_owner/owern_network_caller/even_authcontroller.dart';
import 'package:blinqo/features/role/venue_owner/owern_network_caller/owner_network_caller.dart';
import 'package:blinqo/features/role/venue_owner/profile_page/Model/user_all_info_model.dart';
import 'package:blinqo/features/role/venue_owner/widgets/even_image_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class VenueOwnerProfileController extends GetxController {
  RxBool isDarkMode = false.obs;
  var showNotifications = true.obs;
  VenueOwnerUserData? user;
  var selectedImage = Rx<File?>(null);

  var profileImage = Rx<File?>(null);

  final _logger = createLogger();

  @override
  void onInit() {
    super.onInit();
    isDarkMode.value = Get.isDarkMode;
  }

  Future<void> pickImage() async {
    await requestPermissions();

    final ImagePicker picker = ImagePicker();
    final ImageSource? source = await showPickrOption();

    if (source != null) {
      final XFile? pickedFile = await picker.pickImage(source: source);

      if (pickedFile != null) {
        profileImage.value = File(pickedFile.path);
      } else {
        debugPrint("No image selected");
      }
    }
  }

  Future<void> requestPermissions() async {
    PermissionStatus cameraStatus = await Permission.camera.request();
    PermissionStatus storageStatus = await Permission.storage.request();

    if (cameraStatus.isDenied || storageStatus.isDenied) {
      debugPrint("Permission denied");
    } else {
      debugPrint("Permission granted");
    }
  }

  void toggleDarkMode() {
    isDarkMode.value = !isDarkMode.value;
    Get.changeThemeMode(isDarkMode.value ? ThemeMode.dark : ThemeMode.light);
  }

  void toggleNotifications() {
    showNotifications.value = !showNotifications.value;
  }

  // get profile information
  Future<void> getProfileInformation() async {
    var response = await OwnerNetworkCaller().getRequest(
      showLoading: false,
      Url: Urls.getUserInfo,
    );
    if (response.isSuccess) {
      final venueOwnerData = VenueOwnerUserData.fromJson(response.body['data']);
      await EventAuthController.saveUserInfo(venueOwnerData);
      _logger.i('Profile Information: ${response.body['data']}');
    }
  }

  // get profile information
  getUserInfo() async {
    user = await EventAuthController.getUserAllInfo();
    update();
  }

  // logout
  void logout() async {
    await EventAuthController.removeAuthToken();
    Get.offAll(VLoginScreen());
    EasyLoading.showSuccess('Logout Successfully');
  }
}
