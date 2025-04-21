import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:blinqo/core/utils/constants/image_path.dart';
import 'package:blinqo/features/role/venue_owner/profile_page/controller/amenities_controller.dart';
import 'package:blinqo/features/role/venue_owner/profile_page/controller/venue_owner_profile_controller.dart';
import 'package:blinqo/features/role/venue_owner/profile_page/screen/venue_owner_profile_page.dart';
import 'package:blinqo/features/role/venue_owner/profile_page/widgets/add_amenities_dialog.dart';
import 'package:blinqo/features/role/venue_owner/profile_page/widgets/venue_setup_header.dart';
import 'package:blinqo/features/role/venue_owner/profile_page/widgets/google_map_venue_setup.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VenueSetupScreen extends StatelessWidget {
  static const String name = '/venue-setup-screen';

  const VenueSetupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode =
        Get.put(VenueOwnerProfileController()).isDarkMode.value;
    final AmenitiesController amenitiesController = Get.put(
      AmenitiesController(),
    );
    // Text controller for the popup text field
    final TextEditingController amenityController = TextEditingController();
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Obx(
      () => Scaffold(
        backgroundColor:
            isDarkMode
                ? AppColors.darkBackgroundColor
                : AppColors.backgroundColor,
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
                    // name text field
                    _buildTextField('Enter your name', 'Name'),
                    SizedBox(height: 16),
                    // Location text field
                    _buildTextField('Enter your location', 'Location'),
                    SizedBox(height: 16),
                    // select From image here show google map in short
                    Text(
                      'Select From',
                      style: getTextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color:
                            isDarkMode ? Color(0xffEBEBEB) : Color(0xff333333),
                      ),
                    ),
                    SizedBox(height: 16),

                    // Google Map
                    GoogleMapVenueSetup(),

                    SizedBox(height: 16),
                    _buildTextField('Number OF Guests', 'Number Of Guests'),
                    SizedBox(height: 16),
                    Text(
                      'Amenities',
                      style: getTextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color:
                            isDarkMode ? Color(0xffEBEBEB) : Color(0xff333333),
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
                                    amenitiesController.selectedAmenities.map((
                                      amenities,
                                    ) {
                                      return _buildAmenityButton(
                                        amenities,
                                        false,
                                        amenitiesController,
                                      );
                                    }).toList(),
                              ),
                    ),
                    SizedBox(height: 24),
                    // Selected From here Section
                    Text(
                      'Select From Here',
                      style: getTextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color:
                            isDarkMode ? Color(0xffEBEBEB) : Color(0xff333333),
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
                                    amenitiesController.availableAmenities.map((
                                      amenity,
                                    ) {
                                      return _buildAmenityButton(
                                        amenity,
                                        true,
                                        amenitiesController,
                                      );
                                    }).toList(),
                              ),
                    ),
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
                          Get.dialog(
                            AddAmenitiesDialog(controller: amenitiesController),
                          );
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
                            isDarkMode ? Color(0xffEBEBEB) : Color(0xff333333),
                      ),
                    ),
                    SizedBox(height: 16),
                    Stack(
                      children: [
                        Image.asset(
                          ImagePath.seatingArrangement,
                          width: width * 0.9,
                          height: height * 0.3,
                          fit: BoxFit.cover,
                        ),
                        // liner gradient
                        Container(
                          width: width * 0.9,
                          height: height * 0.3,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Color(0x00000000),
                                Color(0x00000000),
                                Color(0xFF161616),
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 20,
                          right: 20,
                          child: CircleAvatar(
                            backgroundColor: Color(0xffD4AF37),
                            radius: 16,
                            child: Icon(
                              Icons.mode_edit_outline_outlined,
                              size: 18,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 48),
                    // Continue button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          Get.to(() => VenueOwnerProfilePage());
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
    );
  }

  Widget _buildTextField(String hintText, String labelText) {
    final bool isDarkMode =
        Get.put(VenueOwnerProfileController()).isDarkMode.value;
    return TextField(
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
          controller.selectAmenity(amenity);
        } else {
          controller.removeAmenity(amenity);
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
