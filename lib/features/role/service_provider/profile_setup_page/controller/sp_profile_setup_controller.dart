import 'dart:convert';
import 'dart:io';

import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/urls/endpoint.dart';
import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:blinqo/features/role/service_provider/bottom_nav_bar/screen/sp_bottom_nav_bar.dart';
import 'package:blinqo/features/role/service_provider/common/controller/auth_controller.dart';
import 'package:blinqo/features/role/service_provider/common/controller/sp_get_user_info_controller.dart';
import 'package:blinqo/features/role/service_provider/profile_setup_page/model/event_preference_model.dart';
import 'package:blinqo/features/role/service_provider/profile_setup_page/model/profile_setup_model.dart';
import 'package:blinqo/features/role/service_provider/services/sp_network_caller.dart';
import 'package:blinqo/features/role/service_provider/services/sp_network_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';
import 'package:permission_handler/permission_handler.dart';

class SpProfileSetupController extends GetxController {
  final Logger logger = Logger();
  final formKey = GlobalKey<FormState>();

  TextEditingController profileNameController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController experienceYearController = TextEditingController();
  // late GoogleMapController mapController;
  final LatLng center = const LatLng(37.7749, -122.4194);
  Set<Marker> markers = {};
  var isInitialized = false.obs;
  var isEditMode = false.obs;

  var profileImage = Rx<File?>(null);

  void initializeEditMode() {
    if (isEditMode.value && !isInitialized.value) {
      profileNameController.text = SpAuthController.spUser?.name ?? "";
      usernameController.text = SpAuthController.spUser?.profile?.name ?? "";
      selectedRoles.value =
          SpAuthController.spUser?.profile?.serviceProviderRole ??
          ServiceProviderRole.photographer;
      locationController.text =
          SpAuthController.spUser?.profile?.location ?? "";
      descriptionController.text =
          SpAuthController.spUser?.profile?.description ?? "";
      experienceYearController.text =
          SpAuthController.spUser?.profile?.experience?.toString() ?? "";
      selectedEvents.addAll(
        SpAuthController.spUser?.profile?.eventPreference?.map(
              (e) => e.id ?? '',
            ) ??
            [],
      );
      isInitialized.value = true;
    }
  }

  void setEditMode(bool value) {
    isEditMode.value = value;
    if (value) {
      print('isEditMode: $isEditMode');
      initializeEditMode();
    }
  }

  Future<void> pickImage() async {
    await requestPermissions();

    final ImagePicker picker = ImagePicker();

    final ImageSource? source = await showPickerOption();

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

  Future<ImageSource?> showPickerOption() async {
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
  var coverImage = Rx<File?>(null); // To hold the selected cover image

  Future<void> pickCoverImage() async {
    await coverRequestPermissions();

    final ImagePicker picker = ImagePicker();
    final ImageSource? source = await coverShowImagePickerOptions();

    if (source != null) {
      final XFile? pickedFile = await picker.pickImage(source: source);

      if (pickedFile != null) {
        coverImage.value = File(pickedFile.path);
      } else {
        debugPrint("No image selected");
      }
    }
  }

  Future<void> coverRequestPermissions() async {
    PermissionStatus cameraStatus = await Permission.camera.request();
    PermissionStatus storageStatus = await Permission.storage.request();

    if (cameraStatus.isDenied || storageStatus.isDenied) {
      debugPrint("Permission denied");
    } else {
      debugPrint("Permission granted");
    }
  }

  Future<ImageSource?> coverShowImagePickerOptions() async {
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
              leading: Icon(Icons.camera_alt),
              title: Text("Camera"),
              onTap: () {
                Get.back(result: ImageSource.camera);
              },
            ),
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

  // google map
  void initMarkers({LatLng? location, String? title}) {
    final pos = location ?? center;
    markers.clear();
    markers.add(
      Marker(
        markerId: MarkerId('searched_location'),
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

  late GoogleMapController mapController;
  bool isMapCreated = false;

  void onMapCreated(GoogleMapController controller) {
    mapController = controller;
    isMapCreated = true;
    update();
  }

  // Always check if map is created before using controller
  Future<void> searchLocation(String place) async {
    if (!isMapCreated) return;

    try {
      List<Location> locations = await locationFromAddress(place);
      if (locations.isNotEmpty) {
        final loc = locations.first;
        final target = LatLng(loc.latitude, loc.longitude);
        await mapController.animateCamera(
          CameraUpdate.newLatLngZoom(target, 16),
        );
        initMarkers(location: target, title: place);
      }
    } catch (e) {
      Get.snackbar('Error', 'Location not found: ${e.toString()}');
    }
  }

  // void onMapCreated(GoogleMapController controller) {
  //   mapController = controller;
  // }

  // Future<void> searchLocation(String place) async {
  //   try {
  //     List<Location> locations = await locationFromAddress(place);
  //     Logger().i(locations);
  //     if (locations.isNotEmpty) {
  //       final loc = locations.first;
  //       final target = LatLng(loc.latitude, loc.longitude);
  //       mapController.animateCamera(CameraUpdate.newLatLngZoom(target, 16));
  //       initMarkers(location: target, title: place);
  //     }
  //   } catch (e) {
  //     Get.snackbar('Location not found', 'Try a more specific name');
  //   }
  // }

  Set<Marker> get mapMarkers => markers;
  var selectedRoles = ServiceProviderRole.photographer.obs;

  var roles = ServiceProviderRole.roles;

  var selectedEvents = <String>[].obs;

  // selected roles
  void updateRoles(String newRole) {
    selectedRoles.value = newRole;
  }

  void toggleEventSelection(String eventId) {
    if (selectedEvents.contains(eventId)) {
      selectedEvents.remove(eventId);
    } else {
      selectedEvents.add(eventId);
    }
    debugPrint('Selected events: $selectedEvents');
    update();
  }

  /// ------------------------------------------------
  /// Event Preference
  /// ------------------------------------------------
  RxBool isLoadingEventPreference = false.obs;
  final RxList<EventPreferenceModel> eventPreferenceList =
      <EventPreferenceModel>[].obs;

  Future<void> getEventPreferences() async {
    eventPreferenceList.clear();
    isLoadingEventPreference.value = true;
    update();

    await SpAuthController.getUserInformation();

    final SpNetworkResponse response = await Get.find<SpNetworkCaller>()
        .getRequest(Urls.getEventPreference);

    if (response.isSuccess) {
      eventPreferenceList.addAll(
        (response.responseData['data'] as List)
            .map((e) => EventPreferenceModel.fromJson(e))
            .toList(),
      );
      update();
    } else {
      Get.snackbar('Error', response.errorMessage);
    }
    isLoadingEventPreference.value = false;
    update();
  }

  RxBool isLoadingServiceProviderSetup = false.obs;

  /// ------------------------------------------------
  /// Profile Setup
  /// ------------------------------------------------
  Future<bool> spProfileSetup() async {
    EasyLoading.show(status: 'Loading...');
    bool isSuccess = false;
    isLoadingServiceProviderSetup.value = true;
    update();

    final response = await Get.find<SpNetworkCaller>().multipartRequest(
      url: Urls.uploadServiceProviderProfile,
      formFields: {
        'eventPreferenceIds': jsonEncode(selectedEvents),
        'serviceProviderRole': selectedRoles.value,
        'description': descriptionController.text,
        'experience': experienceYearController.text,
        'userId': SpAuthController.spUser?.id ?? '',
        'location': locationController.text,
        'name': profileNameController.text,
        'userName': usernameController.text,
      },
      files: [
        if (profileImage.value != null)
          await http.MultipartFile.fromPath('image', profileImage.value!.path),
        if (coverImage.value != null)
          await http.MultipartFile.fromPath(
            'coverPhoto',
            coverImage.value!.path,
          ),
      ],
    );

    if (response.isSuccess) {
      /// If profile setup is successful, then update the token and call the
      /// get user info api to get the updated user information
      final ProfileSetupModel profileSetupModel = ProfileSetupModel.fromJson(
        response.responseData['data'],
      );
      //* update token
      await SpAuthController.updateToken(
        token: profileSetupModel.accessToken ?? '',
      );

      //* create profile info model
      // final ProfileInfoModel profileInfoModel = ProfileInfoModel.fromJson(
      //   response.responseData['data'],
      // );

      //* save user information
      // await SpAuthController.saveUserInformation(
      //   accessToken: profileSetupModel.accessToken,
      //   spUser: SpUser(
      //     id: profileInfoModel.id,
      //     email: profileInfoModel.email,
      //     phone: profileInfoModel.phone,
      //     name: profileInfoModel.name,
      //     role: profileInfoModel.role,
      //     isVerified: profileInfoModel.isVerified,
      //     createdAt: profileInfoModel.createdAt,
      //     updatedAt: profileInfoModel.updatedAt,
      //     profile: profileInfoModel,
      //   ),
      // );

      // await SpAuthController.updateUserInformation(
      //   profileId: profileInfoModel.id,
      //   isProfileCreated: true,
      // );

      await Get.find<SpGetUserInfoController>().spGetUserInfo();
      EasyLoading.dismiss();
      Get.offAll(SpBottomNavBarScreen());
      isSuccess = true;
      EasyLoading.showSuccess('Profile setup successful');
    } else {
      EasyLoading.dismiss();
      EasyLoading.showError(response.errorMessage);
      isSuccess = false;
    }
    isLoadingServiceProviderSetup.value = false;
    update();
    return isSuccess;
  }

  RxBool isLoadingServiceProviderUpdate = false.obs;

  /// ------------------------------------------------
  /// Profile update
  /// ------------------------------------------------
  Future<bool> spProfileUpdate() async {
    EasyLoading.show(status: 'Loading...');
    bool isSuccess = false;
    isLoadingServiceProviderUpdate.value = true;
    update();

    await SpAuthController.getUserInformation();

    final response = await Get.find<SpNetworkCaller>().multipartRequest(
      isPatchRequest: true,
      url: Urls.updateServiceProviderProfile(
        SpAuthController.spUser?.profile?.id ?? '',
      ),
      formFields: {
        'eventPreferenceIds': jsonEncode(selectedEvents),
        'serviceProviderRole': selectedRoles.value,
        'description': descriptionController.text,
        'experience': experienceYearController.text,
        // 'userId': SpAuthController.userModel?.id ?? '',
        'location': locationController.text,
        'name': profileNameController.text,
        'userName': usernameController.text,
      },
      files: [
        if (profileImage.value != null)
          await http.MultipartFile.fromPath('image', profileImage.value!.path),
        if (coverImage.value != null)
          await http.MultipartFile.fromPath(
            'coverPhoto',
            coverImage.value!.path,
          ),
      ],
    );

    if (response.isSuccess) {
      await Get.find<SpGetUserInfoController>().spGetUserInfo();
      EasyLoading.dismiss();
      Get.offAll(SpBottomNavBarScreen());
      isSuccess = true;
      EasyLoading.showSuccess('Profile updated successfully');
    } else {
      EasyLoading.dismiss();
      EasyLoading.showError(response.errorMessage);
      isSuccess = false;
    }

    isLoadingServiceProviderUpdate.value = false;
    update();
    return isSuccess;
  }

  void clearAllData() {
    // eventPreferenceList.clear();
    usernameController.clear();
    descriptionController.clear();
    locationController.clear();
    experienceYearController.clear();
    selectedEvents.clear();
    profileImage.value = null;
    coverImage.value = null;
    update();
  }

  @override
  void dispose() {
    clearAllData();
    profileNameController.dispose();
    usernameController.dispose();
    descriptionController.dispose();
    locationController.dispose();
    experienceYearController.dispose();
    super.dispose();
  }
}

class ServiceProviderRole {
  static const String photographer = "PHOTOGRAPHER";
  static const String videographer = "VIDEOGRAPHER";
  static const String djBand = "DJ_BAND";
  static const String catering = "CATERING";
  static const String entertainer = "ENTERTAINER";

  static const List<String> roles = [
    photographer,
    videographer,
    djBand,
    catering,
    entertainer,
  ];
}
