import 'dart:io';
import 'package:blinqo/core/urls/endpoint.dart';
import 'package:blinqo/features/role/venue_owner/owern_network_caller/even_authcontroller.dart';
import 'package:blinqo/features/role/venue_owner/owern_network_caller/owner_network_caller.dart';
import 'package:blinqo/features/role/venue_owner/profile_page/screen/venue_setup_screen.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../authentication/model/login_model.dart';

class VenueProfileSetupController extends GetxController {
  var profileImage = Rx<File?>(null);
  var name = ''.obs;
  var location = ''.obs;

  // Function to request permissions and pick an image
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

  // Show the bottom sheet to pick an image source (camera or gallery)
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


  // Function to send the profile data as multipart
  Future<void> submitProfile() async {
    // Make sure image, name, and location are valid
    if (profileImage.value == null || name.isEmpty || location.isEmpty) {
      Get.snackbar('Error', 'Please complete all fields.');
      return;
    }
    User? user = await EvenAuthController.getUserInfo();
    String? userId =user?.id;
    // Prepare the multipart files and fields
    var request = await OwnerNetworkCaller().postRequest(
      Url: Urls.venueOwnerSetupProfile, // Replace with actual URL
      body: {
        'location': location.value,
        'name': name.value,
        'userId': userId,
      },
      files: [
        await http.MultipartFile.fromPath(
          'image', // Field name in API
          profileImage.value!.path,
        ),
      ],
      isMultipart: true,
    );

    if (request.isSuccess) {
      // Handle success, navigate to the next screen
      Get.to(VenueSetupScreen());
    } else {
      Get.snackbar('Error', request.errorMessage ?? 'Something went wrong.');
    }
  }
}