import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:blinqo/features/role/venue_owner/bottom_nav_bar/screen/vanueOwner_bottom_nav_bar.dart';
import 'package:blinqo/features/role/venue_owner/profile_page/controller/venu_setup_controller.dart';
import 'package:blinqo/features/role/venue_owner/profile_page/controller/venue_owner_profile_controller.dart';
import 'package:blinqo/features/role/venue_owner/profile_page/widgets/add_amenities_dialog.dart';
import 'package:blinqo/features/role/venue_owner/profile_page/widgets/event_aminites_button.dart';
import 'package:blinqo/features/role/venue_owner/profile_page/widgets/seating_arrangement_widget.dart';
import 'package:blinqo/features/role/venue_owner/profile_page/widgets/venue_decoration_option_selection.dart';
import 'package:blinqo/features/role/venue_owner/profile_page/widgets/venue_setup_header.dart';
import 'package:blinqo/features/role/venue_owner/profile_page/widgets/google_map_venue_setup.dart';
import 'package:blinqo/features/role/venue_owner/profile_page/widgets/venue_type_dropdown_menu.dart';
import 'package:blinqo/features/role/venue_owner/widgets/event_textfield_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VenueSetupScreen extends StatelessWidget {
  final String venueStatus;
  static const String name = '/venue-setup-screen';

  const VenueSetupScreen({super.key, required this.venueStatus});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final bool isDarkMode =
        Get.put(VenueOwnerProfileController()).isDarkMode.value;
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
                VenueSetupHeader(title: venueStatus),
                SizedBox(height: 32),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // name text field
                      TextFieldWidget(
                        hintText: 'Venue Name',
                        labelText: 'Venue Name',
                        controller: controller.venueNameTEController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Enter Venue Name';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 16),
                      // Location text field
                      TextFieldWidget(
                        hintText: 'Enter your location',
                        labelText: 'Location',
                        controller: controller.venueAddressTEController,
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
                      TextFieldWidget(
                        hintText: 'Guests Capacity',
                        labelText: 'Number Of Guests',
                        controller: controller.numberGuestsTEController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Enter Guests Capacity';
                          }
                          if (int.tryParse(value) == null) {
                            return 'Enter Valid Number';
                          }
                          if (int.tryParse(value)! <= 0) {
                            return 'Enter Valid Number';
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
                      // Venue Type Dropdown
                      Obx(() {
                        return DropdownSelector(
                          selectedValue: controller.selectedVenueType.value,
                          options: [
                            'Select Venue Type',
                            'HOTEL',
                            'RESTAURANT',
                            'CONFERENCE_HALL',
                            'BANQUET',
                            'RESORT',
                            'OUTDOOR',
                          ],
                          hintText: 'Select Venue Type',
                          onChanged: (String? newValue) {
                            controller.updateSelectedVenueType(newValue);
                          },
                        );
                      }),
                      SizedBox(height: 16),

                      Text(
                        'Amenities',
                        style: getTextStyle(
                          color: const Color(0xFF333333),
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 12),
                      Obx(() {
                        return controller.selectedAmenities.isEmpty
                            ? Text('No amenities selected')
                            : Wrap(
                              spacing: 8,
                              runSpacing: 8,
                              children:
                                  controller.selectedAmenities.map((amenity) {
                                    return EventAmenityButton(
                                      amenity: amenity,
                                      isSelected: true,
                                      controller: controller,
                                    );
                                  }).toList(),
                            );
                      }),

                      SizedBox(height: 24),
                      // Available Amenities Section
                      Text(
                        'Select From Here',
                        style: getTextStyle(
                          color: const Color(0xFF333333),
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 10),
                      Obx(() {
                        return controller.availableAmenities.isEmpty
                            ? Text('No more amenities available')
                            : Wrap(
                              spacing: 8,
                              runSpacing: 8,
                              children:
                                  controller.availableAmenities.map((amenity) {
                                    return EventAmenityButton(
                                      amenity: amenity,
                                      isSelected: false,
                                      controller: controller,
                                    );
                                  }).toList(),
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
                      SizedBox(height: 40),
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
                              controller.createNewVenue();
                              // Get.to(() => VenueOwnerProfilePage());
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
                      if(venueStatus == 'Venue Setup')
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            Get.to(() => VanueOwnerBottomNavBar());
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
}
