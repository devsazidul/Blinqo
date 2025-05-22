import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/common/widgets/custom_appbar_widget.dart';
import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:blinqo/core/utils/constants/icon_path.dart';
import 'package:blinqo/features/role/event_planner/main_layout/screen/ep_main_layout_screen.dart';
import 'package:blinqo/features/role/event_planner/payment_history/screens/payment_history_screen.dart';
import 'package:blinqo/features/role/event_planner/profile/controller/pick_color_controller.dart';
import 'package:blinqo/features/role/event_planner/profile/controller/profile_controller.dart';
import 'package:blinqo/features/role_page/screen/role_screen.dart';
import 'package:blinqo/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class MainProfileScreen extends StatelessWidget {
  MainProfileScreen({super.key});

  ProfileController profileController = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    profileController.getUser();
    return GetBuilder<ProfileController>(
      builder: (controller) {
        bool isDarkMode = controller.isDarkMode.value;
        return Scaffold(
          backgroundColor:
              isDarkMode
                  ? AppColors.darkBackgroundColor
                  : AppColors.backgroundColor,

          appBar: CustomAppBarWidget(
            title: "Profile",
            onPressed: () {
              Get.offAll(EventPlannerMainLayoutScreen());
            },
            // actions: [
            //   IconButton(
            //     icon: Image.asset(
            //       IconPath.moreVert,
            //       width: 24,
            //       height: 24,
            //       color: isDarkMode ? Colors.white : AppColors.textColor,
            //     ),
            //     onPressed: () {
            //       showPopupMenu(context);
            //     },
            //   ),
            // ],
          ),
          body: ColoredBox(
            color:
                isDarkMode
                    ? AppColors.darkBackgroundColor
                    : AppColors.backgroundColor,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 40),
                  _buildProfileSection(context, controller),
                  SizedBox(height: 34),
                  _buildSettingsSection(context),
                  SizedBox(height: 80),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildProfileSection(
    BuildContext context,
    ProfileController controller,
  ) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      spacing: 10,
      children: [
        /// Avater image
        Obx(() {
          return Stack(
            alignment: Alignment.bottomRight,
            children: [
              CircleAvatar(
                radius: 50,
                backgroundColor: Colors.grey[300],
                child: ClipOval(
                  child:
                      profileController
                                  .userInfo
                                  .value
                                  ?.data
                                  ?.profile
                                  ?.image
                                  ?.path
                                  ?.isNotEmpty ==
                              true
                          ? Image.network(
                            profileController
                                .userInfo
                                .value!
                                .data!
                                .profile!
                                .image!
                                .path!,
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover,
                            errorBuilder:
                                (context, error, stackTrace) => Image.asset(
                                  IconPath.profile01,
                                  width: 100,
                                  height: 100,
                                  fit: BoxFit.cover,
                                ),
                          )
                          : Image.asset(
                            IconPath.profile01,
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover,
                          ),
                ),
              ),
            ],
          );
        }),

        /// Avater name˝
        Obx(
          () => Text(
            profileController.userInfo.value?.data?.name?.isNotEmpty == true
                ? profileController.userInfo.value!.data!.name!
                : 'Ronald Richards',
            style: getTextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color:
                  controller.isDarkMode.value
                      ? AppColors.backgroundColor
                      : AppColors.textColor,
            ),
          ),
        ),
        // location
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 6,
          children: [
            Image.asset(
              IconPath.locationOn,
              width: 16,
              height: 16,
              color:
                  controller.isDarkMode.value
                      ? AppColors.backgroundColor
                      : AppColors.buttonColor2,
              // size: 20,
            ),
            Obx(
              () => Text(
                profileController
                            .userInfo
                            .value
                            ?.data
                            ?.profile
                            ?.location
                            ?.isNotEmpty ==
                        true
                    ? profileController.userInfo.value!.data!.profile!.location!
                    : 'Unknown Location',
                style: getTextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color:
                      controller.isDarkMode.value
                          ? AppColors.backgroundColor
                          : AppColors.textColor,
                ),
              ),
            ),
          ],
        ),
        // project
        // Text(
        //   'Project-10',
        //   style: getTextStyle(
        //     fontSize: 14,
        //     fontWeight: FontWeight.w400,
        //     color: Color(0xFF5C5C5C),
        //   ),
        // ),
      ],
    );
  }

  Widget _buildSettingsSection(BuildContext context) {
    final controller = Get.put(ProfileController());
    return Column(
      children: [
        _buildSettingsTile(
          controller: controller,
          iconPath: IconPath.editProfile,
          title: "Edit Profile",
          onTap: () {
            Navigator.pushNamed(context, AppRoute.getEditProfileScreen());
            // Get.toNamed(AppRoute.getEditProfileScreen());
          },
        ),
        Obx(
          () => _buildSettingsTile(
            controller: controller,
            title: "Dark Mode",
            iconPath: IconPath.dartMood, // Replace with your actual icon path
            isSwitch: true,
            switchValue: controller.isDarkMode.value,
            onTap: () {
              // Toggle the dark mode using the spUserProfileControler
              controller.toggleDarkMode();
            },
          ),
        ),
        // _buildSettingsTile(
        //   onTap: () {
        //     Get.to(EpVenueDetails());
        //   },
        //   controller: controller,
        //   title: "Language",
        //   iconPath: IconPath.language,
        // ),
        Obx(
          () => _buildSettingsTile(
            controller: controller,
            title: "Notification",
            iconPath: IconPath.notification,
            isSwitch: true,
            switchValue: controller.showNotifications.value,
            onTap: () => controller.toggleNotifications(),
          ),
        ),
        _buildSettingsTile(
          controller: controller,
          title: "Payment Historty",
          iconPath: IconPath.paymentHistory,
          onTap: () {
            Get.to(EvenPaymentHistoryScreen());
          },
        ),
        _buildSettingsTile(
          controller: controller,
          title: "Switch Role",
          iconPath: IconPath.switchRole,
          onTap: () {
            Get.offAll(() => const RoleScreen());
          },
        ),
        //* Colors
        if (Get.put(PickColorController()).isFemale.value == true &&
            controller.isDarkMode.value == false)
          _buildSettingsTile(
            controller: controller,
            title: "Colors",
            iconPath: IconPath.colorsIcon,
            onTap: () {
              Navigator.pushNamed(context, AppRoute.getPickColorScreen());
            },
          ),
        ListTile(
          minTileHeight: 60,
          contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
          title: Row(
            spacing: 10,
            children: [
              Image.asset(
                IconPath.logOut,
                width: 20.06,
                color:
                    controller.isDarkMode.value
                        ? AppColors.buttonColor
                        : AppColors.buttonColor2,
              ),
              Text(
                "Log out",
                style: getTextStyle(
                  color:
                      controller.isDarkMode.value
                          ? AppColors.buttonColor
                          : Color(0xFF003285),
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          onTap: () {
            profileController.logOut();
          },
        ),
      ],
    );
  }

  Widget _buildSettingsTile({
    required ProfileController controller,
    required String iconPath,
    required String title,
    void Function()? onTap,
    bool switchValue = false,
    void Function(bool)? onChanged,
    bool isSwitch = false,
  }) {
    return Column(
      children: [
        ListTile(
          minTileHeight: 60,
          contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
          title: Row(
            spacing: 10,
            children: [
              Image.asset(
                iconPath,
                width: 16,
                color:
                    controller.isDarkMode.value
                        ? AppColors.buttonColor
                        : AppColors.textColor,
              ),
              Text(
                title,
                style: getTextStyle(
                  color:
                      controller.isDarkMode.value
                          ? AppColors.backgroundColor
                          : AppColors.textColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Spacer(),
              if (isSwitch)
                Switch(
                  value: switchValue,
                  onChanged: onChanged,
                  activeTrackColor: AppColors.buttonColor2,
                ),
            ],
          ),
          onTap: onTap,
        ),
        const Divider(height: 1, color: Color(0xFFEBEBEB)),
      ],
    );
  }
}
