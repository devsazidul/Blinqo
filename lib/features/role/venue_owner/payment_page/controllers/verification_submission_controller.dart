import 'dart:io';
import 'package:blinqo/core/common/widgets/logger_view.dart';
import 'package:blinqo/core/urls/endpoint.dart';
import 'package:blinqo/features/role/venue_owner/owern_network_caller/even_authcontroller.dart';
import 'package:blinqo/features/role/venue_owner/owern_network_caller/owner_network_caller.dart';
import 'package:blinqo/features/role/venue_owner/payment_page/screens/v_thank_you_screen.dart';
import 'package:blinqo/features/role/venue_owner/widgets/even_image_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:http/http.dart' as http;

class VerificationSubmissionController extends GetxController {
  TextEditingController nameTEController = TextEditingController();
  TextEditingController bioTEController = TextEditingController();

  var isDarkMode = false.obs;
  Rx<File?> nationalIDImage = Rx<File?>(null);
  Rx<File?> businessRegistrationImage = Rx<File?>(null);

  final _logger = createLogger();

  @override
  void onInit() {
    super.onInit();
    isDarkMode.value = Get.isDarkMode;
  }

  // Generic method to handle image selection
  Future<void> pickImage(String imageType) async {
    await requestPermissions();

    final ImagePicker picker = ImagePicker();
    final ImageSource? source = await showPickrOption();

    if (source != null) {
      final XFile? pickedFile = await picker.pickImage(source: source);

      if (pickedFile != null) {
        if (imageType == 'national_id') {
          nationalIDImage.value = File(pickedFile.path);
        } else if (imageType == 'business_cert') {
          businessRegistrationImage.value = File(pickedFile.path);
        }
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

  // API call for verification submission
  Future<void> submitVerification() async {
    _logger.i('Starting verification submission process');

    // Comprehensive validation
    if (nationalIDImage.value == null) {
      EasyLoading.showError('Please upload your National ID');
      return;
    }
    if (businessRegistrationImage.value == null) {
      EasyLoading.showError(
        'Please upload your Business Registration Certificate',
      );
      return;
    }

    String? profileId =
        EventAuthController
            .profileInfo
            ?.profile
            ?.id; // Changed from userId to id
    _logger.i('Profile ID: $profileId');
    if (profileId == null || profileId.isEmpty) {
      EasyLoading.showError('Failed to fetch valid profile ID');
      return;
    }

    if (bioTEController.text.trim().isEmpty) {
      EasyLoading.showError('Please enter a bio');
      return;
    }

    var body = {"profileId": profileId, "bio": bioTEController.text.trim()};

    List<http.MultipartFile> files = [
      if (nationalIDImage.value != null)
        await http.MultipartFile.fromPath(
          'idCard',
          nationalIDImage.value!.path,
        ),
      if (businessRegistrationImage.value != null)
        await http.MultipartFile.fromPath(
          'tradeLicense',
          businessRegistrationImage.value!.path,
        ),
    ];

    _logger.i('Request body: $body');
    _logger.d('Id Card Image file: ${nationalIDImage.value?.path}');
    _logger.d(
      'Business Registration Image file: ${businessRegistrationImage.value?.path}',
    );

    try {
      final response = await OwnerNetworkCaller().postRequest(
        Url: Urls.sendVerificationRequest,
        body: body,
        files: files,
        isMultipart: true,
      );
      _logger.i('Response: ${response.body}');

      if (response.isSuccess) {
        EasyLoading.showSuccess('Verification submitted successfully');
        Get.to(
          VThankYouScreen(),
          transition: Transition.rightToLeft,
          duration: const Duration(milliseconds: 400),
        );
      } else {
        String errorMessage = response.errorMessage ?? 'Unknown error';
        if (errorMessage.length > 100) {
          errorMessage = '${errorMessage.substring(0, 100)}...';
        }
        EasyLoading.showError('Failed: $errorMessage');
      }
    } catch (e) {
      _logger.e('Exception during verification submission: $e');
      EasyLoading.showError('Error: $e');
    }
  }
}
