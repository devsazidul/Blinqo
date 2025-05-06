import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/common/widgets/customcontinuebutton.dart';
import 'package:blinqo/core/common/widgets/upgrade_to_pro.dart';
import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:blinqo/core/utils/constants/icon_path.dart';
import 'package:blinqo/features/role/service_provider/bottom_nav_bar/screen/sp_bottom_nav_bar.dart';
import 'package:blinqo/features/role/service_provider/profile_setup_page/controller/sp_profile_setup_controller.dart';
import 'package:blinqo/features/role/service_provider/profile_setup_page/widget/event_preference_circle_avatar.dart';
import 'package:blinqo/features/role/service_provider/service_profile_page/controller/service_user_profile_controler.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class SpProfileSetupScreen extends StatelessWidget {
  const SpProfileSetupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final SpProfileSetupController profileController = Get.put(
      SpProfileSetupController(),
    );
    final controller = Get.put(SpProfileController());
    profileController.initMarkers();

    // return Obx(() {
    final themeMode =
        controller.isDarkMode.value ? ThemeMode.dark : ThemeMode.light;
    return Scaffold(
      backgroundColor:
          themeMode == ThemeMode.dark
              ? AppColors.darkBackgroundColor
              : AppColors.backgroundColor,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                ///------------------ Profile Setup Text
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Profile Setup",
                      style: getTextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                        color:
                            themeMode == ThemeMode.dark
                                ? AppColors.primary
                                : AppColors.textColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),

                ///------------------ Profile Image
                Obx(() {
                  return Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      CircleAvatar(
                        radius: 50,

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

                ///------------------ Name TextField
                TextFormField(
                  enabled: true,
                  controller: profileController.nameController,
                  decoration: InputDecoration(
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    labelText: "Name",
                    labelStyle: getTextStyle(
                      fontSize: 16,
                      color:
                          themeMode == ThemeMode.dark
                              ? AppColors.primary
                              : AppColors.subTextColor,
                    ),

                    hintText: "profile name",
                    hintStyle: getTextStyle(
                      fontSize: 14,
                      color:
                          themeMode == ThemeMode.dark
                              ? AppColors.primary
                              : AppColors.textColor,
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey, width: 1.0),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                SizedBox(height: 20),

                ///------------------ Role Dropdown
                Obx(
                  () => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Role',
                        style: getTextStyle(
                          fontSize: 12,
                          color:
                              themeMode == ThemeMode.dark
                                  ? AppColors.primary
                                  : AppColors.subTextColor,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Container(
                        width: double.infinity,
                        height: 48,
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: AppColors.borderColor,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: PopupMenuButton<String>(
                          color: Colors.white,
                          onSelected:
                              (value) => profileController.updateRoles(value),
                          itemBuilder: (context) {
                            return profileController.roles.map((role) {
                              return PopupMenuItem<String>(
                                value: role,
                                child: Text(
                                  role,
                                  style: getTextStyle(
                                    fontSize: 14,
                                    color: Colors.black,
                                  ),
                                ),
                              );
                            }).toList();
                          },
                          offset: const Offset(0, 40),
                          padding: EdgeInsets.zero,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                profileController.selectedRoles.value.isEmpty
                                    ? 'Select a role'
                                    : profileController.selectedRoles.value,
                                style: getTextStyle(
                                  fontSize: 14,
                                  color:
                                      profileController
                                              .selectedRoles
                                              .value
                                              .isEmpty
                                          ? Colors.grey
                                          : Colors.black,
                                ),
                              ),
                              Image.asset(
                                IconPath.arrowdown,
                                width: 18,
                                height: 18,
                                color:
                                    themeMode == ThemeMode.dark
                                        ? AppColors.primary
                                        : AppColors.textColor,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                ///------------------ Event Preference Text
                SizedBox(height: 20),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Event Preference",
                    style: getTextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color:
                          themeMode == ThemeMode.dark
                              ? AppColors.primary
                              : AppColors.textColor,
                    ),
                  ),
                ),
                SizedBox(height: 20),
                // Event Preference Grid
                GetBuilder<SpProfileSetupController>(
                  builder: (controller) {
                    return GridView.count(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisCount: 3,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      childAspectRatio: 0.7,
                      children: List.generate(
                        controller.eventPreferenceList.length,
                        (index) {
                          final eventPreference =
                              controller.eventPreferenceList[index];
                          return GestureDetector(
                            onTap: () {
                              controller.toggleEventSelection(
                                eventPreference.id,
                              );
                            },
                            child: SpEventPreferenceCircleAvatar(
                              eventPreference: eventPreference,
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),

                // Description
                SizedBox(height: 20),
                TextFormField(
                  controller: profileController.descriptionController,
                  maxLines: 5,
                  decoration: InputDecoration(
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    labelText: "Description",
                    labelStyle: getTextStyle(
                      fontSize: 16,
                      color:
                          themeMode == ThemeMode.dark
                              ? AppColors.primary
                              : AppColors.subTextColor,
                    ),
                    hintText: "I am a ............",
                    hintStyle: getTextStyle(
                      fontSize: 14,
                      color:
                          themeMode == ThemeMode.dark
                              ? AppColors.primary
                              : AppColors.textColor,
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: AppColors.subTextColor,
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: profileController.locationController,
                  onFieldSubmitted: (value) {
                    profileController.searchLocation(value);
                  },
                  decoration: InputDecoration(
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    labelText: "Location",
                    labelStyle: getTextStyle(
                      fontSize: 16,
                      color:
                          themeMode == ThemeMode.dark
                              ? AppColors.primary
                              : AppColors.subTextColor,
                    ),
                    hintText: "New York City",
                    hintStyle: getTextStyle(
                      fontSize: 14,
                      color:
                          themeMode == ThemeMode.dark
                              ? AppColors.primary
                              : AppColors.textColor,
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: AppColors.subTextColor,
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    suffixIcon: GestureDetector(
                      onTap: () {},
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 6.0,
                          horizontal: 14.0,
                        ),
                        child: Image.asset(
                          IconPath.epsearch,
                          width: 18,
                          height: 18,
                        ),
                      ),
                    ),
                  ),
                ),

                // Select From Map Text
                SizedBox(height: 20),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Select From Map",
                    style: getTextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color:
                          themeMode == ThemeMode.dark
                              ? AppColors.primary
                              : AppColors.textColor,
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
                        child: GetBuilder<SpProfileSetupController>(
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

                // Years of Experiences Text
                SizedBox(height: 20),
                TextFormField(
                  controller: profileController.experienceYearController,
                  decoration: InputDecoration(
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    labelText: "Years of Experiences",
                    labelStyle: getTextStyle(
                      fontSize: 16,
                      color:
                          themeMode == ThemeMode.dark
                              ? AppColors.primary
                              : AppColors.subTextColor,
                    ),
                    hintText: "3 years",
                    hintStyle: getTextStyle(
                      fontSize: 14,
                      color:
                          themeMode == ThemeMode.dark
                              ? AppColors.primary
                              : AppColors.textColor,
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color:
                            themeMode == ThemeMode.dark
                                ? AppColors.primary
                                : Colors.grey,
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Upload Cover Photos",
                    style: getTextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color:
                          themeMode == ThemeMode.dark
                              ? AppColors.buttonColor
                              : AppColors.buttonColor2,
                    ),
                  ),
                ),
                SizedBox(height: 8),
                GestureDetector(
                  onTap: profileController.pickCoverImage, // Trigger image pick
                  child: Obx(() {
                    return DottedBorder(
                      borderType: BorderType.RRect,
                      radius: Radius.circular(5),
                      color:
                          themeMode == ThemeMode.dark
                              ? AppColors.buttonColor2
                              : AppColors.buttonColor2,
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
                            profileController.coverImage.value == null
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
                                        'Select Cover Image',
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
                                : Padding(
                                  padding: EdgeInsets.all(4),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: Image.file(
                                      profileController.coverImage.value!,
                                      width: double.infinity,
                                      height: 106,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                      ),
                    );
                  }),
                ),

                // Upgrade To Procard
                SizedBox(height: 40),
                UpgradeToProcard(onTap: () {}),
                SizedBox(height: 40),
                // Continue Button
                CustomContinueButton(
                  onPress: () {
                    // profileController.uploadServiceProviderProfile();
                    Get.to(() => SpBottomNavBarScreen());
                  },
                  title: "Continue",
                ),
              ],
            ),
          ),
        ),
      ),
    );
    // });
  }
}
