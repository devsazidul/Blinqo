import 'dart:io';
import 'package:blinqo/core/urls/endpoint.dart';
import 'package:blinqo/features/role/venue_owner/owern_network_caller/even_authcontroller.dart';
import 'package:blinqo/features/role/venue_owner/owern_network_caller/owner_network_caller.dart';
import 'package:blinqo/features/role/venue_owner/profile_page/screen/venue_setup_screen.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:logger/logger.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../../../core/common/styles/global_text_style.dart';
import '../../../../../core/utils/constants/colors.dart';
import '../../authentication/model/login_model.dart';

class VenueProfileSetupController extends GetxController {
  var profileImage = Rx<File?>(null);
  TextEditingController nameController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  var name = ''.obs;
  var location = ''.obs;
  var userId = ''.obs;

  final _logger = Logger(
    printer: PrettyPrinter(
      methodCount: 0,
      errorMethodCount: 5,
      lineLength: 140,
      colors: true,
      printEmojis: true,
      dateTimeFormat: DateTimeFormat.dateAndTime,
    ),
  );

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
          SizedBox(height: 8),
          Text(
            title,
            style: getTextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }

  Future<ImageSource?> showPickrOption() async {
    return await Get.bottomSheet(
      Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
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
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildImagePickerOption(
                    icon: Icons.camera_alt,
                    title: 'Camera',
                    onTap: () {
                      Get.back(result: ImageSource.camera);
                    },
                  ),
                  _buildImagePickerOption(
                    icon: Icons.photo_library,
                    title: 'Gallery',
                    onTap: () {
                      Get.back(result: ImageSource.gallery);
                    },
                  ),
                ],
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  //--------------------------------------------------------
  // Submit profile data to the server
  //--------------------------------------------------------

  Future<void> submitProfile() async {
    _logger.i('Starting profile submission process');

    // Validate inputs

    if (profileImage.value == null) {
      EasyLoading.showError('Please select a profile image');
      return;
    }

    _logger.i(
      'Validation passed: Image: ${profileImage.value?.path}, Name: ${name.value}, Location: ${location.value}',
    );

    // Fetch user data
    _logger.d('Fetching user info and auth token');
    User? user = await EvenAuthController.getUserInfo();
    String? token = await EvenAuthController.getAuthToken();
    userId.value = user?.id ?? '';
    _logger.i('User info fetched - UserID: ${userId.value}, Token: $token');

    if (userId.value.isEmpty) {
      _logger.w('User ID is empty, cannot proceed with submission');
      EasyLoading.showError('Failed to fetch user ID');
      return;
    }

    // Prepare request data
    _logger.d('Preparing multipart request data');
    var body = {
      'location': location.value,
      'name': name.value,
      'userId': userId.value,
    };
    _logger.i('Request body prepared: $body');
    _logger.d('Preparing image file for upload: ${profileImage.value?.path}');

    // Send request
    _logger.i('Sending multipart request to ${Urls.venueOwnerSetupProfile}');
    var request = await OwnerNetworkCaller().postRequest(
      Url: Urls.venueOwnerSetupProfile,
      token: token,
      body: body,
      files: [
        await http.MultipartFile.fromPath('image', profileImage.value!.path),
      ],
      isMultipart: true,
    );

    // Handle response
    if (request.isSuccess) {
      _logger.i(
        'Profile submission successful - Status: ${request.statusCode}, Response: ${request.body}',
      );
      EasyLoading.showSuccess('Profile updated successfully');
      Get.to(VenueSetupScreen());
    } else {
      _logger.e(
        'Profile submission failed - Status: ${request.statusCode}, Error: ${request.errorMessage}',
      );
      EasyLoading.showError(
        'Failed: ${request.errorMessage ?? 'Unknown error'}',
      );
    }
  }
}
