import 'dart:convert';
import 'dart:io';
import 'package:blinqo/core/common/widgets/logger_view.dart';
import 'package:blinqo/core/urls/endpoint.dart';
import 'package:blinqo/features/role/venue_owner/authentication/model/login_model.dart';
import 'package:blinqo/features/role/venue_owner/owern_network_caller/even_authcontroller.dart';
import 'package:blinqo/features/role/venue_owner/owern_network_caller/owner_network_caller.dart';
import 'package:blinqo/features/role/venue_owner/profile_page/Model/amenity_model.dart';
import 'package:blinqo/features/role/venue_owner/profile_page/Model/event_decoration_model.dart';
import 'package:blinqo/features/role/venue_owner/widgets/even_image_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class VenueSetupController extends GetxController {
  TextEditingController venueNameTEController = TextEditingController();
  TextEditingController venueAddressTEController = TextEditingController();
  TextEditingController numberGuestsTEController = TextEditingController();

  //---------------Start Amenities ---------------//
  TextEditingController amenityController = TextEditingController();
  var availableAmenities = <EventAmenity>[].obs;
  var selectedAmenities = <EventAmenity>[].obs;
  var venueImage = Rx<File?>(null);
  var seatArrangementImage = Rx<File?>(null);

  //--------------- End Amenities ---------------//

  Rxn<VenuDecorationOption> venuDecorationOption = Rxn<VenuDecorationOption>();

  RxBool isLoading = false.obs;

  //----------- Start Venue Type --------------//
  RxString selectedVenueType = 'Select Venue Type'.obs;

  // Update the selected venue type
  void updateSelectedVenueType(String? newValue) {
    if (newValue != null) {
      selectedVenueType.value = newValue;
    }
  }

  //----------- End Venue Type --------------//

  final _logger = createLogger();

  // Selected options for each category
  RxList<String> selectedTableShapes = <String>[].obs;
  RxList<String> selectedSeatingStyles = <String>[].obs;
  RxList<String> selectedLightingStyles = <String>[].obs;
  RxList<String> selectedFlowerColors = <String>[].obs;
  RxList<String> selectedFlowerTypes = <String>[].obs;
  RxList<String> selectedFragrances = <String>[].obs;

  @override
  void onInit() async {
    super.onInit();
    await fetchDecorationOptions();
    await fetchAmenities();
  }

  // Generic method to handle image selection
  Future<void> pickImage(String imageType) async {
    await requestPermissions();

    final ImagePicker picker = ImagePicker();
    final ImageSource? source = await showPickrOption();

    if (source != null) {
      final XFile? pickedFile = await picker.pickImage(source: source);

      if (pickedFile != null) {
        if (imageType == 'venue') {
          venueImage.value = File(pickedFile.path);
        } else if (imageType == 'seat') {
          seatArrangementImage.value = File(pickedFile.path);
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

  Future<void> fetchDecorationOptions() async {
    _logger.i('Fetching venue decoration options');
    isLoading.value = true;
    try {
      var response = await OwnerNetworkCaller().getRequest(
        Url: Urls.eventDecorationEnum,
      );

      if (response.isSuccess) {
        _logger.i('Decoration options fetched successfully: ${response.body}');

        venuDecorationOption.value = VenuDecorationOption.fromJson(
          response.body,
        );
        // Filter options based on specific criteria
        selectedTableShapes.value =
            venuDecorationOption.value?.tableShape
                ?.where(
                  (option) => ['Round', 'Oval', 'Hexagonal'].contains(option),
                )
                .toList() ??
            [];
        selectedSeatingStyles.value =
            venuDecorationOption.value?.seatingStyle
                ?.where((option) => ['Banquet'].contains(option))
                .toList() ??
            [];
        selectedLightingStyles.value =
            venuDecorationOption.value?.lightingStyle
                ?.where((option) => ['Ambient'].contains(option))
                .toList() ??
            [];
        selectedFlowerColors.value =
            venuDecorationOption.value?.flowerColor
                ?.where((option) => ['White'].contains(option))
                .toList() ??
            [];
        selectedFlowerTypes.value =
            venuDecorationOption.value?.flowerType
                ?.where((option) => ['Roses'].contains(option))
                .toList() ??
            [];
        selectedFragrances.value =
            venuDecorationOption.value?.fragrance
                ?.where((option) => ['Floral Scents'].contains(option))
                .toList() ??
            [];
      } else {
        _logger.w(
          'Failed to fetch decoration options: ${response.errorMessage}',
        );
        EasyLoading.showError(
          'Failed to load options: ${response.errorMessage}',
        );
      }
    } catch (e) {
      _logger.e('Error fetching decoration options: $e');
      EasyLoading.showError('Error: $e');
    } finally {
      isLoading.value = false;
    }
  }

  void toggleSelection(String option, List<String> selectedList) {
    if (selectedList.contains(option)) {
      selectedList.remove(option);
    } else {
      selectedList.add(option);
    }
    _logger.d('Updated selection for $option: $selectedList');
  }

  //----------- End Decoration Options --------------//

  //----------- Start Venue Amenities --------------//
  Future<void> createAmenity() async {
    _logger.i('Creating amenity with name: ${amenityController.text.trim()}');
    final response = await OwnerNetworkCaller().postRequest(
      Url: Urls.createAmenity,
      body: {'name': amenityController.text.trim()},
    );
    if (response.isSuccess) {
      availableAmenities.add(EventAmenity.fromJson(response.body));
      update();
      _logger.i('Amenity created successfully: ${response.body}');
      EasyLoading.showSuccess('Amenity created successfully');
      amenityController.clear();
    } else {
      _logger.w('Failed to create amenity: ${response.errorMessage}');
      EasyLoading.showError(
        'Failed to create amenity: ${response.errorMessage}',
      );
    }
  }

  Future<void> fetchAmenities() async {
    final authToken = await EvenAuthController.getAuthToken();
    if (authToken?.isEmpty ?? true) {
      _logger.w('Auth token is missing or invalid.');
      EasyLoading.showError('Authorization token is missing.');
      return;
    }

    _logger.i('Fetching amenities from ${Urls.eventAmenities}');
    isLoading.value = true;

    try {
      final response = await http.get(
        Uri.parse(Urls.eventAmenities),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $authToken',
        },
      );

      _logger.i('Response: ${response.statusCode}, Body: ${response.body}');

      if (response.statusCode == 200) {
        List<EventAmenity> amenities =
            (jsonDecode(response.body) as List)
                .map((json) => EventAmenity.fromJson(json))
                .toList();
        availableAmenities.value =
            amenities.where((a) => !a.defaultSelected).toList();
        selectedAmenities.value =
            amenities.where((a) => a.defaultSelected).toList();
        await Future.delayed(Duration(milliseconds: 100));
        _logger.i('Fetched ${amenities.length} amenities.');
      } else {
        EasyLoading.showError(
          'Failed to load amenities: ${response.statusCode}',
        );
        _logger.w('Failed with status: ${response.statusCode}');
      }
    } catch (e) {
      EasyLoading.showError('Error fetching amenities: $e');
      _logger.e('Error: $e');
    } finally {
      isLoading.value = false;
    }
  }

  // Function to select an amenity
  void selectAmenity(EventAmenity amenity) {
    if (availableAmenities.contains(amenity)) {
      availableAmenities.remove(amenity);
      selectedAmenities.add(amenity);
    }
  }

  // Function to remove an amenity
  void removeAmenity(EventAmenity amenity) {
    if (selectedAmenities.contains(amenity)) {
      selectedAmenities.remove(amenity);
      availableAmenities.add(amenity);
    }
  }

  //----------- End Venue Amenities --------------//

  //------------- Start New Venue Create  --------------//

  Future<void> createNewVenue() async {
    _logger.i('Starting venue creation process');

    if (venueImage.value == null) {
      EasyLoading.showError('Please select venue image');
      return;
    }
    if (seatArrangementImage.value == null) {
      EasyLoading.showError('Please select seat arrangement image');
      return;
    }
    _logger.i(
      'Validation Passed : Venue Image: ${venueImage.value?.path}, Seat Arrangement Image: ${seatArrangementImage.value?.path} ',
    );
    EventUser? user = await EvenAuthController.getUserInfo();
    String? profileId = user?.profileId;
    _logger.i('User ID: $profileId');
    if (profileId == null) {
      EasyLoading.showError('Failed to fetch user ID');
      return;
    }
    if (selectedVenueType.value == 'Select Venue Type') {
      EasyLoading.showError('Please select venue type');
      return;
    }
    if (selectedTableShapes.isEmpty) {
      EasyLoading.showError('Please select at least one table shape');
      return;
    }
    if (selectedSeatingStyles.isEmpty) {
      EasyLoading.showError('Please select at least one seating style');
      return;
    }
    if (selectedLightingStyles.isEmpty) {
      EasyLoading.showError('Please select at least one lighting style');
      return;
    }
    if (selectedFlowerColors.isEmpty) {
      EasyLoading.showError('Please select at least one flower color');
      return;
    }
    if (selectedFlowerTypes.isEmpty) {
      EasyLoading.showError('Please select at least one flower type');
      return;
    }
    if (selectedFragrances.isEmpty) {
      EasyLoading.showError('Please select at least one fragrance');
      return;
    }
    if (selectedAmenities.isEmpty) {
      EasyLoading.showError('Please select at least one amenity');
      return;
    }
    final locationParts = venueAddressTEController.text.split(',');
    if (locationParts.length != 2) {
      EasyLoading.showError('Please enter area and city eg:Dhaka, Bangladesh');
      return;
    }

    // Prepare the decoration object and stringify it
    final decoration = {
      'tableShapes': selectedTableShapes.map((e) => e.toUpperCase()).toList(),
      'seatingStyles':
          selectedSeatingStyles.map((e) => e.toUpperCase()).toList(),
      'lighting': selectedLightingStyles.map((e) => e.toUpperCase()).toList(),
      'flowerColors': selectedFlowerColors.map((e) => e.toUpperCase()).toList(),
      'flowerTypes': selectedFlowerTypes.map((e) => e.toUpperCase()).toList(),
      'fragrances': selectedFragrances.map((e) => e.toUpperCase()).toList(),
    };

    // Prepare the body with all required fields
    var body = {
      'name': venueNameTEController.text.trim(),
      'city': locationParts[0].trim(),
      'area': locationParts[1].trim(),
      'capacity': int.tryParse(numberGuestsTEController.text.trim()) ?? 0,
      'type': selectedVenueType.value,
      'profileId': profileId,
      // 'availabilityDescription': 'string',
      // // Replace with actual input
      // 'parkingDescription': 'string',
      // // Replace with actual input
      // 'price': 0,
      // // Replace with actual input
      // 'bookingType': 'INSTANT_BOOKING',
      // // Replace with actual input
      // 'extraServiceDescription': 'string',
      // // Replace with actual input
      // 'cateringDescription': 'string',
      // // Replace with actual input
      'amenityIds': selectedAmenities.map((a) => a.id).join(','),
      // Comma-separated string
      'decoration': jsonEncode(decoration),
      // Stringify decoration
    };

    List<http.MultipartFile> files = [
      await http.MultipartFile.fromPath('venueImage', venueImage.value!.path),
      await http.MultipartFile.fromPath(
        'arrangementsImage',
        seatArrangementImage.value!.path,
      ),
    ];

    _logger.i('Request Body: ${body.toString()}');
    _logger.i('Files: ${files.map((f) => f.filename).toList()}');

    final response = await OwnerNetworkCaller().postRequest(
      Url: Urls.venueCreate,
      body: body,
      files: files,
      isMultipart: true,
    );
    if (response.isSuccess) {
      EasyLoading.showSuccess('Venue created successfully');
      clearControllers();
      _logger.i('Venue created successfully: ${response.body}');
    } else {
      EasyLoading.showError('Failed to create venue: ${response.errorMessage}');
      _logger.w('Failed to create venue: ${response.errorMessage}');
    }
  }

  // clear all controllers
  void clearControllers() {
    venueAddressTEController.clear();
    numberGuestsTEController.clear();
    venueNameTEController.clear();
    selectedAmenities.clear();
    selectedFragrances.clear();
    selectedFlowerColors.clear();
    selectedFlowerTypes.clear();
    selectedLightingStyles.clear();
    selectedSeatingStyles.clear();
    selectedTableShapes.clear();
    venueImage.value = null;
    seatArrangementImage.value = null;
  }

  // dispose
  @override
  void onClose() {
    super.onClose();
    venueNameTEController.dispose();
    numberGuestsTEController.dispose();
    venueAddressTEController.dispose();
  }

  //------------- End New Venue Create  --------------//
}
