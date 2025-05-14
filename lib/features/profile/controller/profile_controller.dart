import 'dart:convert';
import 'dart:io';

import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/urls/endpoint.dart';
import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:blinqo/features/profile/model/usermodel.dart';
import 'package:blinqo/features/role/event_planner/auth/auth_service/auth_service.dart';
import 'package:blinqo/features/role/event_planner/auth/screen/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class ProfileController extends GetxController {
  //
  var isDarkMode = false.obs;
  var showNotifications = true.obs;

  var profileImage = Rx<File?>(null);

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

  Future<ImageSource?> showPickrOption() async {
    return await Get.bottomSheet(
      Container(
        padding: EdgeInsets.all(20),
        color: AppColors.primary,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Choose Image Source",
              style: getTextStyle(color: AppColors.textColor, fontSize: 20),
            ),
            SizedBox(height: 20),
            ListTile(
              leading: Icon(Icons.camera_alt, color: AppColors.textColor),
              title: Text(
                "Camera",
                style: getTextStyle(color: AppColors.textColor),
              ),
              onTap: () {
                Get.back(result: ImageSource.camera);
              },
            ),
            ListTile(
              leading: Icon(Icons.image, color: AppColors.textColor),
              title: Text(
                "Gallery",
                style: getTextStyle(color: AppColors.textColor),
              ),
              onTap: () {
                Get.back(result: ImageSource.gallery);
              },
            ),
          ],
        ),
      ),
    );
  }

  // 10 image for upload
  var tenImageUpload = RxList<File>([]);

  Future<void> tenpickImage() async {
    if (tenImageUpload.length >= 10) {
      Get.snackbar('Limit Reached', 'You can only upload up to 10 images');
      return;
    }

    await requestPermissions();

    final ImagePicker picker = ImagePicker();

    final ImageSource? source = await tenImageshowPickrOption();

    if (source != null) {
      final XFile? pickedFile = await picker.pickImage(source: source);

      if (pickedFile != null) {
        tenImageUpload.add(File(pickedFile.path));
      } else {
        debugPrint("No image selected");
      }
    }
  }

  Future<void> tenImagerequestPermissions() async {
    PermissionStatus cameraStatus = await Permission.camera.request();
    PermissionStatus storageStatus = await Permission.storage.request();

    if (cameraStatus.isDenied || storageStatus.isDenied) {
      debugPrint("Permission denied");
    } else {
      debugPrint("Permission granted");
    }
  }

  Future<ImageSource?> tenImageshowPickrOption() async {
    return await Get.bottomSheet(
      Container(
        padding: EdgeInsets.all(20),
        color: Colors.white,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("Choose Image Source", style: TextStyle(fontSize: 20)),
            SizedBox(height: 20),

            ListTile(
              leading: Icon(Icons.image),
              title: Text("Gallery"),
              onTap: () {
                Get.back(result: ImageSource.gallery);
              },
            ),
          ],
        ),
      ),
    );
  }

  void toggleDarkMode() async {
    isDarkMode.value = !isDarkMode.value;
    update();
  }

  void toggleNotifications() {
    showNotifications.value = !showNotifications.value;
    update();
  }

  //============================================================================
  // Reactive variable to store user info
  final userInfo = Rx<UserInfo?>(null);
  // Reactive variable for loading state
  final isLoadingUser = false.obs;

  Future<void> getUser() async {
    debugPrint(
      'Starting getUser function at ${DateTime.now().toIso8601String()}',
    );

    try {
      debugPrint('Setting isLoadingUser to true');
      isLoadingUser.value = true;

      debugPrint('Showing EasyLoading with status: Loading user data...');
      EasyLoading.show(status: "Loading user data...");

      debugPrint('Fetching access token from AuthService');
      final accessToken = await AuthService.getToken();
      debugPrint(
        'Access token received: ${accessToken != null ? 'Token present' : 'Token null or empty'}',
      );

      if (accessToken == null || accessToken.isEmpty) {
        debugPrint('Throwing exception: Authentication token not found');
        throw Exception('Authentication token not found');
      }

      debugPrint('Preparing HTTP GET request to: ${Urls.getUserInfo}');
      debugPrint(
        'Request headers: Authorization: Bearer $accessToken, Content-Type: application/json',
      );
      final response = await http.get(
        Uri.parse(Urls.getUserInfo),
        headers: {
          'Authorization': 'Bearer $accessToken',
          'Content-Type': 'application/json',
        },
      );
      debugPrint(
        'HTTP response received with status code: ${response.statusCode}',
      );
      debugPrint('Response body: ${response.body}');

      if (response.statusCode == 200) {
        debugPrint('Parsing response body as JSON');
        final responseData = jsonDecode(response.body);
        debugPrint('Parsed response data: $responseData');

        debugPrint('Checking if success is true: ${responseData['success']}');
        if (responseData['success'] == true) {
          debugPrint('Parsing response into UserInfo model');
          userInfo.value = UserInfo.fromJson(responseData);
          debugPrint(
            'UserInfo parsed and assigned: ${userInfo.value?.data?.name ?? 'No name'}',
          );
        } else {
          debugPrint(
            'Throwing exception: Failed to fetch user data: ${responseData['message']}',
          );
          throw Exception(
            'Failed to fetch user data: ${responseData['message']}',
          );
        }
      } else {
        debugPrint(
          'Throwing exception: Failed to load user data: ${response.statusCode}',
        );
        throw Exception('Failed to load user data: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('Caught exception: $e');
      Get.snackbar("Error", "Failed to load user data: ${e.toString()}");
      debugPrint(
        'Showing Get.snackbar with error: Failed to load user data: ${e.toString()}',
      );
    } finally {
      debugPrint('Setting isLoadingUser to false');
      isLoadingUser.value = false;

      debugPrint('Dismissing EasyLoading');
      EasyLoading.dismiss();

      debugPrint(
        'getUser function completed at ${DateTime.now().toIso8601String()}',
      );
    }
  }

  //==========================================================================
  void logOut() async {
    await AuthService.clearAuthData();
    Get.offAll(() => LogInScreen());
  }

  //===========================================================================
  @override
  void onInit() {
    getUser();
    super.onInit();
  }
}
