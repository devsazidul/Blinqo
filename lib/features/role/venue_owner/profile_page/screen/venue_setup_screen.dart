

import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/utils/constants/colors.dart';

import 'package:blinqo/features/role/venue_owner/profile_page/Model/amenity_model.dart';

import 'package:blinqo/features/role/venue_owner/profile_page/controller/amenities_controller.dart';
import 'package:blinqo/features/role/venue_owner/profile_page/controller/venu_setup_controller.dart';
import 'package:blinqo/features/role/venue_owner/profile_page/controller/venue_owner_profile_controller.dart';
import 'package:blinqo/features/role/venue_owner/profile_page/screen/venue_owner_profile_page.dart';
import 'package:blinqo/features/role/venue_owner/profile_page/widgets/add_amenities_dialog.dart';
import 'package:blinqo/features/role/venue_owner/profile_page/widgets/seating_arrangement_widget.dart';
import 'package:blinqo/features/role/venue_owner/profile_page/widgets/venue_decoration_option_selection.dart';
import 'package:blinqo/features/role/venue_owner/profile_page/widgets/venue_setup_header.dart';
import 'package:blinqo/features/role/venue_owner/profile_page/widgets/google_map_venue_setup.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class VenueSetupScreen extends StatelessWidget {
  static const String name = '/venue-setup-screen';

  const VenueSetupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final bool isDarkMode =
        Get.put(VenueOwnerProfileController()).isDarkMode.value;

    final AmenitiesController amenitiesController = Get.put(
      AmenitiesController(),
    );
    final VenueSetupController controller = Get.put(VenueSetupController());


    return Obx(
      () => Scaffold(
        backgroundColor:
            isDarkMode
                ? AppColors.darkBackgroundColor
                : AppColors.backgroundColor,
        body: SingleChildScrollView(
          child: Form(
            key: formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              children: [
                VenueSetupHeader(),
                SizedBox(height: 32),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // name text field
                      _buildTextField(
                        hintText: 'Venue Name',
                        labelText: 'Venue Name',
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Enter Venue Name';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 16),
                      // Location text field
                      _buildTextField(
                        hintText: 'Enter your location',
                        labelText: 'Location',
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Enter your location';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 16),
                      // select From image here show google map in short
                      Text(
                        'Select From',
                        style: getTextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color:
                              isDarkMode
                                  ? Color(0xffEBEBEB)
                                  : Color(0xff333333),
                        ),
                      ),
                      SizedBox(height: 16),

                      // Google Map
                      GoogleMapVenueSetup(),

                      SizedBox(height: 16),
                      _buildTextField(
                        hintText: 'Guests Capacity',
                        labelText: 'Number Of Guests',
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Enter Guests Capacity';
                          }
                          if (int.parse(value) <= 0) {
                            return 'Guests Capacity must be greater than 0';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 16),
                      Text(
                        'Venue Type',
                        style: getTextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color:
                              isDarkMode
                                  ? Color(0xffEBEBEB)
                                  : Color(0xff333333),
                        ),
                      ),
                      SizedBox(height: 16),
                      // show popup menu for venue type
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color:
                                isDarkMode
                                    ? Color(0xffAFB1B6)
                                    : Color(0xffABB7C2),
                          ),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            isExpanded: true,
                            iconSize: 24,
                            style: getTextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color:
                                  isDarkMode
                                      ? Color(0xffEBEBEB)
                                      : Color(0xff333333),
                            ),
                            hint: Text(
                              'Select Venue Type',
                              style: getTextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color:
                                    isDarkMode
                                        ? Color(0xffA1A1A1)
                                        : Color(0xff767676),
                              ),
                            ),
                            borderRadius: BorderRadius.circular(8),
                            menuWidth: Get.width * 0.7,
                            icon: const Icon(
                              Icons.arrow_drop_down,
                              color: Color(0xff003366),
                            ),
                            dropdownColor:
                                isDarkMode
                                    ? AppColors.darkBackgroundColor
                                    : AppColors.backgroundColor,
                            value: 'Select Venue Type',
                            items:
                                <String>[
                                  'Select Venue Type',
                                  'HOTEL',
                                  'RESTAURANT',
                                  'CONFERENCE_HALL',
                                  'BANQUET',
                                  'RESORT',
                                  'OUTDOOR',
                                ].map<DropdownMenuItem<String>>((String value) {
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
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Selected Amenities Section
                            Text(
                              'Selected Amenities',
                              style: getTextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color:
                                    isDarkMode
                                        ? Color(0xffEBEBEB)
                                        : Color(0xff333333),
                              ),
                            ),
                            SizedBox(height: 16),
                            Obx(
                              () =>
                                  amenitiesController.selectedAmenities.isEmpty
                                      ? Text(
                                        'No amenities selected',
                                        style: getTextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                          color:
                                              isDarkMode
                                                  ? Color(0xffEBEBEB)
                                                  : Colors.grey,
                                        ),
                                      )
                                      : Wrap(
                                        spacing: 8,
                                        runSpacing: 8,
                                        children:
                                            amenitiesController
                                                .selectedAmenities
                                                .map((amenity) {
                                                  return _buildAmenityButton(
                                                    amenity.name,
                                                    false,
                                                    amenitiesController,
                                                  );
                                                })
                                                .toList(),
                                      ),
                            ),
                            SizedBox(height: 24),
                            // Select From Here Section
                            Text(
                              'Select From Here',
                              style: getTextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color:
                                    isDarkMode
                                        ? Color(0xffEBEBEB)
                                        : Color(0xff333333),
                              ),
                            ),
                            SizedBox(height: 16),
                            Obx(
                              () =>
                                  amenitiesController.availableAmenities.isEmpty
                                      ? Text(
                                        'No more amenities available',
                                        style: getTextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                          color:
                                              isDarkMode
                                                  ? Color(0xffEBEBEB)
                                                  : Colors.grey,
                                        ),
                                      )
                                      : Wrap(
                                        spacing: 8,
                                        runSpacing: 8,
                                        children:
                                            amenitiesController
                                                .availableAmenities
                                                .map((amenity) {
                                                  return _buildAmenityButton(
                                                    amenity.name,
                                                    true,
                                                    amenitiesController,
                                                  );
                                                })
                                                .toList(),
                                      ),
                            ),
                            const SizedBox(height: 24),
                          ],
                        );
                      }),

                      const SizedBox(height: 24),

                      // Add Amenity button
                      Center(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xff003366),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(34),
                            ),
                            padding: EdgeInsets.all(12),
                          ),
                          onPressed: () {
                            Get.dialog(AddAmenitiesDialog());
                          },

                          child: Icon(Icons.add, color: Colors.white, size: 24),
                        ),
                      ),
                      SizedBox(height: 85),
                      // Seating Arrangement
                      Text(
                        'Seating Arrangement',
                        style: getTextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color:
                              isDarkMode
                                  ? Color(0xffEBEBEB)
                                  : Color(0xff333333),
                        ),
                      ),
                      SizedBox(height: 16),
                      SeatingArrangementWidget(),
                      SizedBox(height: 16),
                      Obx(() {
                        if (controller.venuDecorationOption.value == null) {
                          return Center(child: Text('No options available'));
                        }
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            OptionSection(
                              title: 'Table Shape',
                              options:
                                  controller
                                      .venuDecorationOption
                                      .value!
                                      .tableShape ??
                                  [],
                              selectedOptions: controller.selectedTableShapes,
                              onToggle: controller.toggleSelection,
                            ),
                            OptionSection(
                              title: 'Seating Style',
                              options:
                                  controller
                                      .venuDecorationOption
                                      .value!
                                      .seatingStyle ??
                                  [],
                              selectedOptions: controller.selectedSeatingStyles,
                              onToggle: controller.toggleSelection,
                            ),
                            OptionSection(
                              title: 'Lighting Style',
                              options:
                                  controller
                                      .venuDecorationOption
                                      .value!
                                      .lightingStyle ??
                                  [],
                              selectedOptions:
                                  controller.selectedLightingStyles,
                              onToggle: controller.toggleSelection,
                            ),
                            OptionSection(
                              title: 'Flower Color',
                              options:
                                  controller
                                      .venuDecorationOption
                                      .value!
                                      .flowerColor ??
                                  [],
                              selectedOptions: controller.selectedFlowerColors,
                              onToggle: controller.toggleSelection,
                            ),
                            OptionSection(
                              title: 'Flower Type',
                              options:
                                  controller
                                      .venuDecorationOption
                                      .value!
                                      .flowerType ??
                                  [],
                              selectedOptions: controller.selectedFlowerTypes,
                              onToggle: controller.toggleSelection,
                            ),
                            OptionSection(
                              title: 'Fragrance',
                              options:
                                  controller
                                      .venuDecorationOption
                                      .value!
                                      .fragrance ??
                                  [],
                              selectedOptions: controller.selectedFragrances,
                              onToggle: controller.toggleSelection,
                            ),
                          ],
                        );
                      }),
                      SizedBox(height: 48),
                      // Continue button
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              Get.to(() => VenueOwnerProfilePage());
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(
                              vertical: 12,
                              horizontal: 20,
                            ),
                            backgroundColor: Color(0xff003366),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: Text(
                            'Save & Continue',
                            style: getTextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color:
                                  isDarkMode
                                      ? Color(0xffE6EBF0)
                                      : Color(0xffFFFFFF),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      // Skip button elevated button
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            Get.to(() => VenueOwnerProfilePage());
                          },
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(vertical: 12),
                            backgroundColor:
                                isDarkMode
                                    ? AppColors.darkBackgroundColor
                                    : AppColors.backgroundColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                              side: BorderSide(
                                width: 1,
                                color: Color(0xff003366),
                              ),
                            ),
                          ),
                          child: Text(
                            'Skip',
                            style: getTextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color:
                                  isDarkMode
                                      ? Color(0xffE6EBF0)
                                      : Color(0xff003366),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 40),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String hintText,
    required String labelText,
    required String? Function(String?)? validator,
  }) {
    final bool isDarkMode =
        Get.put(VenueOwnerProfileController()).isDarkMode.value;

    return TextFormField(
      validator: validator,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: getTextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: isDarkMode ? Color(0xffC0C0C0) : Color(0xff767676),
        ),
        hintText: hintText,
        hintStyle: getTextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: isDarkMode ? Color(0xffA1A1A1) : Color(0xff767676),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: isDarkMode ? Color(0xffAFB1B6) : Color(0xffABB7C2),
            width: 1,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: isDarkMode ? Color(0xffAFB1B6) : Color(0xffABB7C2),
            width: 1,
          ),
        ),
      ),
    );
  }

  Widget _buildAmenityButton(
    String amenity,
    bool isSelected,
    AmenitiesController controller,
  ) {
    return GestureDetector(
      onTap: () {
        if (isSelected) {
          controller.selectAmenity(
            EventAmenity(
              id: '', // Placeholder, adjust if ID is needed
              name: amenity,
              defaultSelected: false,
            ),
          );
        } else {
          controller.removeAmenity(
            EventAmenity(
              id: '', // Placeholder, adjust if ID is needed
              name: amenity,
              defaultSelected: false,
            ),
          );
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(20),
          color: isSelected ? Colors.white : Color(0xffFBF7EB),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.wifi, size: 16, color: Color(0xffD4AF37)),
            const SizedBox(width: 8),
            Text(
              amenity,
              style: getTextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: const Color(0xFF333333),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
