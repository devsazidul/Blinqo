import 'dart:convert';
import 'dart:io';
import 'package:blinqo/core/urls/endpoint.dart';
import 'package:blinqo/features/role/event_planner/profile_setup/model/event_preference_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileSetupController extends GetxController {

  TextEditingController namecontroller = TextEditingController();
  TextEditingController locationcontroller = TextEditingController();
 
  RxString selectedGender = 'Select Gender'.obs;
  RxString selectedImagePath = ''.obs;
  RxList<String> selectedEvents = <String>[].obs;

  RxBool isLoadingEventPreference = false.obs;
  RxList<EEventPreferenceModel> eventPreferenceList = <EEventPreferenceModel>[].obs;

  final ImagePicker _imagePicker = ImagePicker();

  @override
  void onInit() {
    super.onInit();
    fetchEventPreferences();
  }

  // Gender Selection
  void updateGender(String gender) {
    selectedGender.value = gender;
  }


  /// ------------------------------------------------
  /// Event Preference
  /// ------------------------------------------------
  // RxBool isLoadingEventPreference = false.obs;
  // final RxList<EEventPreferenceModel> eventPreferenceList =
  //     <EEventPreferenceModel>[].obs;

  // Future<bool> getEventPreferences() async {
  //   eventPreferenceList.clear();
  //   bool isSuccess = false;
  //   isLoadingEventPreference.value = true;
  //   update();

  //   await SpAuthController.getUserInformation();
  //   debugPrint('Token after reload: ${SpAuthController.token}');

  //   final SpNetworkResponse response = await Get.find<SpNetworkCaller>()
  //       .getRequest(Urls.getEventPreference);

  //   if (response.isSuccess) {
  //     eventPreferenceList.addAll(
  //       (response.responseData['data'] as List)
  //           .map((e) => EEventPreferenceModel.fromJson(e))
  //           .toList(),
  //     );
  //     update();
  //     isSuccess = true;
  //   } else {
  //     Get.snackbar('Error', response.errorMessage);
  //   }
  //   isLoadingEventPreference.value = false;
  //   update();
  //   return isSuccess;
  // }

  // Event Selection
  void toggleEventSelection(String eventId) {
    if (selectedEvents.contains(eventId)) {
      selectedEvents.remove(eventId); // Deselect
    } else {
      selectedEvents.add(eventId); // Select
    }
    update(); // Trigger the UI rebuild
  }

  // Image Handling
  Future<void> pickImage(ImageSource source) async {
    try {
      final XFile? pickedFile = await _imagePicker.pickImage(source: source);
      if (pickedFile != null) {
        selectedImagePath.value = pickedFile.path;
      } else {
        Get.snackbar("No Image Selected", "Please select an image.");
      }
    } catch (e) {
      Get.snackbar("Error", "Failed to pick an image: $e");
    }
  }

  Future<void> requestPermissions() async {
    PermissionStatus cameraStatus = await Permission.camera.request();
    PermissionStatus storageStatus;
    if (Platform.isAndroid) {
      if (await Permission.photos.isDenied) {
        storageStatus = await Permission.photos.request();
      } else {
        storageStatus = PermissionStatus.granted;
      }
    } else {
      storageStatus = await Permission.storage.request();
    }

    if (cameraStatus.isDenied || storageStatus.isDenied) {
      debugPrint("Permission denied");
      Get.snackbar("Permission Denied", "Please grant camera and storage permissions to proceed.");
    } else {
      debugPrint("Permissions granted");
    }
  }

  // Fetch Event Preferences (This will populate the eventPreferenceList)
  Future<void> fetchEventPreferences() async {
    try {
      isLoadingEventPreference.value = true;
      EasyLoading.show(status: "Loading events...");
      final prefs = await SharedPreferences.getInstance();
      final accessToken = prefs.getString('access_token') ?? '';

      if (accessToken.isEmpty) {
        throw Exception('Authentication token not found');
      }

      final response = await http.get(
        Uri.parse(Urls.getEventPreference),
        headers: {
          'Authorization': 'Bearer $accessToken',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        if (responseData['success'] == true) {
          eventPreferenceList.assignAll(
            (responseData['data'] as List)
                .map((item) => EEventPreferenceModel.fromJson(item))
                .toList(),
          );
        } else {
          throw Exception('Failed to fetch event preference');
        }
      } else {
        throw Exception('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      Get.snackbar("Error", "Failed to load events: ${e.toString()}");
      debugPrint("Error fetching events: $e");
    } finally {
      isLoadingEventPreference.value = false;
      EasyLoading.dismiss();
    }
  }

  // Function to submit the profile setup data to the server
 Future<void> submitProfileSetup() async {
    try {
      debugPrint("1. Showing loading indicator");
      EasyLoading.show(status: "Saving profile setup...");

      debugPrint("2. Getting SharedPreferences instance");
      final prefs = await SharedPreferences.getInstance();
      final accessToken = prefs.getString('access_token') ?? '';
      debugPrint("Access token: $accessToken");
      
      final id = selectedEvents.isNotEmpty ? selectedEvents.first : '';
      debugPrint("id: $id");

      if (accessToken.isEmpty) {
        debugPrint("Error: Authentication token not found");
        throw Exception('Authentication token not found');
      }

      debugPrint("3. Preparing profile data");
      final Map<String, dynamic> profileData = {
        'name': namecontroller.text,
        'gender': selectedGender.value,
        'location': locationcontroller.text,
        'eventPreferenceIds': id,
        'image': selectedImagePath.value.isNotEmpty ? await _uploadImage() : null,
      };
      debugPrint("Selected image path: ${selectedImagePath.value}");
      debugPrint("Profile data to be sent: $profileData");

      debugPrint("4. Making HTTP POST request to ${Urls.plannerprofilesetup}");
      final response = await http.post(
        Uri.parse(Urls.plannerprofilesetup),
        headers: {
          'Authorization': 'Bearer $accessToken',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(profileData),
      );
      debugPrint("Response status code: ${response.statusCode}");
      debugPrint("Response body: ${response.body}");

      if (response.statusCode == 200) {
        debugPrint("5. Processing successful response");
        final responseData = jsonDecode(response.body);
        if (responseData['success'] == true) {
          debugPrint("Profile setup successful");
          Get.snackbar("Success", "Profile setup completed successfully.");
        } else {
          debugPrint("Server returned success: false");
          throw Exception('Failed to save profile setup');
        }
      } else {
        debugPrint("Server returned error status code");
        throw Exception('Failed to submit data: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint("6. Caught exception: $e");
      EasyLoading.dismiss();
      Get.snackbar("Error", "Failed to save profile setup: ${e.toString()}");
      debugPrint("Error submitting profile setup: $e");
    } finally {
      debugPrint("7. Dismissing loading indicator");
      EasyLoading.dismiss();
    }
  }

  // Function to upload the profile image (if available)
  Future<String?> _uploadImage() async {
    if (selectedImagePath.value.isNotEmpty) {
      final request = http.MultipartRequest('POST', Uri.parse(Urls.plannerprofilesetup)); // Use the actual upload image URL
      request.files.add(await http.MultipartFile.fromPath('file', selectedImagePath.value));

      final response = await request.send();

      if (response.statusCode == 200) {
        final responseData = await response.stream.bytesToString();
        final responseJson = jsonDecode(responseData);
        return responseJson['image_url']; // Assuming the image URL is returned in the response
      } else {
        throw Exception('Failed to upload image');
      }
    }
    return null;
  }

}
