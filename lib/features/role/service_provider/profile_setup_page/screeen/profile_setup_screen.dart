import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/common/widgets/customcontinuebutton.dart';
import 'package:blinqo/core/common/widgets/upgrade_to_pro.dart';
import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:blinqo/core/utils/constants/icon_path.dart';
import 'package:blinqo/features/role/service_provider/auth/controller/auth_controller.dart';
import 'package:blinqo/features/role/service_provider/auth/controller/sp_login_controller.dart';
import 'package:blinqo/features/role/service_provider/payment_page/screen/get_verified_screen.dart';
import 'package:blinqo/features/role/service_provider/profile_setup_page/controller/profile_setup_controller.dart';
import 'package:blinqo/features/role/service_provider/profile_setup_page/widget/customcircleavater.dart';
import 'package:blinqo/features/role/service_provider/service_profile_page/controller/service_user_profile_controler.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ProfileSetupScreen extends StatelessWidget {
  ProfileSetupScreen({super.key});
  final ProfileSetupController profileController = Get.put(
    ProfileSetupController(),
  );
  final controller = Get.put(SpProfileController());

  void getToken() async {
    // final SpAuthController authController = Get.put(SpAuthController());
    print(await SpAuthController().getAccessToken());
  }

  @override
  Widget build(BuildContext context) {
    getToken();
    print(Get.put(SpLoginController()).user?.email);
    profileController.initMarkers();
    return Obx(() {
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
                  TextFormField(
                    controller: profileController.spnameController,
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

                      hintText: "Guy Hawkins",
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
                    controller: profileController.splocationController,
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
                                CameraUpdate.newLatLng(
                                  profileController.center,
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

                  SizedBox(height: 20),
                  TextFormField(
                    controller: profileController.spyearController,
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
                    onTap:
                        profileController.pickCoverImage, // Trigger image pick
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

                  SizedBox(height: 40),
                  UpgradeToProcard(onTap: () {}),
                  SizedBox(height: 40),
                  CustomContinueButton(
                    onPress: () {
                      Get.to(GetVerifiedScreen());
                    },
                    title: "Continue",
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
