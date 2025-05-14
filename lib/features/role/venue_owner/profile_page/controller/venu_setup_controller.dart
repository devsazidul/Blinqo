import 'dart:convert';
import 'dart:io';
import 'package:blinqo/core/common/widgets/logger_view.dart';
import 'package:blinqo/core/urls/endpoint.dart';
import 'package:blinqo/features/role/venue_owner/authentication/model/login_model.dart';
import 'package:blinqo/features/role/venue_owner/myvenue/controller/all_venue_details_controller.dart';
import 'package:blinqo/features/role/venue_owner/myvenue/controller/venue_details_controller.dart'; // Import VenueDetailsController
import 'package:blinqo/features/role/venue_owner/owern_network_caller/even_authcontroller.dart';
import 'package:blinqo/features/role/venue_owner/owern_network_caller/owner_network_caller.dart';
import 'package:blinqo/features/role/venue_owner/profile_page/Model/amenity_model.dart';
import 'package:blinqo/features/role/venue_owner/profile_page/Model/event_decoration_model.dart';
import 'package:blinqo/features/role/venue_owner/profile_page/screen/venue_owner_profile_page.dart';
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
  RxBool isEditMode = false.obs;

  void setEditMode(bool isEdit) {
    isEditMode.value = isEdit;
    preloadVenueData();
  }

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
    // // Preload data if editing
    // if (Get.arguments != null && Get.arguments['isEdit'] == true) {
    //   venueId = Get.arguments['venueId'];
    //   preloadVenueData();
    // }
  }

  // Preload venue data from VenueDetailsController
  void preloadVenueData() {
    final venueDetails =
        Get.find<VenueDetailsController>().response.value?.data?.venue;
    if (venueDetails != null) {
      // preload image

      _logger.i('Preloading venue data for ID: ${venueDetails.id}');
      venueNameTEController.text = venueDetails.name ?? '';
      venueAddressTEController.text =
          '${venueDetails.city ?? ''}, ${venueDetails.area ?? ''}';
      numberGuestsTEController.text = venueDetails.capacity?.toString() ?? '';
      selectedVenueType.value = venueDetails.type ?? 'Select Venue Type';

      // Preload amenities
      final fetchedAmenities = venueDetails.amenities;
      selectedAmenities.value =
          availableAmenities
              .where((a) => fetchedAmenities.any((fa) => fa.id == a.id))
              .toList();
      availableAmenities.value =
          availableAmenities
              .where((a) => !fetchedAmenities.any((fa) => fa.id == a.id))
              .toList();

      // Preload decoration
      final decoration = venueDetails.decoration;
      if (decoration != null) {
        selectedTableShapes.value = decoration.tableShapes;
        selectedSeatingStyles.value = decoration.seatingStyles;
        selectedLightingStyles.value = decoration.lighting;
        selectedFlowerColors.value = decoration.flowerColors;
        selectedFlowerTypes.value = decoration.flowerTypes;
        selectedFragrances.value = decoration.fragrances;
      }

      // Note: Images are not preloaded as File objects; they remain null unless user picks new images
    } else {
      _logger.w('No venue data found for preloading');
      EasyLoading.showError('Failed to load venue data');
    }
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
        _logger.w("No image selected");
      }
    }
  }

  Future<void> requestPermissions() async {
    PermissionStatus cameraStatus = await Permission.camera.request();
    PermissionStatus storageStatus = await Permission.storage.request();

    if (cameraStatus.isDenied || storageStatus.isDenied) {
      _logger.w("Permission denied");
    } else {
      _logger.i("Permission granted");
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
    final authToken = await EventAuthController.getAuthToken();
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

  void selectAmenity(EventAmenity amenity) {
    if (availableAmenities.contains(amenity)) {
      availableAmenities.remove(amenity);
      selectedAmenities.add(amenity);
    }
  }

  void removeAmenity(EventAmenity amenity) {
    if (selectedAmenities.contains(amenity)) {
      selectedAmenities.remove(amenity);
      availableAmenities.add(amenity);
    }
  }

  //----------- End Venue Amenities --------------//

  //------------- Start Venue Create/Update --------------//

  Future<void> saveVenue(String venueStatus, {bool isEdit = false}) async {
    _logger.i(
      isEdit
          ? 'Starting venue update process'
          : 'Starting venue creation process',
    );

    if (!isEdit && venueImage.value == null) {
      EasyLoading.showError('Please select venue image');
      return;
    }
    if (!isEdit && seatArrangementImage.value == null) {
      EasyLoading.showError('Please select seat arrangement image');
      return;
    }
    _logger.i(
      'Validation Passed: Venue Image: ${venueImage.value?.path}, Seat Arrangement Image: ${seatArrangementImage.value?.path}',
    );

    EventUser? user = await EventAuthController.getUserInfo();
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

    // Prepare the decoration object
    final decoration = {
      'tableShapes': selectedTableShapes.toList(),
      'seatingStyles': selectedSeatingStyles.toList(),
      'lighting': selectedLightingStyles.toList(),
      'flowerColors': selectedFlowerColors.toList(),
      'flowerTypes': selectedFlowerTypes.toList(),
      'fragrances': selectedFragrances.toList(),
    };

    // Prepare the body
    var body = {
      'name': venueNameTEController.text.trim(),
      'city': locationParts[0].trim(),
      'area': locationParts[1].trim(),
      'capacity': int.tryParse(numberGuestsTEController.text.trim()) ?? 0,
      'type': selectedVenueType.value,
      'profileId': profileId,
      'price': 0,
      'bookingType': 'INSTANT_BOOKING',
      'amenityIds': selectedAmenities.map((a) => a.id).join(','),
      'decoration': jsonEncode(decoration),
    };

    List<http.MultipartFile> files = [];
    if (venueImage.value != null) {
      files.add(
        await http.MultipartFile.fromPath('venueImage', venueImage.value!.path),
      );
    }
    if (seatArrangementImage.value != null) {
      files.add(
        await http.MultipartFile.fromPath(
          'arrangementsImage',
          seatArrangementImage.value!.path,
        ),
      );
    }

    _logger.i('Request Body: ${body.toString()}');
    _logger.i('Files: ${files.map((f) => f.filename).toList()}');

    final response = await OwnerNetworkCaller().postRequest(
      isPatch: isEdit,
      Url:
          isEdit
              ? Urls.updateVenue(
                Get.find<VenueDetailsController>()
                    .response
                    .value
                    ?.data
                    ?.venue
                    ?.id,
              )
              : Urls.venueCreate,
      body: body,
      files: files,
      isMultipart: true,
    );

    if (response.isSuccess) {
      EasyLoading.showSuccess(
        isEdit ? 'Venue updated successfully' : 'Venue created successfully',
      );
      final allVenuesController = Get.find<AllVenuesDetailsController>();
      await allVenuesController.getAllVenues(); // Refresh venue list
      clearControllers();
      if (venueStatus == 'Create New Venue') {
        Get.back();
      } else if (venueStatus == 'Venue Setup') {
        Get.to(() => VenueOwnerProfilePage());
      } else if (venueStatus == 'Update Venue') {
        VenueDetailsController venueDetailsController = Get.put(
          VenueDetailsController(),
        );
        venueDetailsController.getVenueDetails(
          Get.find<VenueDetailsController>().response.value?.data?.venue?.id ??
              '',
        );
        Get.back();
      }
      _logger.i(
        isEdit
            ? 'Venue updated successfully: ${response.body}'
            : 'Venue created successfully: ${response.body}',
      );
    } else {
      EasyLoading.showError(
        'Failed to ${isEdit ? 'update' : 'create'} venue: ${response.errorMessage}',
      );
      _logger.w(
        'Failed to ${isEdit ? 'update' : 'create'} venue: ${response.errorMessage}',
      );
    }
  }

  // Clear all controllers
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
    selectedVenueType.value = 'Select Venue Type';
  }

  // Dispose
  @override
  void onClose() {
    super.onClose();
    venueNameTEController.dispose();
    numberGuestsTEController.dispose();
    venueAddressTEController.dispose();
    amenityController.dispose();
  }
}
