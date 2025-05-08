import 'dart:io';

import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:blinqo/core/utils/constants/image_path.dart';
import 'package:blinqo/features/role/venue_owner/profile_page/Model/amenity_model.dart';
import 'package:blinqo/features/role/venue_owner/profile_page/Model/event_decoration_model.dart';
import 'package:blinqo/features/role/venue_owner/profile_page/controller/amenities_controller.dart';
import 'package:blinqo/features/role/venue_owner/profile_page/controller/venu_setup_controller.dart';
import 'package:blinqo/features/role/venue_owner/profile_page/controller/venue_owner_profile_controller.dart';
import 'package:blinqo/features/role/venue_owner/profile_page/screen/venue_owner_profile_page.dart';
import 'package:blinqo/features/role/venue_owner/profile_page/widgets/add_amenities_dialog.dart';
import 'package:blinqo/features/role/venue_owner/profile_page/widgets/venue_decoration_option_selection.dart';
import 'package:blinqo/features/role/venue_owner/profile_page/widgets/venue_setup_header.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class VenueSetupScreen extends StatelessWidget {
  static const String name = '/venue-setup-screen';

  const VenueSetupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AmenitiesController amenitiesController = Get.put(AmenitiesController());
    final bool isDarkMode = Get.put(VenueOwnerProfileController()).isDarkMode.value;
    final VenuDecorationController decorationController = Get.put(VenuDecorationController());
    final TextEditingController locationController = TextEditingController();
    final Rx<File?> venueImage = Rx<File?>(null);
    final Rx<File?> arrangementsImage = Rx<File?>(null);

    return Obx(
          () => Scaffold(
        backgroundColor: isDarkMode ? AppColors.darkBackgroundColor : AppColors.backgroundColor,
        body: SingleChildScrollView(
          child: Column(
            children: [
              VenueSetupHeader(),
              SizedBox(height: 32),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildTextField('Venue Name', 'Venue Name'),
                    SizedBox(height: 16),
                    _buildTextField('Enter location (city, area)', 'Location', controller: locationController),
                    SizedBox(height: 16),
                    Text(
                      'Venue Image',
                      style: getTextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: isDarkMode ? Color(0xffEBEBEB) : Color(0xff333333),
                      ),
                    ),
                    SizedBox(height: 8),
                    GestureDetector(
                      onTap: () async {
                        final ImagePicker _picker = ImagePicker();
                        final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
                        if (image != null) {
                          venueImage.value = File(image.path);
                        }
                      },
                      child: Container(
                        height: 100,
                        decoration: BoxDecoration(
                          border: Border.all(color: isDarkMode ? Color(0xffAFB1B6) : Color(0xffABB7C2)),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: venueImage.value == null
                            ? Center(child: Text('Select Venue Image', style: getTextStyle(fontSize: 14, color: Colors.grey)))
                            : Image.file(venueImage.value!, fit: BoxFit.cover),
                      ),
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Seating Arrangement Image',
                      style: getTextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: isDarkMode ? Color(0xffEBEBEB) : Color(0xff333333),
                      ),
                    ),
                    SizedBox(height: 8),
                    GestureDetector(
                      onTap: () async {
                        final ImagePicker _picker = ImagePicker();
                        final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
                        if (image != null) {
                          arrangementsImage.value = File(image.path);
                        }
                      },
                      child: Container(
                        height: 100,
                        decoration: BoxDecoration(
                          border: Border.all(color: isDarkMode ? Color(0xffAFB1B6) : Color(0xffABB7C2)),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: arrangementsImage.value == null
                            ? Center(child: Text('Select Arrangement Image', style: getTextStyle(fontSize: 14, color: Colors.grey)))
                            : Image.file(arrangementsImage.value!, fit: BoxFit.cover),
                      ),
                    ),
                    SizedBox(height: 16),
                    _buildTextField('Guests Capacity', 'Number Of Guests'),
                    SizedBox(height: 16),
                    Text(
                      'Venue Type',
                      style: getTextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: isDarkMode ? Color(0xffEBEBEB) : Color(0xff333333),
                      ),
                    ),
                    SizedBox(height: 16),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: isDarkMode ? Color(0xffAFB1B6) : Color(0xffABB7C2)),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          isExpanded: true,
                          iconSize: 24,
                          style: getTextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: isDarkMode ? Color(0xffEBEBEB) : Color(0xff333333),
                          ),
                          hint: Text(
                            'Select Venue Type',
                            style: getTextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: isDarkMode ? Color(0xffA1A1A1) : Color(0xff767676),
                            ),
                          ),
                          borderRadius: BorderRadius.circular(8),
                          menuWidth: Get.width * 0.7,
                          icon: const Icon(Icons.arrow_drop_down, color: Color(0xff003366)),
                          dropdownColor: isDarkMode ? AppColors.darkBackgroundColor : AppColors.backgroundColor,
                          value: 'Select Venue Type',
                          items: <String>['Select Venue Type', 'HOTEL', 'RESTAURANT', 'CONFERENCE_HALL', 'BANQUET', 'RESORT', 'OUTDOOR']
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {},
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                    Obx(() {
                      if (amenitiesController.isLoading.value) {
                        return Center(child: CircularProgressIndicator());
                      }
                      // Pre-populate selected amenities when page loads
                      if (amenitiesController.selectedAmenities.isEmpty) {
                        amenitiesController.selectedAmenities.value = amenitiesController.availableAmenities
                            .where((amenity) => amenity.defaultSelected)
                            .toList();
                        amenitiesController.availableAmenities.value = amenitiesController.availableAmenities
                            .where((amenity) => !amenity.defaultSelected)
                            .toList();
                      }
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Selected Amenities', style: getTextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: isDarkMode ? Color(0xffEBEBEB) : Color(0xff333333))),
                          SizedBox(height: 16),
                          Obx(() => amenitiesController.selectedAmenities.isEmpty
                              ? Text('No amenities selected', style: getTextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: isDarkMode ? Color(0xffEBEBEB) : Colors.grey))
                              : Wrap(spacing: 8, runSpacing: 8, children: amenitiesController.selectedAmenities.map((amenity) {
                            return _buildAmenityButton(amenity.name, false, amenitiesController);
                          }).toList())),
                          SizedBox(height: 24),
                          Text('Select From Here', style: getTextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: isDarkMode ? Color(0xffEBEBEB) : Color(0xff333333))),
                          SizedBox(height: 16),
                          Obx(() => amenitiesController.availableAmenities.isEmpty
                              ? Text('No more amenities available', style: getTextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: isDarkMode ? Color(0xffEBEBEB) : Colors.grey))
                              : Wrap(spacing: 8, runSpacing: 8, children: amenitiesController.availableAmenities.map((amenity) {
                            return _buildAmenityButton(amenity.name, true, amenitiesController);
                          }).toList())),
                          const SizedBox(height: 24),
                        ],
                      );
                    }),
                    const SizedBox(height: 24),
                    Center(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xff003366),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(34)),
                          padding: EdgeInsets.all(12),
                        ),
                        onPressed: () {
                          Get.dialog(AddAmenitiesDialog(controller: amenitiesController));
                        },
                        child: Icon(Icons.add, color: Colors.white, size: 24),
                      ),
                    ),
                    SizedBox(height: 85),
                    Text('Seating Arrangement', style: getTextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: isDarkMode ? Color(0xffEBEBEB) : Color(0xff333333))),
                    SizedBox(height: 16),
                    Stack(
                      children: [
                        Obx(() => arrangementsImage.value == null
                            ? Image.asset(ImagePath.seatingArrangement, width: width * 0.9, height: height * 0.3, fit: BoxFit.cover)
                            : Image.file(arrangementsImage.value!, width: width * 0.9, height: height * 0.3, fit: BoxFit.cover)),
                        Container(
                          width: width * 0.9,
                          height: height * 0.3,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(colors: [Color(0x00000000), Color(0x00000000), Color(0xFF161616)], begin: Alignment.topCenter, end: Alignment.bottomCenter),
                          ),
                        ),
                        Positioned(bottom: 20, right: 20, child: InkWell(
                          onTap: () async {
                            final ImagePicker _picker = ImagePicker();
                            final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
                            if (image != null) arrangementsImage.value = File(image.path);
                          },
                          child: CircleAvatar(backgroundColor: Color(0xffD4AF37), radius: 16, child: Icon(Icons.mode_edit_outline_outlined, size: 18, color: Colors.white)),
                        )),
                      ],
                    ),
                    SizedBox(height: 16),
                    Obx(() {
                      if (decorationController.venuDecorationOption.value == null) {
                        return Center(child: Text('No options available'));
                      }
                      return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        OptionSection(title: 'Table Shape', options: decorationController.venuDecorationOption.value!.tableShape ?? [], selectedOptions: decorationController.selectedTableShapes, onToggle: decorationController.toggleSelection),
                        OptionSection(title: 'Seating Style', options: decorationController.venuDecorationOption.value!.seatingStyle ?? [], selectedOptions: decorationController.selectedSeatingStyles, onToggle: decorationController.toggleSelection),
                        OptionSection(title: 'Lighting Style', options: decorationController.venuDecorationOption.value!.lightingStyle ?? [], selectedOptions: decorationController.selectedLightingStyles, onToggle: decorationController.toggleSelection),
                        OptionSection(title: 'Flower Color', options: decorationController.venuDecorationOption.value!.flowerColor ?? [], selectedOptions: decorationController.selectedFlowerColors, onToggle: decorationController.toggleSelection),
                        OptionSection(title: 'Flower Type', options: decorationController.venuDecorationOption.value!.flowerType ?? [], selectedOptions: decorationController.selectedFlowerTypes, onToggle: decorationController.toggleSelection),
                        OptionSection(title: 'Fragrance', options: decorationController.venuDecorationOption.value!.fragrance ?? [], selectedOptions: decorationController.selectedFragrances, onToggle: decorationController.toggleSelection),
                      ]);
                    }),
                    SizedBox(height: 48),
                    SizedBox(width: double.infinity, child: ElevatedButton(
                      onPressed: () async {
                        final user = await EvenAuthController.getUserInfo();
                        final profileId = user.id;
                        final locationParts = locationController.text.split(',');
                        if (locationParts.length != 2) {
                          Get.snackbar('Error', 'Location must be in format: city, area');
                          return;
                        }
                        final city = locationParts[0].trim();
                        final area = locationParts[1].trim();
                        final capacity = int.tryParse(_buildTextField('Guests Capacity', 'Number Of Guests').controller!.text) ?? 0;
                        final type = 'CONFERENCE_HALL'; // Default or from dropdown
                        final amenityIds = amenitiesController.selectedAmenities.map((e) => e.id).join(',');

                        var request = http.MultipartRequest('POST', Uri.parse('https://freepik.softvenceomega.com/venue/create'))
                          ..headers.addAll({'Authorization': 'Bearer ${await EvenAuthController.getAuthToken()}', 'accept': '*/*'})
                          ..fields.addAll({
                            'name': _buildTextField('Venue Name', 'Venue Name').controller!.text,
                            'city': city,
                            'area': area,
                            'capacity': capacity.toString(),
                            'type': type,
                            'amenityIds': amenityIds,
                            'profileId': profileId,
                            'availabilityDescription': '',
                            'parkingDescription': '',
                            'cateringDescription': '',
                            'extraServiceDescription': '',
                            'bookingType': 'REQUEST_BASED_BOOKING',
                            'decoration': jsonEncode({
                              'tableShapes': decorationController.selectedTableShapes.map((e) => e.toUpperCase()).toList(),
                              'seatingStyles': decorationController.selectedSeatingStyles.map((e) => e.toUpperCase()).toList(),
                              'lighting': decorationController.selectedLightingStyles.map((e) => e.toUpperCase()).toList(),
                              'flowerColors': decorationController.selectedFlowerColors.map((e) => e.toUpperCase()).toList(),
                              'flowerTypes': decorationController.selectedFlowerTypes.map((e) => e.toUpperCase()).toList(),
                              'fragrances': decorationController.selectedFragrances.map((e) => e.toUpperCase()).toList(),
                            }),
                          });
                        if (venueImage.value != null) request.files.add(await http.MultipartFile.fromPath('venueImage', venueImage.value!.path));
                        if (arrangementsImage.value != null) request.files.add(await http.MultipartFile.fromPath('arrangementsImage', arrangementsImage.value!.path));

                        final response = await request.send();
                        if (response.statusCode == 200 || response.statusCode == 201) {
                          Get.snackbar('Success', 'Venue created successfully');
                          Get.to(() => VenueOwnerProfilePage());
                        } else {
                          Get.snackbar('Error', 'Failed to create venue: ${await response.stream.bytesToString()}');
                        }
                      },
                      style: ElevatedButton.styleFrom(padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20), backgroundColor: Color(0xff003366), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
                      child: Text('Save & Continue', style: getTextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: isDarkMode ? Color(0xffE6EBF0) : Color(0xffFFFFFF))),
                    )),
                    SizedBox(height: 20),
                    SizedBox(width: double.infinity, child: ElevatedButton(
                      onPressed: () => Get.to(() => VenueOwnerProfilePage()),
                      style: ElevatedButton.styleFrom(padding: EdgeInsets.symmetric(vertical: 12), backgroundColor: isDarkMode ? AppColors.darkBackgroundColor : AppColors.backgroundColor, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12), side: BorderSide(width: 1, color: Color(0xff003366)))),
                      child: Text('Skip', style: getTextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: isDarkMode ? Color(0xffE6EBF0) : Color(0xff003366))),
                    )),
                    SizedBox(height: 40),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String hintText, String labelText, {TextEditingController? controller}) {
    final bool isDarkMode = Get.put(VenueOwnerProfileController()).isDarkMode.value;
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: getTextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: isDarkMode ? Color(0xffC0C0C0) : Color(0xff767676)),
        hintText: hintText,
        hintStyle: getTextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: isDarkMode ? Color(0xffA1A1A1) : Color(0xff767676)),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: isDarkMode ? Color(0xffAFB1B6) : Color(0xffABB7C2), width: 1)),
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: isDarkMode ? Color(0xffAFB1B6) : Color(0xffABB7C2), width: 1)),
      ),
    );
  }

  Widget _buildAmenityButton(String amenity, bool isSelected, AmenitiesController controller) {
    return GestureDetector(
      onTap: () {
        if (isSelected) {
          controller.selectAmenity(EventAmenity(id: '', name: amenity, defaultSelected: false));
        } else {
          controller.removeAmenity(EventAmenity(id: '', name: amenity, defaultSelected: false));
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade300), borderRadius: BorderRadius.circular(20), color: isSelected ? Colors.white : Color(0xffFBF7EB)),
        child: Row(mainAxisSize: MainAxisSize.min, children: [
          const Icon(Icons.wifi, size: 16, color: Color(0xffD4AF37)),
          const SizedBox(width: 8),
          Text(amenity, style: getTextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: const Color(0xFF333333))),
        ]),
      ),
    );
  }
}