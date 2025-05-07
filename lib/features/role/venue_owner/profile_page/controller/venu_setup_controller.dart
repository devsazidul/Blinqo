import 'dart:io';

import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/urls/endpoint.dart';
import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:blinqo/features/role/venue_owner/owern_network_caller/owner_network_caller.dart';
import 'package:blinqo/features/role/venue_owner/profile_page/Model/event_decoration_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class VenueSetupController extends GetxController {
  var venueImage = Rx<File?>(null);
  var seatArrangementImage = Rx<File?>(null);

  var venuDecorationOption = Rxn<VenuDecorationOption>();
  var isLoading = false.obs;

  final _logger = Logger(
    printer: PrettyPrinter(
      methodCount: 0,
      errorMethodCount: 5,
      lineLength: 140,
      colors: true,
      printEmojis: true,
      dateTimeFormat: DateTimeFormat.dateAndTime,
    ),
  );

  // Selected options for each category
  var selectedTableShapes = <String>[].obs;
  var selectedSeatingStyles = <String>[].obs;
  var selectedLightingStyles = <String>[].obs;
  var selectedFlowerColors = <String>[].obs;
  var selectedFlowerTypes = <String>[].obs;
  var selectedFragrances = <String>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchDecorationOptions();
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

  Widget _buildImagePickerOption({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: AppColors.iconColor.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: AppColors.iconColor, size: 30),
          ),
          SizedBox(height: 8),
          Text(
            title,
            style: getTextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }

  Future<ImageSource?> showPickrOption() async {
    return await Get.bottomSheet(
      Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Select Image',
                style: getTextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildImagePickerOption(
                    icon: Icons.camera_alt,
                    title: 'Camera',
                    onTap: () {
                      Get.back(result: ImageSource.camera);
                    },
                  ),
                  _buildImagePickerOption(
                    icon: Icons.photo_library,
                    title: 'Gallery',
                    onTap: () {
                      Get.back(result: ImageSource.gallery);
                    },
                  ),
                ],
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
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

        venuDecorationOption.value = VenuDecorationOption.fromJson(response.body);
        // Filter options based on specific criteria
        selectedTableShapes.value = venuDecorationOption.value?.tableShape?.where((option) => ['Round', 'Oval', 'Hexagonal'].contains(option)).toList() ?? [];
        selectedSeatingStyles.value = venuDecorationOption.value?.seatingStyle?.where((option) => ['Banquet'].contains(option)).toList() ?? [];
        selectedLightingStyles.value = venuDecorationOption.value?.lightingStyle?.where((option) => ['Ambient'].contains(option)).toList() ?? [];
        selectedFlowerColors.value = venuDecorationOption.value?.flowerColor?.where((option) => ['White'].contains(option)).toList() ?? [];
        selectedFlowerTypes.value = venuDecorationOption.value?.flowerType?.where((option) => ['Roses'].contains(option)).toList() ?? [];
        selectedFragrances.value = venuDecorationOption.value?.fragrance?.where((option) => ['Floral Scents'].contains(option)).toList() ?? [];
      } else {
        _logger.w('Failed to fetch decoration options: ${response.errorMessage}');
        EasyLoading.showError('Failed to load options: ${response.errorMessage}');
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
}
