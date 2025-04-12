import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/common/widgets/customcontinuebutton.dart';
import 'package:blinqo/core/common/widgets/upgrade_to_pro.dart';
import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:blinqo/core/utils/constants/icon_path.dart';
import 'package:blinqo/features/role/service_provider/payment_page/screen/get_verified_screen.dart';
import 'package:blinqo/features/role/service_provider/profile_setup_page/controller/profile_setup_controller.dart';
import 'package:blinqo/features/role/service_provider/profile_setup_page/widget/customcircleavater.dart';
import 'package:blinqo/features/role/service_provider/service_profile_page/screen/service_provider_profile.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ProfileSetupScreen extends StatelessWidget {
  ProfileSetupScreen({super.key});
  final ProfileSetupController profileController = Get.put(
    ProfileSetupController(),
  );
  @override
  Widget build(BuildContext context) {
    profileController.initMarkers();
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Profile Setup",
                      style: getTextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Obx(() {
                  return Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundColor: Colors.grey[300],
                        child: ClipOval(
                          child:
                              profileController.profileImage.value == null
                                  ? Image.asset(
                                    IconPath.profile01,
                                    width: 100,
                                    height: 100,
                                    fit: BoxFit.cover,
                                  )
                                  : Image.file(
                                    profileController.profileImage.value!,
                                    width: 100,
                                    height: 100,
                                    fit: BoxFit.cover,
                                  ),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: GestureDetector(
                          onTap: () {
                            profileController.pickImage();
                          },
                          child: CircleAvatar(
                            radius: 18,
                            backgroundColor: Colors.transparent,
                            child: Image.asset(
                              IconPath.profileedit,
                              width: 24,
                              height: 24,
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                }),
                SizedBox(height: 20),
                TextFormField(
                  controller: profileController.spnameController,
                  decoration: InputDecoration(
                    labelText: "Name",
                    labelStyle: getTextStyle(
                      fontSize: 16,
                      color: AppColors.borderColor,
                    ),
                    hintText: "Guy Hawkins",
                    hintStyle: getTextStyle(
                      fontSize: 14,
                      color: AppColors.textColor,
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey, width: 1.0),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                SizedBox(height: 20),

                Obx(
                  () => Container(
                    width: double.infinity,
                    height: 61,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: AppColors.borderColor,
                        width: 1,
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(left: 8, bottom: 9.5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Role',
                            style: getTextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                            ),
                          ),
                          SizedBox(height: 10),
                          SizedBox(
                            height: 18,
                            child: PopupMenuButton<String>(
                              color: AppColors.primary,
                              onSelected:
                                  (value) =>
                                      profileController.updateRoles(value),
                              itemBuilder: (context) {
                                return profileController.roles.map((role) {
                                  return PopupMenuItem<String>(
                                    value: role,
                                    child: Text(role),
                                  );
                                }).toList();
                              },
                              padding: EdgeInsets.zero,
                              offset: Offset(0, 20),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    profileController.selectedRoles.value,
                                    style: getTextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 10,
                                    ),
                                    child: Image.asset(
                                      IconPath.arrowdown,
                                      width: 20,
                                      height: 20,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Event Preference",
                    style: getTextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: AppColors.textColor,
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Obx(() {
                      return CustomCircleAvater(
                        imagePath: IconPath.corporateEvents,
                        text: "Corporate",
                        isSelected: profileController.selectedEvents.contains(
                          "Corporate",
                        ),
                      );
                    }),
                    Obx(() {
                      return CustomCircleAvater(
                        imagePath: IconPath.wedding,
                        text: "Weddings",
                        isSelected: profileController.selectedEvents.contains(
                          "Weddings",
                        ),
                      );
                    }),
                    Obx(() {
                      return CustomCircleAvater(
                        imagePath: IconPath.musidFastivals,
                        text: "Music Festivals",
                        isSelected: profileController.selectedEvents.contains(
                          "Music Festivals",
                        ),
                      );
                    }),
                  ],
                ),
                SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Obx(() {
                      return CustomCircleAvater(
                        imagePath: IconPath.exhibition,
                        text: "Exhibitions",
                        isSelected: profileController.selectedEvents.contains(
                          "Exhibitions",
                        ),
                      );
                    }),
                    Obx(() {
                      return CustomCircleAvater(
                        imagePath: IconPath.concert,
                        text: "Concerts",
                        isSelected: profileController.selectedEvents.contains(
                          "Concerts",
                        ),
                      );
                    }),
                    Obx(() {
                      return CustomCircleAvater(
                        imagePath: IconPath.charityEvent,
                        text: "Charity Events",
                        isSelected: profileController.selectedEvents.contains(
                          "Charity Events",
                        ),
                      );
                    }),
                  ],
                ),
                SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Obx(() {
                      return CustomCircleAvater(
                        imagePath: IconPath.privateParties,
                        text: "Private Parties",
                        isSelected: profileController.selectedEvents.contains(
                          "Private Parties",
                        ),
                      );
                    }),
                    Obx(() {
                      return CustomCircleAvater(
                        imagePath: IconPath.productLaunches,
                        text: "Product Launches",
                        isSelected: profileController.selectedEvents.contains(
                          "Product Launches",
                        ),
                      );
                    }),
                    Obx(() {
                      return CustomCircleAvater(
                        imagePath: IconPath.tradeShow,
                        text: "Trade Shows",
                        isSelected: profileController.selectedEvents.contains(
                          "Trade Shows",
                        ),
                      );
                    }),
                  ],
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: profileController.spdescriptionController,
                  maxLines: 5,
                  decoration: InputDecoration(
                    labelText: "Description",
                    labelStyle: getTextStyle(
                      fontSize: 16,
                      color: AppColors.borderColor,
                    ),
                    hintText: "I am a ............",
                    hintStyle: getTextStyle(
                      fontSize: 14,
                      color: AppColors.textColor,
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey, width: 1.0),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: profileController.splocationController,
                  onFieldSubmitted: (value) {
                    profileController.searchLocation(value);
                  },

                  decoration: InputDecoration(
                    labelText: "Location",
                    labelStyle: getTextStyle(
                      fontSize: 16,
                      color: AppColors.borderColor,
                    ),
                    hintText: "New York City",
                    hintStyle: getTextStyle(
                      fontSize: 14,
                      color: AppColors.textColor,
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey, width: 1.0),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),

                SizedBox(height: 20),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Select From Map",
                    style: getTextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: AppColors.textColor,
                    ),
                  ),
                ),
                SizedBox(height: 8),
                SizedBox(
                  width: double.infinity,
                  height: 200,
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: GetBuilder<ProfileSetupController>(
                          builder: (_) {
                            return GoogleMap(
                              onMapCreated: profileController.onMapCreated,
                              initialCameraPosition: CameraPosition(
                                target: profileController.center,
                                zoom: 16.0,
                              ),
                              markers: profileController.mapMarkers,
                              myLocationButtonEnabled: false,
                              zoomControlsEnabled: false,
                            );
                          },
                        ),
                      ),
                      Positioned(
                        bottom: 10,
                        right: 10,
                        child: FloatingActionButton(
                          onPressed: () {
                            profileController.mapController.animateCamera(
                              CameraUpdate.newLatLng(profileController.center),
                            );
                          },
                          backgroundColor: Colors.white,
                          mini: true,
                          elevation: 4,
                          child: Image.asset(
                            IconPath.mylocation,
                            width: 24,
                            height: 24,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 20),
                TextFormField(
                  controller: profileController.spyearController,
                  decoration: InputDecoration(
                    labelText: "Years of Experiences",
                    labelStyle: getTextStyle(
                      fontSize: 16,
                      color: AppColors.borderColor,
                    ),
                    hintText: "3 years",
                    hintStyle: getTextStyle(
                      fontSize: 14,
                      color: AppColors.textColor,
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey, width: 1.0),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Upload (Max 10 Photos)",
                    style: getTextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: AppColors.buttonColor2,
                    ),
                  ),
                ),
                SizedBox(height: 8),
                GestureDetector(
                  onTap: profileController.tenpickImage,
                  child: Obx(() {
                    return DottedBorder(
                      borderType: BorderType.RRect,
                      radius: Radius.circular(5),
                      color: AppColors.buttonColor2,
                      strokeWidth: 1.5,
                      dashPattern: [5, 3],
                      child: Container(
                        width: double.infinity,
                        height: 106,
                        decoration: BoxDecoration(
                          color: Color(0xFFE6EAF8),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child:
                            profileController.tenImageUpload.isEmpty
                                ? Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 8,
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        IconPath.backup,
                                        height: 32,
                                        width: 32,
                                      ),
                                      SizedBox(height: 8),
                                      Text(
                                        'Select File',
                                        style: getTextStyle(
                                          color: AppColors.buttonColor2,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      SizedBox(height: 8),
                                      Text(
                                        'Supported formats: JPEG, PNG',
                                        style: getTextStyle(
                                          color: Color(0xFF898989),
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                                : PageView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount:
                                      profileController.tenImageUpload.length,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: EdgeInsets.all(4),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(8),
                                        child: Image.file(
                                          profileController
                                              .tenImageUpload[index],
                                          width: 80,
                                          height: 80,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                      ),
                    );
                  }),
                ),
                SizedBox(height: 40),
                UpgradeToProcard(onTap: () {}),
                SizedBox(height: 40),
                CustomContinueButton(
                  onTap: () {
                    /// TODO: Before push must change the screen to get verified
                    Get.to(GetVerifiedScreen());
                    // Get.to(ServiceProviderProfile());
                  },
                  title: "Continue",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
