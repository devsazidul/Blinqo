import 'dart:convert';
import 'dart:io';
import 'package:blinqo/core/urls/endpoint.dart';
import 'package:blinqo/features/role/event_planner/auth/auth_service/auth_service.dart';
import 'package:blinqo/features/role/event_planner/bottom_nav_bar/screen/event_bottom_nav_bar.dart';
import 'package:blinqo/features/role/event_planner/profile_setup/model/event_preference_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:http_parser/http_parser.dart';

class ProfileSetupController extends GetxController {
  TextEditingController namecontroller = TextEditingController();
  TextEditingController locationcontroller = TextEditingController();

  RxString selectedGender = 'MALE'.obs;
  RxString selectedImagePath = ''.obs;
  RxList<String> selectedEvents = <String>[].obs;
  RxString nameError = ''.obs;

  RxBool isLoadingEventPreference = false.obs;
  RxList<EEventPreferenceModel> eventPreferenceList =
      <EEventPreferenceModel>[].obs;

  final ImagePicker _imagePicker = ImagePicker();

  @override
  void onInit() {
    super.onInit();
    fetchEventPreferences();
  }

  void updateGender(String gender) {
    selectedGender.value = gender;
  }

  void toggleEventSelection(String eventId) {
    if (selectedEvents.contains(eventId)) {
      selectedEvents.remove(eventId);
    } else {
      selectedEvents.add(eventId);
    }
    update();
  }

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

  //==============================================================================

  Future<void> fetchEventPreferences() async {
    try {
      isLoadingEventPreference.value = true;
      EasyLoading.show(status: "Loading events...");

      final accessToken = await AuthService.getToken();

      if (accessToken == null || accessToken.isEmpty) {
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

  //===============================================================================

  Future<void> submitProfileSetup() async {
    debugPrint("====== [START] submitProfileSetup() ======");
    debugPrint("[1] Showing loading indicator");
    EasyLoading.show(status: 'Creating profile...');

    try {
      // --- Authentication Data Retrieval ---
      debugPrint("[2] Starting authentication data retrieval");
      debugPrint("[3] Getting access token from AuthService");
      final accessToken = await AuthService.getToken();
      debugPrint("[4] Access Token retrieved: ${accessToken ?? 'NULL'}");

      debugPrint("[5] Getting user ID from AuthService");
      var userId = await AuthService.getUserId();
      debugPrint("[6] Initial User ID from storage: ${userId ?? 'NULL'}");

      // --- Validation ---
      debugPrint("[7] Validating authentication data");
      if (accessToken == null || accessToken.isEmpty) {
        debugPrint("[8] ERROR: No access token found");
        throw Exception('Not authenticated - no access token found');
      }

      // --- User ID Fallback ---
      if (userId == null || userId.isEmpty) {
        debugPrint(
          "[9] User ID not found in storage, trying to extract from token",
        );
        userId = _extractUserIdFromToken(accessToken);
        debugPrint("[10] Extracted User ID from token: ${userId ?? 'NULL'}");
        if (userId == null || userId.isEmpty) {
          debugPrint("[11] ERROR: User ID not found in storage or token");
          throw Exception('User ID not found in storage or token');
        }
      }

      // --- Request Preparation ---
      debugPrint("[12] Creating multipart request");
      var request = http.MultipartRequest(
        'POST',
        Uri.parse(Urls.plannerprofilesetup),
      );
      debugPrint("[13] Request created for URL: ${Urls.plannerprofilesetup}");

      debugPrint("[14] Setting authorization header");
      request.headers['Authorization'] = 'Bearer $accessToken';
      debugPrint("[15] Headers set: ${request.headers}");

      // --- Image Handling ---
      if (selectedImagePath.value.isNotEmpty) {
        debugPrint("[16] Image selected, path: ${selectedImagePath.value}");
        File imageFile = File(selectedImagePath.value);
        debugPrint("[17] Image file exists: ${imageFile.existsSync()}");

        String extension = imageFile.path.split('.').last.toLowerCase();
        debugPrint("[18] Detected image extension: $extension");

        if (!['jpg', 'jpeg', 'png'].contains(extension)) {
          debugPrint("[19] ERROR: Invalid image format");
          throw Exception('Only .jpg, .jpeg, or .png images are allowed');
        }

        // Add image file to multipart request
        request.files.add(
          await http.MultipartFile.fromPath(
            'image', // Field name for the image
            imageFile.path,
            contentType: MediaType('image', extension),
          ),
        );
        debugPrint("[20] Image file added to request");
      }

      // --- Add Form Fields ---
      debugPrint("[21] Adding form fields to request");
      request.fields.addAll({
        'name': namecontroller.text.trim(),
        'gender': selectedGender.value,
        'location': locationcontroller.text.trim(),
        'eventPreferenceIds': selectedEvents.join(','),
        'userId': userId,
      });
      debugPrint("[22] Form fields added: ${request.fields}");

      // --- Request Execution ---
      debugPrint("[23] Sending request to server");
      var response = await request.send();
      debugPrint("[24] Request sent, waiting for response...");

      debugPrint("[25] Reading response stream");
      final respStr = await response.stream.bytesToString();
      debugPrint("[26] Raw response: $respStr");

      final responseData = json.decode(respStr);
      debugPrint("[27] Parsed response data: $responseData");

      // Extract actual image URL from response if available
      if (responseData['data'] != null &&
          responseData['data']['imageUrl'] != null) {
        final serverImageUrl = responseData['data']['imageUrl'];
        debugPrint("[28] Server returned image URL: $serverImageUrl");
      }

      debugPrint("[29] Response status code: ${response.statusCode}");

      // --- Response Handling ---
      if (response.statusCode == 200 || response.statusCode == 201) {
        debugPrint("[30] Request successful (200/201)");
        if (responseData['success'] == true) {
          debugPrint("[31] Server returned success=true");
          debugPrint("[32] Navigating to EventBottomNavBar");
          Get.offAll(() => EventBottomNavBar());
          EasyLoading.showSuccess('Profile setup completed successfully');
        } else {
          debugPrint("[31] ERROR: Server returned success=false");
          debugPrint("[32] Error message: ${responseData['message']}");
          throw Exception(responseData['message'] ?? 'Profile setup failed');
        }
      } else {
        debugPrint("[30] ERROR: Server returned status ${response.statusCode}");
        debugPrint("[31] Error message: ${responseData['message']}");
        throw Exception(
          responseData['message'] ?? 'Server error: ${response.statusCode}',
        );
      }
    } catch (e, stackTrace) {
      debugPrint("[ERROR] Exception occurred: $e");
      debugPrint("[STACK TRACE] $stackTrace");
      EasyLoading.showError('Please fill all fields');
    } finally {
      debugPrint("[34] Dismissing loading indicator");
      EasyLoading.dismiss();
      debugPrint("====== [END] submitProfileSetup() ======");
    }
  }

  //==============================================================================

  String? _extractUserIdFromToken(String token) {
    try {
      debugPrint("[TOKEN DECODING] Starting JWT token decoding");
      final parts = token.split('.');
      debugPrint("[TOKEN DECODING] Token parts count: ${parts.length}");

      if (parts.length != 3) {
        debugPrint("[TOKEN DECODING] ERROR: Invalid JWT format");
        return null;
      }

      final payload = parts[1];
      debugPrint("[TOKEN DECODING] Raw payload: $payload");

      final normalized = base64.normalize(payload);
      debugPrint("[TOKEN DECODING] Normalized payload: $normalized");

      final decoded = utf8.decode(base64.decode(normalized));
      debugPrint("[TOKEN DECODING] Decoded payload: $decoded");

      final payloadMap = json.decode(decoded) as Map<String, dynamic>;
      debugPrint("[TOKEN DECODING] Payload map: $payloadMap");

      final userId =
          payloadMap['sub']?.toString() ??
          payloadMap['userId']?.toString() ??
          payloadMap['id']?.toString();
      debugPrint("[TOKEN DECODING] Extracted user ID: ${userId ?? 'NULL'}");

      return userId;
    } catch (e) {
      debugPrint("[TOKEN DECODING] ERROR: $e");
      return null;
    }
  }
}
