import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/common/widgets/customcontinuebutton.dart';
import 'package:blinqo/core/common/widgets/upgrade_to_pro.dart';
import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:blinqo/core/utils/constants/icon_path.dart';
import 'package:blinqo/features/role/service_provider/common/controller/auth_controller.dart';
import 'package:blinqo/features/role/service_provider/profile_setup_page/controller/sp_profile_setup_controller.dart';
import 'package:blinqo/features/role/service_provider/profile_setup_page/widget/event_preference_circle_avatar.dart';
import 'package:blinqo/features/role/service_provider/service_profile_page/controller/service_user_profile_controler.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class SpProfileSetupScreen extends StatelessWidget {
  const SpProfileSetupScreen({super.key, this.isEdit = false});

  final bool isEdit;

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final profileSetupController = Get.find<SpProfileSetupController>();
    final profileController = Get.find<SpProfileController>();
    profileSetupController.initMarkers();
    profileSetupController.selectedEvents.clear();

    if (isEdit) {
      profileSetupController.nameController.text =
          SpAuthController.profileInfoModel?.name ?? "";
      profileSetupController.locationController.text =
          SpAuthController.profileInfoModel?.location ?? "";
      profileSetupController.descriptionController.text =
          SpAuthController.profileInfoModel?.description ?? "";
      profileSetupController.experienceYearController.text =
          SpAuthController.profileInfoModel?.experience?.toString() ?? "";
      profileSetupController.selectedEvents.addAll(
        SpAuthController.profileInfoModel?.eventPreference?.map(
              (e) => e.id ?? '',
            ) ??
            [],
      );
    }

    // return Obx(() {
    final themeMode =
        profileController.isDarkMode.value ? ThemeMode.dark : ThemeMode.light;
    return Scaffold(
      backgroundColor:
          themeMode == ThemeMode.dark
              ? AppColors.darkBackgroundColor
              : AppColors.backgroundColor,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  //* ------------------ Profile Setup Text ------------------
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

                  //* ------------------ Profile Image ------------------
                  Obx(() {
                    return Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        CircleAvatar(
                          radius: 50,
                          child: ClipOval(
                            child:
                                profileSetupController.profileImage.value ==
                                        null
                                    ? isEdit
                                        ? Image.network(
                                          SpAuthController
                                                  .profileInfoModel
                                                  ?.image
                                                  ?.path ??
                                              IconPath.profile01,
                                          width: 100,
                                          height: 100,
                                          fit: BoxFit.cover,
                                        )
                                        : Icon(
                                          Icons.person,
                                          size: 100,
                                          color: AppColors.primary,
                                        )
                                    : Image.file(
                                      profileSetupController
                                          .profileImage
                                          .value!,
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
                              profileSetupController.pickImage();
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

                  //* ------------------ Username TextField ------------------
                  TextFormField(
                    enabled: true,
                    controller: profileSetupController.nameController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your username';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      // floatingLabelBehavior: FloatingLabelBehavior.always,
                      // labelText: "Username",
                      label: Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(text: "Username"),
                            TextSpan(
                              text: " *",
                              style: getTextStyle(
                                fontSize: 16,
                                color: Colors.red,
                              ),
                            ),
                          ],
                        ),
                      ),
                      hintText: "Enter your username",
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 1.0),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),

                  //* ------------------ Role Dropdown ------------------
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Role",
                      style: getTextStyle(
                        fontSize: 12,
                        color:
                            themeMode == ThemeMode.dark
                                ? AppColors.primary
                                : AppColors.subTextColor,
                      ),
                    ),
                  ),
                  DropdownButtonFormField2<String>(
                    isExpanded: true,
                    decoration: InputDecoration(
                      // Add Horizontal padding using menuItemStyleData.padding so it matches
                      // the menu padding when button's width is not specified.
                      contentPadding: const EdgeInsets.symmetric(vertical: 16),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      // Add more decoration..
                    ),
                    hint: const Text(
                      'Select Your Role',
                      style: TextStyle(fontSize: 14),
                    ),
                    items:
                        profileSetupController.roles
                            .map(
                              (item) => DropdownMenuItem<String>(
                                value: item,
                                child: Text(
                                  item,
                                  style: const TextStyle(fontSize: 14),
                                ),
                              ),
                            )
                            .toList(),
                    validator: (value) {
                      if (value == null) {
                        return 'Please select your role.';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      //Do something when selected item is changed.
                    },
                    onSaved: (value) {
                      profileSetupController.updateRoles(value.toString());
                    },
                    value:
                        isEdit
                            ? profileSetupController.selectedRoles.value
                            : null,
                    buttonStyleData: const ButtonStyleData(
                      padding: EdgeInsets.only(right: 16),
                    ),
                    iconStyleData: IconStyleData(
                      icon: Image.asset(
                        IconPath.arrowdown,
                        width: 18,
                        height: 18,
                        color:
                            themeMode == ThemeMode.dark
                                ? AppColors.primary
                                : AppColors.textColor,
                      ),
                      iconSize: 24,
                    ),
                    dropdownStyleData: DropdownStyleData(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    menuItemStyleData: const MenuItemStyleData(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                    ),
                  ),
                  const SizedBox(height: 30),

                  // //* ------------------ Role Dropdown ------------------
                  // Obx(
                  //   () => Column(
                  //     crossAxisAlignment: CrossAxisAlignment.start,
                  //     children: [
                  //       Text(
                  //         'Role',
                  //         style: getTextStyle(
                  //           fontSize: 12,
                  //           color:
                  //               themeMode == ThemeMode.dark
                  //                   ? AppColors.primary
                  //                   : AppColors.subTextColor,
                  //         ),
                  //       ),
                  //       const SizedBox(height: 4),
                  //       Container(
                  //         width: double.infinity,
                  //         height: 48,
                  //         padding: const EdgeInsets.symmetric(horizontal: 12),
                  //         decoration: BoxDecoration(
                  //           border: Border.all(
                  //             color: AppColors.borderColor,
                  //             width: 1,
                  //           ),
                  //           borderRadius: BorderRadius.circular(8),
                  //         ),
                  //         child: PopupMenuButton<String>(
                  //           color: Colors.white,
                  //           onSelected:
                  //               (value) =>
                  //                   profileSetupController.updateRoles(value),
                  //           itemBuilder: (context) {
                  //             return profileSetupController.roles.map((role) {
                  //               return PopupMenuItem<String>(
                  //                 value: role,
                  //                 child: Text(
                  //                   role,
                  //                   style: getTextStyle(
                  //                     fontSize: 14,
                  //                     color: Colors.black,
                  //                   ),
                  //                 ),
                  //               );
                  //             }).toList();
                  //           },
                  //           offset: const Offset(0, 40),
                  //           padding: EdgeInsets.zero,
                  //           child: Row(
                  //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //             children: [
                  //               Text(
                  //                 profileSetupController
                  //                         .selectedRoles
                  //                         .value
                  //                         .isEmpty
                  //                     ? 'Select a role'
                  //                     : profileSetupController
                  //                         .selectedRoles
                  //                         .value,
                  //                 style: getTextStyle(
                  //                   fontSize: 14,
                  //                   color:
                  //                       profileSetupController
                  //                               .selectedRoles
                  //                               .value
                  //                               .isEmpty
                  //                           ? Colors.grey
                  //                           : Colors.black,
                  //                 ),
                  //               ),
                  //               Image.asset(
                  //                 IconPath.arrowdown,
                  //                 width: 18,
                  //                 height: 18,
                  //                 color:
                  //                     themeMode == ThemeMode.dark
                  //                         ? AppColors.primary
                  //                         : AppColors.textColor,
                  //               ),
                  //             ],
                  //           ),
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),

                  //* ------------------ Event Preference Text ------------------
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

                  //* ------------------ Event Preference Grid ------------------
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
                                  eventPreference.id ?? '',
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

                  //* ------------------ Description TextField ------------------
                  SizedBox(height: 20),
                  TextFormField(
                    controller: profileSetupController.descriptionController,
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
                      // hintStyle: getTextStyle(
                      //   fontSize: 14,
                      //   color:
                      //       themeMode == ThemeMode.dark
                      //           ? AppColors.primary
                      //           : AppColors.textColor,
                      // ),
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

                  //* ------------------ Location TextField ------------------
                  TextFormField(
                    controller: profileSetupController.locationController,
                    onFieldSubmitted: (value) {
                      profileSetupController.searchLocation(value);
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
                      // hintStyle: getTextStyle(
                      //   fontSize: 14,
                      //   color:
                      //       themeMode == ThemeMode.dark
                      //           ? AppColors.primary
                      //           : AppColors.textColor,
                      // ),
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

                  //* ------------------ Map ------------------
                  SizedBox(
                    width: double.infinity,
                    height: 200,
                    child: Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: GetBuilder<SpProfileSetupController>(
                            builder: (controller) {
                              return GoogleMap(
                                onCameraMove: (CameraPosition position) {
                                  // Update marker position as camera moves
                                  controller.initMarkers(
                                    location: position.target,
                                    title: 'Selected Location',
                                  );
                                },
                                onCameraIdle: () {
                                  // Get final position when camera stops moving
                                  controller.mapController
                                      .getLatLng(
                                        ScreenCoordinate(
                                          x:
                                              MediaQuery.of(
                                                Get.context!,
                                              ).size.width ~/
                                              2,
                                          y:
                                              MediaQuery.of(
                                                Get.context!,
                                              ).size.height ~/
                                              2,
                                        ),
                                      )
                                      .then((latLng) {
                                        controller.initMarkers(
                                          location: latLng,
                                          title: 'Selected Location',
                                        );
                                      });
                                },
                                zoomGesturesEnabled: true,
                                zoomControlsEnabled: true,
                                onMapCreated: controller.onMapCreated,
                                initialCameraPosition: CameraPosition(
                                  target: controller.center,
                                  zoom: 16.0,
                                ),
                                markers: controller.mapMarkers,
                                myLocationButtonEnabled: false,
                                // zoomControlsEnabled: false,
                              );
                            },
                          ),
                        ),
                        Positioned(
                          // bottom: 0,
                          top: 20,
                          right: 10,
                          child: FloatingActionButton(
                            onPressed: () {
                              profileSetupController.mapController
                                  .animateCamera(
                                    CameraUpdate.newLatLng(
                                      profileSetupController.center,
                                    ),
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

                  //* ------------------ Years of Experiences TextField ------------------
                  SizedBox(height: 20),
                  TextFormField(
                    controller: profileSetupController.experienceYearController,
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

                  //* ------------------ Upload Cover Photos ------------------
                  GestureDetector(
                    onTap:
                        profileSetupController
                            .pickCoverImage, // Trigger image pick
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
                              profileSetupController.coverImage.value == null
                                  ? isEdit
                                      ? Image.network(
                                        SpAuthController
                                                .profileInfoModel
                                                ?.coverPhoto
                                                ?.path ??
                                            IconPath.profile01,
                                        width: 100,
                                        height: 100,
                                        fit: BoxFit.cover,
                                      )
                                      : Padding(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 12,
                                          vertical: 8,
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
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
                                        profileSetupController
                                            .coverImage
                                            .value!,
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

                  //* ------------------ Upgrade To Proc ------------------
                  if (!(SpAuthController.profileInfoModel?.isPro ?? false))
                    SizedBox(height: 40),
                  if (!(SpAuthController.profileInfoModel?.isPro ?? false))
                    UpgradeToProcard(onTap: () {}),

                  SizedBox(height: 40),

                  //* ------------------ Continue Button ------------------
                  isEdit
                      ? CustomContinueButton(
                        onPress: () {
                          if (formKey.currentState!.validate()) {
                            profileSetupController.serviceProviderUpdate();
                          }
                        },
                        title: "Update",
                      )
                      : CustomContinueButton(
                        onPress: () {
                          if (formKey.currentState!.validate()) {
                            profileSetupController.serviceProviderSetup();
                          }
                        },
                        title: "Continue",
                      ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
    // });
  }
}
