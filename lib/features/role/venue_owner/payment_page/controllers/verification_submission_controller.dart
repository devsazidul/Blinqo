import 'dart:io';

import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class VerificationSubmissionController extends GetxController {
  // State for dark mode
  var isDarkMode = false.obs;

  // Map to store multiple images, key is the image identifier (e.g., "national_id", "business_cert")
  var images = <String, Rx<File?>>{}.obs;

  @override
  void onInit() {
    super.onInit();
    // Initialize dark mode based on system theme or saved preference
    isDarkMode.value = Get.isDarkMode;
    debugPrint("VenueOwnerProfileController initialized, isDarkMode: ${isDarkMode.value}");
  }

  // Initialize the image state for a specific key if not already present
  void _initializeImage(String imageKey) {
    if (!images.containsKey(imageKey)) {
      images[imageKey] = Rxn<File>();
    }
  }

  Future<void> pickImage(String imageKey) async {
    debugPrint("pickImage called for imageKey: $imageKey");
    // Ensure the imageKey exists in the map
    _initializeImage(imageKey);

    await requestPermissions();

    debugPrint("Permissions requested, showing picker option...");
    final ImageSource? source = await showPickerOption();

    if (source != null) {
      debugPrint("Image source selected: $source");
      final ImagePicker picker = ImagePicker();
      final XFile? pickedFile = await picker.pickImage(source: source);

      if (pickedFile != null) {
        debugPrint("Image picked: ${pickedFile.path}");
        // Validate the image
        bool isValid = await validateImage(File(pickedFile.path));
        if (isValid) {
          images[imageKey]!.value = File(pickedFile.path);
          debugPrint("Image set for $imageKey: ${pickedFile.path}");
        } else {
          Get.snackbar(
            'Invalid Image',
            'Please select a JPG, JPEG, or PNG image less than 1MB.',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
        }
      } else {
        debugPrint("No image selected");
      }
    } else {
      debugPrint("No image source selected");
    }
  }

  Future<bool> validateImage(File imageFile) async {
    debugPrint("Validating image: ${imageFile.path}");
    // Check file size (less than 1MB)
    final int fileSizeInBytes = await imageFile.length();
    const int maxSizeInBytes = 1 * 1024 * 1024; // 1MB in bytes
    if (fileSizeInBytes > maxSizeInBytes) {
      debugPrint("Image size exceeds 1MB: $fileSizeInBytes bytes");
      return false;
    }

    // Check file format (JPG, JPEG, PNG)
    final String filePath = imageFile.path.toLowerCase();
    if (!filePath.endsWith('.jpg') && !filePath.endsWith('.jpeg') && !filePath.endsWith('.png')) {
      debugPrint("Invalid image format: $filePath");
      return false;
    }

    debugPrint("Image validation passed");
    return true;
  }

  Future<void> requestPermissions() async {
    debugPrint("Requesting permissions...");
    PermissionStatus cameraStatus = await Permission.camera.request();
    PermissionStatus storageStatus = await Permission.storage.request();

    if (cameraStatus.isDenied || storageStatus.isDenied) {
      debugPrint("Permission denied: camera: $cameraStatus, storage: $storageStatus");
      // Get.snackbar(
      //   'Permission Denied',
      //   'Please grant camera and storage permissions to upload an image.',
      //   snackPosition: SnackPosition.BOTTOM,
      //   backgroundColor: Colors.red,
      //   colorText: Colors.white,
      // );
    } else {
      debugPrint("Permission granted: camera: $cameraStatus, storage: $storageStatus");
    }
  }

  Widget _buildImagePickerOption({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: AppColors.iconColor.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: AppColors.iconColor, size: 30),
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: getTextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }

  Future<ImageSource?> showPickerOption() async {
    debugPrint("Showing image picker option bottom sheet");
    return await Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Select Image',
                style: getTextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildImagePickerOption(
                    icon: Icons.camera_alt,
                    title: 'Camera',
                    onTap: () {
                      debugPrint("Camera option selected");
                      Get.back(result: ImageSource.camera);
                    },
                  ),
                  _buildImagePickerOption(
                    icon: Icons.photo_library,
                    title: 'Gallery',
                    onTap: () {
                      debugPrint("Gallery option selected");
                      Get.back(result: ImageSource.gallery);
                    },
                  ),
                ],
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
      barrierColor: Colors.black54,
      isScrollControlled: true,
    );
  }
}