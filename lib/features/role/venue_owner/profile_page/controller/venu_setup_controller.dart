import 'dart:convert';
import 'dart:io';
import 'package:blinqo/core/common/widgets/logger_view.dart';
import 'package:blinqo/core/urls/endpoint.dart';
import 'package:blinqo/features/role/venue_owner/authentication/model/login_model.dart';
import 'package:blinqo/features/role/venue_owner/myvenue/controller/all_venue_details_controller.dart';
import 'package:blinqo/features/role/venue_owner/myvenue/controller/venue_details_controller.dart';
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

/// VenueSetupController handles all the venue setup related operations including:
/// - Venue creation and updates
/// - Image handling
/// - Amenities management
/// - Decoration options
/// - Form validation and submission

class VenueSetupController extends GetxController {
  // Logger instance for debugging
  final _logger = createLogger();
  
  // Network caller instance
  final OwnerNetworkCaller _ownerNetworkCaller = OwnerNetworkCaller();

  ///--------------------- Text Controllers ---------------------///
  TextEditingController venueNameTEController = TextEditingController();
  TextEditingController venueAddressTEController = TextEditingController();
  TextEditingController numberGuestsTEController = TextEditingController();
  TextEditingController amenityController = TextEditingController();

  ///--------------------- Observable Variables ---------------------///
  // Loading and Edit Mode States
  RxBool isLoading = false.obs;
  RxBool isEditMode = false.obs;

  // Venue Type Selection
  RxString selectedVenueType = 'Select Venue Type'.obs;

  // Images
  var venueImage = Rx<File?>(null);
  var seatArrangementImage = Rx<File?>(null);

  // Amenities
  var availableAmenities = <EventAmenity>[].obs;
  var selectedAmenities = <EventAmenity>[].obs;

  // Decoration Options
  Rxn<VenuDecorationOption> venuDecorationOption = Rxn<VenuDecorationOption>();
  RxList<String> selectedTableShapes = <String>[].obs;
  RxList<String> selectedSeatingStyles = <String>[].obs;
  RxList<String> selectedLightingStyles = <String>[].obs;
  RxList<String> selectedFlowerColors = <String>[].obs;
  RxList<String> selectedFlowerTypes = <String>[].obs;
  RxList<String> selectedFragrances = <String>[].obs;

  ///--------------------- Lifecycle Methods ---------------------///
  @override
  void onInit() {
    super.onInit();
    fetchVenueDecorationOptions();
    fetchAmenities();
  }

  @override
  void onClose() {
    // Dispose all controllers to prevent memory leaks
    venueNameTEController.dispose();
    numberGuestsTEController.dispose();
    venueAddressTEController.dispose();
    amenityController.dispose();
    super.onClose();
  }

  ///--------------------- Edit Mode Methods ---------------------///
  /// Sets the edit mode and loads venue details if in edit mode
  void setEditMode(bool isEdit) {
    isEditMode.value = isEdit;
    if (isEdit) {
      loadVenueDetails();
    }
  }

  /// Loads existing venue details when in edit mode
  void loadVenueDetails() async {
    try {
      final venueDetailsController = Get.find<VenueDetailsController>();
      final venueData = venueDetailsController.response.value?.data?.venue;

      if (venueData != null) {
        // Populate form fields with existing data
        venueNameTEController.text = venueData.name ?? '';
        venueAddressTEController.text = '${venueData.city ?? ''}, ${venueData.area ?? ''}';
        numberGuestsTEController.text = venueData.capacity?.toString() ?? '';
        selectedVenueType.value = venueData.type ?? 'Select Venue Type';

        // Load amenities
        if (venueData.amenities.isNotEmpty) {
          // First fetch all available amenities
          await fetchAmenities();
          
          // Get the IDs of venue's amenities
          final venueAmenityIds = venueData.amenities
              .map((amenity) => amenity.id)
              .toSet();

          // Filter amenities into selected and available
          selectedAmenities.value = availableAmenities
              .where((amenity) => venueAmenityIds.contains(amenity.id))
              .toList();
              
          availableAmenities.value = availableAmenities
              .where((amenity) => !venueAmenityIds.contains(amenity.id))
              .toList();
        }

        // Load decoration options
        final decoration = venueData.decoration;
        if (decoration != null) {
          // First fetch all decoration options
          await fetchVenueDecorationOptions();
          
          // Set selected options
          selectedTableShapes.value = List<String>.from(decoration.tableShapes ?? []);
          selectedSeatingStyles.value = List<String>.from(decoration.seatingStyles ?? []);
          selectedLightingStyles.value = List<String>.from(decoration.lighting ?? []);
          selectedFlowerColors.value = List<String>.from(decoration.flowerColors ?? []);
          selectedFlowerTypes.value = List<String>.from(decoration.flowerTypes ?? []);
          selectedFragrances.value = List<String>.from(decoration.fragrances ?? []);
          
          // Ensure all lists are initialized even if empty
          selectedTableShapes.value ??= [];
          selectedSeatingStyles.value ??= [];
          selectedLightingStyles.value ??= [];
          selectedFlowerColors.value ??= [];
          selectedFlowerTypes.value ??= [];
          selectedFragrances.value ??= [];
        }
      }
    } catch (e) {
      _logger.w('⚠️ Error loading venue details: $e');
      EasyLoading.showError('Failed to load venue details');
    }
  }

  ///--------------------- Image Handling Methods ---------------------///
  /// Handles image selection for venue and seat arrangement
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

  /// Requests necessary permissions for image picking
  Future<void> requestPermissions() async {
    PermissionStatus cameraStatus = await Permission.camera.request();
    PermissionStatus storageStatus = await Permission.storage.request();

    if (cameraStatus.isDenied || storageStatus.isDenied) {
      _logger.w("Permission denied");
    } else {
      _logger.i("Permission granted");
    }
  }

  ///--------------------- Amenities Management ---------------------///
  /// Creates a new amenity
  Future<void> createAmenity() async {
    _logger.i('Creating amenity with name: ${amenityController.text.trim()}');
    final response = await _ownerNetworkCaller.postRequest(
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
      EasyLoading.showError('Failed to create amenity: ${response.errorMessage}');
    }
  }

  /// Fetches all available amenities
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

      if (response.statusCode == 200) {
        List<EventAmenity> amenities = (jsonDecode(response.body) as List)
            .map((json) => EventAmenity.fromJson(json))
            .toList();
            
        // In edit mode, we'll handle the filtering in loadVenueDetails
        if (!isEditMode.value) {
          availableAmenities.value = amenities.where((a) => !a.defaultSelected).toList();
          selectedAmenities.value = amenities.where((a) => a.defaultSelected).toList();
        } else {
          // In edit mode, initially load all amenities as available
          availableAmenities.value = amenities;
          selectedAmenities.clear();
        }
        _logger.i('Fetched ${amenities.length} amenities.');
      } else {
        EasyLoading.showError('Failed to load amenities: ${response.statusCode}');
        _logger.w('Failed with status: ${response.statusCode}');
      }
    } catch (e) {
      EasyLoading.showError('Error fetching amenities: $e');
      _logger.e('Error: $e');
    } finally {
      isLoading.value = false;
    }
  }

  /// Manages amenity selection
  void selectAmenity(EventAmenity amenity) {
    if (availableAmenities.contains(amenity)) {
      availableAmenities.remove(amenity);
      selectedAmenities.add(amenity);
    }
  }

  /// Manages amenity removal
  void removeAmenity(EventAmenity amenity) {
    if (selectedAmenities.contains(amenity)) {
      selectedAmenities.remove(amenity);
      availableAmenities.add(amenity);
    }
  }

  ///--------------------- Decoration Options ---------------------///
  /// Fetches venue decoration options
  Future<void> fetchVenueDecorationOptions() async {
    _logger.i('💡 Fetching venue decoration options');
    try {
      final response = await _ownerNetworkCaller.getRequest(
        Url: Urls.eventDecorationEnum,
      );
      if (response.isSuccess) {
        venuDecorationOption.value = VenuDecorationOption.fromJson(response.body);
        
        // Initialize empty lists if they don't exist
        if (!isEditMode.value) {
          selectedTableShapes.clear();
          selectedSeatingStyles.clear();
          selectedLightingStyles.clear();
          selectedFlowerColors.clear();
          selectedFlowerTypes.clear();
          selectedFragrances.clear();
        }
      }
    } catch (e) {
      _logger.e('Error fetching venue decoration options: $e');
      EasyLoading.showError('Failed to load decoration options');
    }
  }

  /// Toggles selection for decoration options
  void toggleSelection(String option, List<String> selectedList) {
    if (selectedList.contains(option)) {
      selectedList.remove(option);
    } else {
      selectedList.add(option);
    }
    _logger.d('Updated selection for $option: $selectedList');
  }

  ///--------------------- Venue Type Management ---------------------///
  /// Updates the selected venue type
  void updateSelectedVenueType(String? newValue) {
    if (newValue != null) {
      selectedVenueType.value = newValue;
    }
  }

  ///--------------------- Form Management ---------------------///
  /// Validates and saves venue information
  Future<void> saveVenue(String venueStatus, {bool isEdit = false}) async {
    _logger.i(isEdit ? 'Starting venue update process' : 'Starting venue creation process');

    // Validate required fields
    if (!validateVenueData(isEdit)) return;

    EventUser? user = await EventAuthController.getUserInfo();
    String? profileId = user?.profileId;
    
    if (profileId == null) {
      EasyLoading.showError('Failed to fetch user ID');
      return;
    }

    // Prepare the data
    final locationParts = venueAddressTEController.text.split(',');
    final decoration = prepareDecorationData();
    final body = prepareVenueData(profileId, locationParts);
    final files = await prepareImageFiles();

    // Send the request
    final response = await _ownerNetworkCaller.postRequest(
      isPatch: isEdit,
      Url: isEdit 
          ? Urls.updateVenue(Get.put(VenueDetailsController()).response.value?.data?.venue?.id)
          : Urls.venueCreate,
      body: body,
      files: files,
      isMultipart: true,
    );

    handleVenueResponse(response, isEdit, venueStatus);
  }

  /// Validates all required venue data
  bool validateVenueData(bool isEdit) {
    if (!isEdit && venueImage.value == null) {
      EasyLoading.showError('Please select venue image');
      return false;
    }
    if (!isEdit && seatArrangementImage.value == null) {
      EasyLoading.showError('Please select seat arrangement image');
      return false;
    }
    if (selectedVenueType.value == 'Select Venue Type') {
      EasyLoading.showError('Please select venue type');
      return false;
    }
    if (selectedTableShapes.isEmpty) {
      EasyLoading.showError('Please select at least one table shape');
      return false;
    }
    if (selectedSeatingStyles.isEmpty) {
      EasyLoading.showError('Please select at least one seating style');
      return false;
    }
    if (selectedLightingStyles.isEmpty) {
      EasyLoading.showError('Please select at least one lighting style');
      return false;
    }
    if (selectedFlowerColors.isEmpty) {
      EasyLoading.showError('Please select at least one flower color');
      return false;
    }
    if (selectedFlowerTypes.isEmpty) {
      EasyLoading.showError('Please select at least one flower type');
      return false;
    }
    if (selectedFragrances.isEmpty) {
      EasyLoading.showError('Please select at least one fragrance');
      return false;
    }
    if (selectedAmenities.isEmpty) {
      EasyLoading.showError('Please select at least one amenity');
      return false;
    }
    final locationParts = venueAddressTEController.text.split(',');
    if (locationParts.length != 2) {
      EasyLoading.showError('Please enter area and city eg:Dhaka, Bangladesh');
      return false;
    }
    return true;
  }

  /// Prepares decoration data for API request
  Map<String, List<String>> prepareDecorationData() {
    return {
      'tableShapes': selectedTableShapes.toList(),
      'seatingStyles': selectedSeatingStyles.toList(),
      'lighting': selectedLightingStyles.toList(),
      'flowerColors': selectedFlowerColors.toList(),
      'flowerTypes': selectedFlowerTypes.toList(),
      'fragrances': selectedFragrances.toList(),
    };
  }

  /// Prepares venue data for API request
  Map<String, dynamic> prepareVenueData(String profileId, List<String> locationParts) {
    return {
      'name': venueNameTEController.text.trim(),
      'city': locationParts[0].trim(),
      'area': locationParts[1].trim(),
      'capacity': int.tryParse(numberGuestsTEController.text.trim()) ?? 0,
      'type': selectedVenueType.value,
      'profileId': profileId,
      'price': 0,
      'bookingType': 'INSTANT_BOOKING',
      'amenityIds': selectedAmenities.map((a) => a.id).join(','),
      'decoration': jsonEncode(prepareDecorationData()),
    };
  }

  /// Prepares image files for upload
  Future<List<http.MultipartFile>> prepareImageFiles() async {
    List<http.MultipartFile> files = [];
    if (venueImage.value != null) {
      files.add(await http.MultipartFile.fromPath('venueImage', venueImage.value!.path));
    }
    if (seatArrangementImage.value != null) {
      files.add(await http.MultipartFile.fromPath('arrangementsImage', seatArrangementImage.value!.path));
    }
    return files;
  }

  /// Handles the API response for venue creation/update
  void handleVenueResponse(dynamic response, bool isEdit, String venueStatus) async {
    if (response.isSuccess) {
      EasyLoading.showSuccess(
        isEdit ? 'Venue updated successfully' : 'Venue created successfully'
      );
      
      final allVenuesController = Get.put(AllVenuesDetailsController());
      

      if (venueStatus == 'Create New Venue') {
        await allVenuesController.getAllVenues();
        clearControllers();
        Get.back();
      } else if (venueStatus == 'Venue Setup') {
        await allVenuesController.getAllVenues();
        clearControllers();
        Get.to(() => VenueOwnerProfilePage());
      } else if (venueStatus == 'Update Venue') {
        VenueDetailsController venueDetailsController = Get.put(VenueDetailsController());
        venueDetailsController.getVenueDetails(
          Get.put(VenueDetailsController()).response.value?.data?.venue?.id ?? ''
        );
        await allVenuesController.getAllVenues();
        clearControllers();
        Get.back();
      }
    } else {
      EasyLoading.showError(
        'Failed to ${isEdit ? 'update' : 'create'} venue: ${response.errorMessage}'
      );
    }
  }

  /// Clears all form controllers and resets state
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
}
