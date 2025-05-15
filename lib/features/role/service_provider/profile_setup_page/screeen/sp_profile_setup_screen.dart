import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/common/widgets/custom_continue_button.dart';
import 'package:blinqo/core/common/widgets/upgrade_to_pro.dart';
import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:blinqo/core/utils/constants/icon_path.dart';
import 'package:blinqo/features/role/service_provider/common/controller/auth_controller.dart';
import 'package:blinqo/features/role/service_provider/profile_setup_page/controller/sp_profile_setup_controller.dart';
import 'package:blinqo/features/role/service_provider/profile_setup_page/widget/event_preference_circle_avatar.dart';
import 'package:blinqo/features/role/service_provider/sp_profile/controller/service_user_profile_controler.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class SpProfileSetupScreen extends StatelessWidget {
  const SpProfileSetupScreen({super.key, this.isEdit = false});

  final bool isEdit;

  @override
  Widget build(BuildContext context) {
    final profileSetupController = Get.find<SpProfileSetupController>();
    final profileController = Get.find<SpProfileController>();

    // Set edit mode in controller
    profileSetupController.setEditMode(isEdit);
    profileSetupController.initMarkers();
    if (!isEdit) {
      // set name to profile name controller
      profileSetupController.profileNameController.text =
          SpAuthController.spUser?.name ?? "";
    }

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
              key: profileSetupController.formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                children: [
                  //* ------------------ Profile Setup Text ------------------
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        isEdit ? "Edit Profile" : "Profile Setup",
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
                                                  .spUser
                                                  ?.profile
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

                  //* ------------------ Name TextField ------------------
                  TextFormField(
                    controller: profileSetupController.profileNameController,
                    // validator: (value) {
                    //   if (value == null || value.isEmpty) {
                    //     return 'Please enter your profile name';
                    //   }
                    //   return null;
                    // },
                    decoration: InputDecoration(
                      enabled: isEdit,
                      label: Text("Name"),
                      hintText: "Enter your name",
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 1.0),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),

                  //* ------------------ Username TextField ------------------
                  TextFormField(
                    // always label make floating
                    controller: profileSetupController.usernameController,
                    validator: (value) {
                      // if (!isEdit) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your username';
                      }
                      if (value.length < 3) {
                        return 'Username must be at least 3 characters long';
                      }
                      // username only contain lowercase alphanumeric and underscore
                      if (!RegExp(r'^[a-z0-9_]+$').hasMatch(value)) {
                        return 'Username must contain only lowercase alphanumeric and underscore';
                      }
                      // }
                      return null;
                    },
                    decoration: InputDecoration(
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      label: Text.rich(
                        TextSpan(
                          text: "Username",
                          children: [
                            if (!isEdit)
                              TextSpan(
                                text: " *",
                                style: getTextStyle(
                                  fontSize: 12,
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
                  // TODO: I have to save role id instead of role name
                  Row(
                    children: [
                      Text(
                        "Role",
                        style: getTextStyle(
                          fontSize: 12,
                          color:
                              themeMode == ThemeMode.dark
                                  ? AppColors.primary
                                  : AppColors.subTextColor,
                        ),
                      ),
                      if (!isEdit)
                        Text(
                          " *",
                          style: getTextStyle(
                            fontSize: 12,
                            color: Colors.red,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                    ],
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

                  //* ------------------ Event Preference Text ------------------
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Text(
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
                      if (!isEdit)
                        Text(
                          " *",
                          style: getTextStyle(
                            fontSize: 20,
                            color: Colors.red,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                    ],
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
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your description';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      // labelText: "Description",
                      label: Text.rich(
                        TextSpan(
                          text: "Description",
                          style: getTextStyle(
                            fontSize: 16,
                            color:
                                themeMode == ThemeMode.dark
                                    ? AppColors.primary
                                    : AppColors.subTextColor,
                          ),
                          children: [
                            if (!isEdit)
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

                      hintText: "I am a ............",
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
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your location';
                      }
                      return null;
                    },
                    onFieldSubmitted: (value) {
                      profileSetupController.searchLocation(value);
                    },
                    decoration: InputDecoration(
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      label: Text.rich(
                        TextSpan(
                          text: "Location",
                          style: getTextStyle(
                            fontSize: 16,
                            color:
                                themeMode == ThemeMode.dark
                                    ? AppColors.primary
                                    : AppColors.subTextColor,
                          ),
                          children: [
                            if (!isEdit)
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
                      hintText: "New York City",
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
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your years of experiences';
                      }
                      // check if the value is a number
                      if (value.isNotEmpty) {
                        if (int.tryParse(value) == null) {
                          return 'Please enter a valid number';
                        }
                      }

                      return null;
                    },
                    controller: profileSetupController.experienceYearController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      // labelText: "Years of Experiences",
                      label: Text.rich(
                        TextSpan(
                          text: "Years of Experiences",
                          style: getTextStyle(
                            fontSize: 16,
                            color:
                                themeMode == ThemeMode.dark
                                    ? AppColors.primary
                                    : AppColors.subTextColor,
                          ),
                          children: [
                            if (!isEdit)
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
                      // hintText: "3",
                      // hintStyle: getTextStyle(
                      //   fontSize: 14,
                      //   color:
                      //       themeMode == ThemeMode.dark
                      //           ? AppColors.primary
                      //           : AppColors.textColor,
                      // ),
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

                  Row(
                    children: [
                      Text(
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
                      if (!isEdit)
                        Text(
                          " *",
                          style: getTextStyle(fontSize: 14, color: Colors.red),
                        ),
                    ],
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
                                                .spUser
                                                ?.profile
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
                  if (isEdit && SpAuthController.spUser?.profile?.isPro != true)
                    SizedBox(height: 40),
                  if (isEdit && SpAuthController.spUser?.profile?.isPro != true)
                    UpgradeToProcard(onTap: () {}),

                  SizedBox(height: 40),

                  //* ------------------ Continue Button ------------------
                  isEdit
                      ? CustomContinueButton(
                        onPress: () async {
                          if (profileSetupController.formKey.currentState!
                              .validate()) {
                            await profileSetupController.spProfileUpdate();
                            EasyLoading.dismiss();
                          }
                        },
                        title: "Update",
                      )
                      : CustomContinueButton(
                        onPress: () async {
                          if (profileSetupController.formKey.currentState!
                              .validate()) {
                            await profileSetupController.spProfileSetup();
                            EasyLoading.dismiss();
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
  }
}
