import 'dart:io';

import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class ProfileController extends GetxController {
  var selectedRoles = "Photographer".obs;
  var roles = ["Photographer", "Videographer", "DJ Brand", "Catering"];
  var selectedEvents = <String>[].obs;
  

  var eventsRoles = [
    "Corporate",
    "Weddings",
    "Music Festivals",
    "Exhibitions",
    "Concerts",
    "Charity Events",
    "Private Parties",
    "Product Launches",
    "Trade Shows"
  ];

  var profileImage = Rx<File?>(null);

  // Function to request permissions and pick an image
  Future<void> pickImage() async {
    await requestPermissions();

    // ignore: no_leading_underscores_for_local_identifiers
    final ImagePicker _picker = ImagePicker();

    final ImageSource? source = await showPickrOption();

    if (source != null) {
      final XFile? pickedFile = await _picker.pickImage(source: source);

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

  // selected roles
  void updateRoles(String newRole) {
    selectedRoles.value = newRole;
  }
  void toggleEventSelection(String event) {
    if (selectedEvents.contains(event)) {
      selectedEvents.remove(event);
    } else {
      selectedEvents.add(event);  
    }
  }
}
