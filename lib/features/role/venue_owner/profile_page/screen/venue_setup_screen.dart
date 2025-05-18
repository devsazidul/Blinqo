import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:blinqo/features/role/venue_owner/bottom_nav_bar/screen/vanueOwner_bottom_nav_bar.dart';
import 'package:blinqo/features/role/venue_owner/myvenue/controller/venue_details_controller.dart';
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

/// Screen for setting up or editing venue details
class VenueSetupScreen extends StatelessWidget {
  final String venueStatus;
  static const String name = '/venue-setup-screen';
  final bool isEdit;

  const VenueSetupScreen({
    super.key,
    required this.venueStatus,
    this.isEdit = false,
  });

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final bool isDarkMode =
        Get.put(VenueOwnerProfileController()).isDarkMode.value;
    final VenueSetupController controller = Get.put(VenueSetupController());
    controller.setEditMode(isEdit);

    // Initialize venue images if in edit mode
    final (venueImage, seatArrangementImage) = _initializeVenueImages();

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
                // Venue setup header with image
                VenueSetupHeader(
                  title: venueStatus,
                  isEdit: isEdit,
                  imagePath: venueImage,
                ),
                const SizedBox(height: 32),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Basic venue information section
                      _buildBasicVenueInfo(controller),
                      const SizedBox(height: 16),

                      // Location and map section
                      _buildLocationSection(controller, isDarkMode),
                      const SizedBox(height: 16),

                      // Venue type section
                      _buildVenueTypeSection(controller, isDarkMode),
                      const SizedBox(height: 16),

                      // Amenities section
                      _buildAmenitiesSection(controller, isDarkMode),
                      const SizedBox(height: 40),

                      // Seating arrangement section
                      _buildSeatingArrangementSection(
                        controller,
                        isDarkMode,
                        seatArrangementImage,
                      ),
                      const SizedBox(height: 48),

                      // Action buttons section
                      _buildActionButtons(controller, formKey, isDarkMode),
                      const SizedBox(height: 40),
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

  /// Initialize venue images for edit mode
  (String, String) _initializeVenueImages() {
    if (!isEdit) return ('', '');

    final venueDetailsController = Get.find<VenueDetailsController>();
    return (
      venueDetailsController.response.value?.data?.venue?.venueImage?.path ??
          '',
      venueDetailsController
              .response
              .value
              ?.data
              ?.venue
              ?.arrangementsImage
              ?.path ??
          '',
    );
  }

  /// Build basic venue information fields
  Widget _buildBasicVenueInfo(VenueSetupController controller) {
    return Column(
      children: [
        TextFieldWidget(
          hintText: 'Venue Name',
          labelText: 'Venue Name',
          controller: controller.venueNameTEController,
          validator: (value) => value!.isEmpty ? 'Enter Venue Name' : null,
        ),
        const SizedBox(height: 16),
        TextFieldWidget(
          hintText: 'Venue Description',
          labelText: 'Venue Description',
          controller: controller.venueDescriptionTEController,
          maxLines: 3,
          validator:
              (value) => value!.isEmpty ? 'Enter Venue Description' : null,
        ),
      ],
    );
  }

  /// Build location and map section
  Widget _buildLocationSection(
    VenueSetupController controller,
    bool isDarkMode,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFieldWidget(
          hintText: 'Enter your location (City, Area)',
          labelText: 'Location',
          controller: controller.venueAddressTEController,
          validator: (value) {
            if (value!.isEmpty) return 'Enter your location';
            if (!value.contains(',')) return 'Enter City, Area';
            return null;
          },
        ),
        const SizedBox(height: 16),
        Text(
          'Select From',
          style: getTextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color:
                isDarkMode ? const Color(0xffEBEBEB) : const Color(0xff333333),
          ),
        ),
        const SizedBox(height: 16),
        GoogleMapVenueSetup(),
        const SizedBox(height: 16),
        TextFieldWidget(
          hintText: 'Guests Capacity',
          labelText: 'Guests Capacity',
          controller: controller.numberGuestsTEController,
          validator: (value) {
            if (value!.isEmpty) return 'Enter Guests Capacity';
            if (int.tryParse(value) == null) return 'Enter Valid Number';
            if (int.tryParse(value)! <= 0) return 'Enter Valid Number';
            return null;
          },
        ),
      ],
    );
  }

  /// Build venue type dropdown section
  Widget _buildVenueTypeSection(
    VenueSetupController controller,
    bool isDarkMode,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Venue Type',
          style: getTextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color:
                isDarkMode ? const Color(0xffEBEBEB) : const Color(0xff333333),
          ),
        ),
        const SizedBox(height: 16),
        Obx(
          () => DropdownSelector(
            selectedValue: controller.selectedVenueType.value,
            options: const [
              'Select Venue Type',
              'HOTEL',
              'RESTAURANT',
              'CONFERENCE_HALL',
              'BANQUET',
              'RESORT',
              'OUTDOOR',
            ],
            hintText: 'Select Venue Type',
            onChanged: controller.updateSelectedVenueType,
          ),
        ),
      ],
    );
  }

  /// Build amenities section
  Widget _buildAmenitiesSection(
    VenueSetupController controller,
    bool isDarkMode,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Amenities',
          style: getTextStyle(
            color: isDarkMode ? Color(0xffEBEBEB) : Color(0xFF333333),
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 12),
        // Selected amenities
        Obx(
          () =>
              controller.selectedAmenities.isEmpty
                  ? const Text('No amenities selected')
                  : Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children:
                        controller.selectedAmenities
                            .map(
                              (amenity) => EventAmenityButton(
                                amenity: amenity,
                                isSelected: true,
                                controller: controller,
                              ),
                            )
                            .toList(),
                  ),
        ),
        const SizedBox(height: 24),
        // Available amenities
        Text(
          'Select From Here',
          style: getTextStyle(
            color: isDarkMode ? Color(0xffEBEBEB) : Color(0xFF333333),
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 10),
        Obx(
          () =>
              controller.availableAmenities.isEmpty
                  ? const Text('No more amenities available')
                  : Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children:
                        controller.availableAmenities
                            .map(
                              (amenity) => EventAmenityButton(
                                amenity: amenity,
                                isSelected: false,
                                controller: controller,
                              ),
                            )
                            .toList(),
                  ),
        ),
        const SizedBox(height: 24),
        // Add amenity button
        Center(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xff003366),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(34),
              ),
              padding: const EdgeInsets.all(12),
            ),
            onPressed: () => Get.dialog(const AddAmenitiesDialog()),
            child: const Icon(Icons.add, color: Colors.white, size: 24),
          ),
        ),
      ],
    );
  }

  /// Build seating arrangement section
  Widget _buildSeatingArrangementSection(
    VenueSetupController controller,
    bool isDarkMode,
    String seatArrangementImage,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Seating Arrangement',
          style: getTextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color:
                isDarkMode ? const Color(0xffEBEBEB) : const Color(0xff333333),
          ),
        ),
        const SizedBox(height: 16),
        SeatingArrangementWidget(
          isEdit: isEdit,
          imagePath: seatArrangementImage,
        ),
        const SizedBox(height: 16),
        Obx(() {
          if (controller.venuDecorationOption.value == null) {
            return const Center(child: Text('No options available'));
          }
          return _buildDecorationOptions(controller, isDarkMode);
        }),
      ],
    );
  }

  /// Build decoration options section
  Widget _buildDecorationOptions(
    VenueSetupController controller,
    bool isDarkMode,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        OptionSection(
          title: 'Table Shape',
          isDarkMode: isDarkMode,
          options: controller.venuDecorationOption.value!.tableShape ?? [],
          selectedOptions: controller.selectedTableShapes,
          onToggle: controller.toggleSelection,
        ),
        OptionSection(
          isDarkMode: isDarkMode,
          title: 'Seating Style',
          options: controller.venuDecorationOption.value!.seatingStyle ?? [],
          selectedOptions: controller.selectedSeatingStyles,
          onToggle: controller.toggleSelection,
        ),
        OptionSection(
          isDarkMode: isDarkMode,
          title: 'Lighting Style',
          options: controller.venuDecorationOption.value!.lightingStyle ?? [],
          selectedOptions: controller.selectedLightingStyles,
          onToggle: controller.toggleSelection,
        ),
        OptionSection(
          isDarkMode: isDarkMode,
          title: 'Flower Color',
          options: controller.venuDecorationOption.value!.flowerColor ?? [],
          selectedOptions: controller.selectedFlowerColors,
          onToggle: controller.toggleSelection,
        ),
        OptionSection(
          isDarkMode: isDarkMode,
          title: 'Flower Type',
          options: controller.venuDecorationOption.value!.flowerType ?? [],
          selectedOptions: controller.selectedFlowerTypes,
          onToggle: controller.toggleSelection,
        ),
        OptionSection(
          isDarkMode: isDarkMode,
          title: 'Fragrance',
          options: controller.venuDecorationOption.value!.fragrance ?? [],
          selectedOptions: controller.selectedFragrances,
          onToggle: controller.toggleSelection,
        ),
      ],
    );
  }

  /// Build action buttons section (Save/Update and Skip)
  Widget _buildActionButtons(
    VenueSetupController controller,
    GlobalKey<FormState> formKey,
    bool isDarkMode,
  ) {
    return Column(
      children: [
        // Save/Update button
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              if (formKey.currentState!.validate()) {
                controller.saveVenue(venueStatus, isEdit: isEdit);
              }
            },
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
              backgroundColor: const Color(0xff003366),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Text(
              isEdit ? 'Update Venue' : 'Save & Continue',
              style: getTextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color:
                    isDarkMode
                        ? const Color(0xffE6EBF0)
                        : const Color(0xffFFFFFF),
              ),
            ),
          ),
        ),
        const SizedBox(height: 20),
        // Skip button (only for create mode)
        if (venueStatus == 'Venue Setup' && !isEdit)
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => Get.to(() => const VanueOwnerBottomNavBar()),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 12),
                backgroundColor:
                    isDarkMode
                        ? AppColors.darkBackgroundColor
                        : AppColors.backgroundColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: const BorderSide(width: 1, color: Color(0xff003366)),
                ),
              ),
              child: Text(
                'Skip',
                style: getTextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color:
                      isDarkMode
                          ? const Color(0xffE6EBF0)
                          : const Color(0xff003366),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
