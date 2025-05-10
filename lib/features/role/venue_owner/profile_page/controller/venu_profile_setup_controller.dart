import 'dart:io';
import 'package:blinqo/core/common/widgets/logger_view.dart';
import 'package:blinqo/core/urls/endpoint.dart';
import 'package:blinqo/features/role/venue_owner/owern_network_caller/even_authcontroller.dart';
import 'package:blinqo/features/role/venue_owner/owern_network_caller/owner_network_caller.dart';
import 'package:blinqo/features/role/venue_owner/profile_page/Model/user_all_info_model.dart';
import 'package:blinqo/features/role/venue_owner/profile_page/screen/venue_setup_screen.dart';
import 'package:blinqo/features/role/venue_owner/widgets/even_image_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../authentication/model/login_model.dart';


class VenueProfileSetupController extends GetxController {
  var profileImage = Rx<File?>(null);
  VenueOwnerUserData? user;
  TextEditingController nameTEController = TextEditingController();
  TextEditingController locationTEController = TextEditingController();

  var userId = ''.obs;
  var isLoading = false.obs;

  final _logger = createLogger();

  @override
  void onInit() {
    super.onInit();
    getUserInfo();
  }

  Future<void> pickImage() async {
    await requestPermissions();

    final ImagePicker picker = ImagePicker();
    final ImageSource? source = await showPickrOption();

    if (source != null) {
      final XFile? pickedFile = await picker.pickImage(source: source);

      if (pickedFile != null) {
        File imageFile = File(pickedFile.path);
        if (await imageFile.length() > 5 * 1024 * 1024) {
          EasyLoading.showError('Image size must be less than 5MB');
          return;
        }
        profileImage.value = imageFile;
        _logger.i('Selected image: ${imageFile.path}');
      } else {
        _logger.d('No image selected');
      }
    }
  }

  Future<void> requestPermissions() async {
    PermissionStatus cameraStatus = await Permission.camera.request();
    PermissionStatus storageStatus = await Permission.storage.request();

    if (cameraStatus.isDenied || storageStatus.isDenied) {
      _logger.w('Camera or storage permission denied');
      if (kDebugMode) {
        print('Camera or storage permission denied');
      }
    } else {
      _logger.d('Camera and storage permissions granted');
    }
  }

  // Submit new profile (POST)
  Future<void> submitProfile() async {
    _logger.i('Starting profile submission process');
    isLoading.value = true;

    if (profileImage.value == null) {
      EasyLoading.showError('Please select a profile image');
      isLoading.value = false;
      return;
    }

    EventUser? user = await EventAuthController.getUserInfo();
    if (user?.id == null) {
      EasyLoading.showError('Failed to fetch user ID');
      isLoading.value = false;
      return;
    }
    userId.value = user!.id!;

    if (nameTEController.text.trim().isEmpty) {
      EasyLoading.showError('Name is required');
      isLoading.value = false;
      return;
    }
    if (locationTEController.text.trim().isEmpty) {
      EasyLoading.showError('Location is required');
      isLoading.value = false;
      return;
    }

    var body = {
      'location': locationTEController.text.trim(),
      'name': nameTEController.text.trim(),
      'userId': userId.value,
    };
    _logger.i('Request body: $body');

    try {
      var request = await OwnerNetworkCaller().postRequest(
        Url: Urls.venueOwnerSetupProfile,
        body: body,
        files: [
          await http.MultipartFile.fromPath('image', profileImage.value!.path),
        ],
        isMultipart: true,
      );

      if (request.isSuccess) {
        String profileId = request.body['data']['id'] ?? '';
        _logger.i('Profile submission successful, profileId: $profileId');
        await EventAuthController.updateUserInfo(profileId, profileId.isNotEmpty);
        await EasyLoading.showSuccess('Profile created successfully');
        Get.to(() => VenueSetupScreen(venueStatus: 'Venue Setup'));
        clear();
      } else {
        _logger.e('Profile submission failed - Status: ${request.statusCode}, Error: ${request.errorMessage}');
        EasyLoading.showError('Failed: ${request.errorMessage ?? 'Unknown error'}');
      }
    } catch (e) {
      _logger.e('Exception during profile submission: $e');
      EasyLoading.showError('Error: $e');
    } finally {
      isLoading.value = false;
    }
  }

  // Update existing profile (PATCH)
  Future<void> updateProfile() async {

    _logger.i('Starting profile update process');
    isLoading.value = true;

    EventUser? user = await EventAuthController.getUserInfo();
    if (user?.id == null) {
      EasyLoading.showError('Failed to fetch user ID');
      isLoading.value = false;
      return;
    }
    userId.value = user!.id!;


    String profileId = EventAuthController.profileInfo!.profile!.id;
    // Format URL with profileId
    String url = Urls.venueProfileUpdate(profileId);

    // Prepare request data (exclude id from body, as it’s in the URL)
    var body = {
      // 'userId': userId.value,
      'location': locationTEController.text.trim(),
      'name': nameTEController.text.trim(),
    };
    _logger.i('Request body: $body');
    _logger.d('Image file: ${profileImage.value?.path}');

    try {
      var request = await OwnerNetworkCaller().postRequest(
        Url: url,
        body: body,
        files: profileImage.value != null
            ? [
          await http.MultipartFile.fromPath('image', profileImage.value!.path),
        ]
            : [],
        isMultipart: true,
        isPatch: true,
      );

      if (request.isSuccess) {

        await EasyLoading.showSuccess('Profile updated successfully');
        Get.back();
      } else {

        EasyLoading.showError('Failed: ${request.errorMessage ?? 'Unknown error'}');
      }
    } catch (e) {
      _logger.e('Exception during profile update: $e');
      EasyLoading.showError('Error: $e');
    } finally {
      isLoading.value = false;
    }
  }



  // Get profile information
  Future<void> getUserInfo() async {
    isLoading.value = true;
    try {
      user = await EventAuthController.getUserAllInfo();
      if (user != null && user!.profile != null) {
        nameTEController.text = user!.profile!.name;
        locationTEController.text = user!.profile!.location;
        _logger.i('User info loaded: ${user!.profile!.name}, ${user!.profile!.location}');
      } else {
        _logger.w('No user profile info available');
      }
      update();
    } catch (e) {
      _logger.e('Error fetching user info: $e');
      EasyLoading.showError('Failed to load user info');
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void dispose() {
    nameTEController.dispose();
    locationTEController.dispose();
    super.dispose();
  }

  void clear() {
    nameTEController.clear();
    locationTEController.clear();
    profileImage.value = null;
    _logger.d('Form cleared');
  }
}