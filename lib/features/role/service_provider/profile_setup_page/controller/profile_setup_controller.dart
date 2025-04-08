import 'dart:io';

import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class ProfileSetupController extends GetxController {
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
}
