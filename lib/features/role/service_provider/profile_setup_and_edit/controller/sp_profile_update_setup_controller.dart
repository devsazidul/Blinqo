import 'dart:convert';
import 'dart:io';

import 'package:blinqo/core/common/controllers/fetch_sp_types_controller.dart';
import 'package:blinqo/core/common/models/network_response.dart';
import 'package:blinqo/core/common/models/sp_type_model.dart';
import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/services/network_caller.dart';
import 'package:blinqo/core/urls/endpoint.dart';
import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:blinqo/features/role/service_provider/bottom_nav_bar/screen/sp_bottom_nav_bar.dart';
import 'package:blinqo/features/role/service_provider/common/controller/auth_controller.dart';
import 'package:blinqo/features/role/service_provider/common/controller/sp_get_user_info_controller.dart';
import 'package:blinqo/features/role/service_provider/profile_setup_and_edit/model/event_preference_model.dart';
import 'package:blinqo/features/role/service_provider/profile_setup_and_edit/model/profile_setup_model.dart';
import 'package:blinqo/features/role/service_provider/sp_profile/controller/sp_get_all_works_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';
import 'package:permission_handler/permission_handler.dart';

/// Controller for managing service provider profile setup and editing
class SpProfileUpdateSetupController extends GetxController {
  final Logger _logger = Logger();
  final spTypeController = Get.put(ServiceProviderTypesController());
  final formKey = GlobalKey<FormState>();

  // Text Controllers
  final TextEditingController nameController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController experienceYearController =
      TextEditingController();

  // Observable variables
  final RxBool _isInitialized = false.obs;
  final RxBool _isEditMode = false.obs;
  final Rx<File?> profileImage = Rx<File?>(null);
  final Rx<File?> coverImage = Rx<File?>(null);
  final Rx<ServiceProviderTypeModel> selectedRoles =
      Rx<ServiceProviderTypeModel>(ServiceProviderTypeModel());

  final RxList<String> selectedEvents = <String>[].obs;
  final RxBool isLoadingEventPreference = false.obs;
  final RxBool isLoadingServiceProviderSetup = false.obs;
  final RxBool isLoadingServiceProviderUpdate = false.obs;
  final RxList<EventPreferenceModel> eventPreferenceList =
      <EventPreferenceModel>[].obs;

  // Map related variables
  late GoogleMapController _mapController;
  bool _isMapCreated = false;
  final LatLng _center = const LatLng(37.7749, -122.4194);
  final Set<Marker> _markers = {};

  // Getters
  bool get isEditMode => _isEditMode.value;
  bool get isInitialized => _isInitialized.value;
  Set<Marker> get mapMarkers => _markers;
  // List<ServicePro> get roles => spTypeController.types.map((x) => x.name).toList();
  GoogleMapController get mapController => _mapController;
  LatLng get center => _center;

  @override
  void onInit() {
    super.onInit();

    nameController.text = SpAuthController.spUser?.name ?? "";
  }

  @override
  void dispose() {
    clearAllData();
    nameController.dispose();
    usernameController.dispose();
    descriptionController.dispose();
    locationController.dispose();
    experienceYearController.dispose();
    super.dispose();
  }

  /// Initialize edit mode with user's existing data
  void initializeEditMode() {
    if (_isEditMode.value && !_isInitialized.value) {
      final profile = SpAuthController.spUser?.profile;
      nameController.text = SpAuthController.spUser?.name ?? "";
      usernameController.text = profile?.name ?? "";
      selectedRoles.value =
          profile?.serviceType?[profile.serviceType!.length - 1] ??
          ServiceProviderTypeModel();

      locationController.text = profile?.location ?? "";
      descriptionController.text = profile?.description ?? "";
      experienceYearController.text = profile?.experience?.toString() ?? "";
      selectedEvents.addAll(
        profile?.eventPreference?.map((e) => e.id ?? '') ?? [],
      );
      _isInitialized.value = true;
    }
  }

  /// Set edit mode and initialize if needed
  void setEditMode(bool value) {
    _isEditMode.value = value;
    if (value) {
      initializeEditMode();
    }
  }

  /// Clear all form data and reset state
  void clearAllData() {
    nameController.clear();
    usernameController.clear();
    descriptionController.clear();
    locationController.clear();
    experienceYearController.clear();
    selectedEvents.clear();
    profileImage.value = null;
    coverImage.value = null;
    selectedRoles.value = ServiceProviderTypeModel();
    _isInitialized.value = false;
    _isEditMode.value = false;
    _markers.clear();
    update();
  }

  /// Handle image picking for both profile and cover images
  Future<void> pickImage({bool isCoverImage = false}) async {
    await _requestPermissions();

    final ImagePicker picker = ImagePicker();
    final ImageSource? source = await _showImagePickerOptions();

    if (source != null) {
      final XFile? pickedFile = await picker.pickImage(source: source);
      if (pickedFile != null) {
        if (isCoverImage) {
          coverImage.value = File(pickedFile.path);
        } else {
          profileImage.value = File(pickedFile.path);
        }
      }
    }
  }

  Future<void> pickCoverImage() async {
    await pickImage(isCoverImage: true);
  }

  Future<void> _requestPermissions() async {
    final cameraStatus = await Permission.camera.request();
    final storageStatus = await Permission.storage.request();

    if (cameraStatus.isDenied || storageStatus.isDenied) {
      _logger.w('Camera or storage permission denied');
    }
  }

  Future<ImageSource?> _showImagePickerOptions() async {
    return await Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(20),
        color: AppColors.primary,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Choose Image Source",
              style: getTextStyle(color: AppColors.textColor, fontSize: 20),
            ),
            const SizedBox(height: 20),
            ListTile(
              leading: Icon(Icons.camera_alt, color: AppColors.textColor),
              title: Text(
                "Camera",
                style: getTextStyle(color: AppColors.textColor),
              ),
              onTap: () => Get.back(result: ImageSource.camera),
            ),
            ListTile(
              leading: Icon(Icons.image, color: AppColors.textColor),
              title: Text(
                "Gallery",
                style: getTextStyle(color: AppColors.textColor),
              ),
              onTap: () => Get.back(result: ImageSource.gallery),
            ),
          ],
        ),
      ),
    );
  }

  /// Map related methods
  void onMapCreated(GoogleMapController controller) {
    _mapController = controller;
    _isMapCreated = true;
    update();
  }

  void initMarkers({LatLng? location, String? title}) {
    final pos = location ?? _center;
    _markers.clear();
    _markers.add(
      Marker(
        markerId: const MarkerId('searched_location'),
        position: pos,
        infoWindow: InfoWindow(
          title: title ?? 'Selected Location',
          snippet: 'Search result',
        ),
        icon: BitmapDescriptor.defaultMarker,
      ),
    );
    update();
  }

  Future<void> searchLocation(String place) async {
    if (!_isMapCreated) return;

    try {
      final locations = await locationFromAddress(place);
      if (locations.isNotEmpty) {
        final loc = locations.first;
        final target = LatLng(loc.latitude, loc.longitude);
        await _mapController.animateCamera(
          CameraUpdate.newLatLngZoom(target, 16),
        );
        initMarkers(location: target, title: place);
      }
    } catch (e) {
      Get.snackbar('Error', 'Location not found: ${e.toString()}');
    }
  }

  /// Role and event selection methods
  void updateRoles(String spTypeId) {
    selectedRoles.value = spTypeController.types.firstWhere(
      (element) => element.id == spTypeId,
    );
    update();
  }

  void toggleEventSelection(String eventId) {
    if (selectedEvents.contains(eventId)) {
      selectedEvents.remove(eventId);
    } else {
      selectedEvents.add(eventId);
    }
    update();
  }

  /// API related methods
  Future<void> getEventPreferences() async {
    eventPreferenceList.clear();
    isLoadingEventPreference.value = true;
    update();

    await SpAuthController.getUserInformation();

    final NetworkResponse response = await Get.find<NetworkCaller>().getRequest(
      Urls.getEventPreference,
    );

    if (response.isSuccess) {
      eventPreferenceList.addAll(
        (response.responseData['data'] as List)
            .map((e) => EventPreferenceModel.fromJson(e))
            .toList(),
      );
    } else {
      Get.snackbar('Error', response.errorMessage);
    }

    isLoadingEventPreference.value = false;
    update();
  }

  // -------------------------------------------------
  //* Profile Setup start
  // -------------------------------------------------
  Future<bool> spProfileSetup() async {
    EasyLoading.show(status: 'Loading...');
    isLoadingServiceProviderSetup.value = true;
    update();

    final response = await Get.find<NetworkCaller>().multipartRequest(
      url: Urls.uploadServiceProviderProfile,
      formFields: _getProfileFormFields(),
      files: await _getProfileFiles(),
    );

    final bool isSuccess = await _handleProfileResponse(
      response,
      isUpdate: false,
    );

    isLoadingServiceProviderSetup.value = false;
    update();
    return isSuccess;
  }
  // profile setup end

  // -------------------------------------------------
  //* Profile Update start
  // -------------------------------------------------
  Future<bool> spProfileUpdate() async {
    bool isSuccess = false;
    EasyLoading.show(status: 'Loading...');
    isLoadingServiceProviderUpdate.value = true;
    update();

    await SpAuthController.getUserInformation();

    Map<String, String> formFields = {
      'eventPreferenceIds': jsonEncode(selectedEvents),
      'serviceTypeId': selectedRoles.value.id ?? '',
      'description': descriptionController.text,
      'experience': experienceYearController.text,
      'location': locationController.text,
      'name': nameController.text,
      "userName": usernameController.text,
    };

    final response = await Get.find<NetworkCaller>().multipartRequest(
      isPatchRequest: true,
      url: Urls.updateServiceProviderProfile,
      formFields: formFields,
      files: await _getProfileFiles(),
    );

    if (response.isSuccess) {
      await Get.find<SpGetUserInfoController>().spGetUserInfo();
      isSuccess = true;
    } else {
      isSuccess = false;
    }

    isLoadingServiceProviderUpdate.value = false;
    update();
    return isSuccess;
  }

  Map<String, String> _getProfileFormFields() {
    return {
      'eventPreferenceIds': jsonEncode(selectedEvents),
      'serviceProviderRole': selectedRoles.value.id ?? '',
      'description': descriptionController.text,
      'experience': experienceYearController.text,
      // 'userId': SpAuthController.spUser?.id ?? '',
      'location': locationController.text,
      'name': usernameController.text,
      if (_isEditMode.value) 'userName': usernameController.text,
    };
  }

  Future<List<http.MultipartFile>> _getProfileFiles() async {
    final files = <http.MultipartFile>[];

    if (profileImage.value != null) {
      files.add(
        await http.MultipartFile.fromPath('image', profileImage.value!.path),
      );
    }
    if (coverImage.value != null) {
      files.add(
        await http.MultipartFile.fromPath('coverPhoto', coverImage.value!.path),
      );
    }

    return files;
  }

  Future<bool> _handleProfileResponse(
    NetworkResponse response, {
    required bool isUpdate,
  }) async {
    if (response.isSuccess) {
      final ProfileSetupModel profileSetupModel = ProfileSetupModel.fromJson(
        response.responseData['data'],
      );

      await SpAuthController.updateToken(
        token: profileSetupModel.accessToken ?? '',
      );

      await Get.find<SpGetUserInfoController>().spGetUserInfo();
      EasyLoading.dismiss();
      await Get.find<SpGetAllWorksController>().getAllWorks();
      Get.offAll(() => const SpBottomNavBarScreen());

      EasyLoading.showSuccess(
        isUpdate ? 'Profile updated successfully' : 'Profile setup successful',
      );
      return true;
    } else {
      EasyLoading.dismiss();
      EasyLoading.showError(response.errorMessage);
      return false;
    }
  }
}
