import 'dart:io';

import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
}
