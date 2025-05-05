import 'dart:io';

import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/urls/endpoint.dart';
import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:blinqo/features/role/service_provider/auth/controller/auth_controller.dart';
import 'package:blinqo/features/role/service_provider/profile_setup_page/model/event_preference_model.dart';
import 'package:blinqo/features/role/service_provider/services/sp_network_caller.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';
import 'package:permission_handler/permission_handler.dart';

class SpProfileSetupController extends GetxController {
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController experienceYearController = TextEditingController();
  late GoogleMapController mapController;
  final LatLng center = const LatLng(37.7749, -122.4194);
  Set<Marker> markers = {};
  Set<Marker> get mapMarkers => markers;
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
    "Trade Shows",
  ];

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
  var coverImage = Rx<File?>(null); // To hold the selected cover image

  Future<void> pickCoverImage() async {
    await coverrequestPermissions();

    final ImagePicker picker = ImagePicker();
    final ImageSource? source = await covershowImagePickerOptions();

    if (source != null) {
      final XFile? pickedFile = await picker.pickImage(source: source);

      if (pickedFile != null) {
        coverImage.value = File(pickedFile.path);
      } else {
        debugPrint("No image selected");
      }
    }
  }

  Future<void> coverrequestPermissions() async {
    PermissionStatus cameraStatus = await Permission.camera.request();
    PermissionStatus storageStatus = await Permission.storage.request();

    if (cameraStatus.isDenied || storageStatus.isDenied) {
      debugPrint("Permission denied");
    } else {
      debugPrint("Permission granted");
    }
  }

  Future<ImageSource?> covershowImagePickerOptions() async {
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
    debugPrint('Selected events: $selectedEvents');
    update();
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

  void onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  Future<void> searchLocation(String place) async {
    try {
      List<Location> locations = await locationFromAddress(place);
      if (locations.isNotEmpty) {
        final loc = locations.first;
        final target = LatLng(loc.latitude, loc.longitude);
        mapController.animateCamera(CameraUpdate.newLatLngZoom(target, 16));
        initMarkers(location: target, title: place);
      }
    } catch (e) {
      Get.snackbar('Location not found', 'Try a more specific name');
    }
  }

  /// ------------------------------------------------
  RxBool isLoadingEventPreference = false.obs;
  final RxList<EventPreferenceModel> eventPreferenceList =
      <EventPreferenceModel>[].obs;

  Future<void> getEventPreferences() async {
    isLoadingEventPreference.value = true;
    update();

    final response = await Get.find<SpNetworkCaller>().getRequest(
      Urls.getEventPreference,
    );

    if (response.isSuccess) {
      try {
        final responseModel = ResponseModel.fromJson(response.responseData);
        eventPreferenceList.value = responseModel.data;
        update();
        print('Loaded ${eventPreferenceList.length} event preferences');
      } catch (e) {
        Get.snackbar('Error', 'Failed to parse event preferences: $e');
      }
    } else {
      Get.snackbar('Error', response.errorMessage);
    }
    isLoadingEventPreference.value = false;
  }

  // Profile Setup
  // api_service.dart

  Future<void> uploadServiceProviderProfile() async {
    Logger logger = Logger();
    final uri = Uri.parse(
      '${Urls.baseUrl}${"/profile/service-provider-setup"}',
    );
    final request = http.MultipartRequest('POST', uri);
    Map<String, String> formFields = {
      'eventPreferenceIds': selectedEvents.join(','),
      'serviceProviderRole': selectedRoles.value,
      'description': descriptionController.text,
      'experience': experienceYearController.text,
      'userId': SpAuthController.userModel?.id ?? '',
      'location': locationController.text,
      'name': nameController.text,
    };

    // Add authorization header
    request.headers['Authorization'] = SpAuthController.token ?? '';
    // Content-Type is automatically set by MultipartRequest, so no need to add manually

    // Add form fields
    request.fields.addAll(formFields);

    // Add image file
    if (profileImage.value != null) {
      final imageFile = await http.MultipartFile.fromPath(
        'image',
        profileImage.value!.path,
      );
      request.files.add(imageFile);
    }

    // Add cover photo file
    if (coverImage.value != null) {
      final coverPhoto = await http.MultipartFile.fromPath(
        'coverPhoto',
        coverImage.value!.path,
      );
      request.files.add(coverPhoto);
    }

    logger.d(request.fields);
    logger.d(request.files);
    try {
      final response = await request.send();
      logger.d(response.statusCode);
      if (response.statusCode == 200) {
        final respStr = await response.stream.bytesToString();
        logger.d(respStr);
        print('Upload successful: $respStr');
      } else {
        final error = await response.stream.bytesToString();
        logger.d(
          'Upload failed with status: ${response.statusCode}, Error: $error',
        );
      }
    } catch (e) {
      logger.d('Error during upload: $e');
    }
  }
}
