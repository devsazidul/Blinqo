import 'package:blinqo/core/common/controllers/fetch_sp_types_controller.dart';
import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:blinqo/core/utils/constants/icon_path.dart';
import 'package:blinqo/features/role/service_provider/bottom_nav_bar/widget/sp_bottom_nav_bar.dart';
import 'package:blinqo/features/role/service_provider/common/controller/auth_controller.dart';
import 'package:blinqo/features/role/service_provider/profile_setup_and_edit/controller/sp_profile_update_setup_controller.dart';
import 'package:blinqo/features/role/service_provider/profile_setup_and_edit/screeen/sp_profile_setup_&_edit_screen.dart';
import 'package:blinqo/features/role/service_provider/sp_profile/controller/sp_profile_controller.dart';
import 'package:blinqo/features/role/service_provider/sp_profile/widget/sp_profile_app_bar.dart';
import 'package:blinqo/features/role_page/screen/role_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SpProfileSettingsScreen extends StatelessWidget {
  static const String name = '/sp_profile_settings';

  const SpProfileSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SpProfileController());
    return Obx(() {
      return Scaffold(
        backgroundColor:
            controller.isDarkMode.value
                ? AppColors.darkBackgroundColor
                : AppColors.backgroundColor,
        appBar: SpProfileAppBar(title: "Profile"),
        body: ColoredBox(
          color:
              controller.isDarkMode.value
                  ? Colors.black
                  : AppColors.backgroundColor,
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 40),
                //* ------------ Profile Section ------------
                _buildProfileSection(
                  context,
                  controller.isDarkMode.value,
                  controller,
                ),
                SizedBox(height: 34),

                //* ------------ Settings Section ------------
                _buildSettingsSection(context, controller.isDarkMode.value),
                SizedBox(height: 80),
              ],
            ),
          ),
        ),
        bottomNavigationBar: SpBottomNavBarWidget(selectedIndex: 5),
      );
    });
  }

  Widget _buildProfileSection(
    BuildContext context,
    bool isDarkMode,
    SpProfileController controller,
  ) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      spacing: 10,
      children: [
        /// Avatar image
        Stack(
          alignment: Alignment.bottomRight,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundColor: Colors.grey[300],
              child: ClipOval(
                child: Image.network(
                  SpAuthController.spUser?.profile?.image?.path ??
                      "https://cdn-icons-png.flaticon.com/512/20/20079.png",
                  fit: BoxFit.cover,
                  width: 100,
                  height: 100,
                  errorBuilder: (context, error, stackTrace) {
                    return Image.asset(
                      IconPath.profile01,
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                    );
                  },
                ),
              ),
            ),
            if (SpAuthController.spUser?.profile?.isPro != false)
              Positioned(
                bottom: -4,
                right: -5,
                child: CircleAvatar(
                  radius: 18,
                  backgroundColor: Colors.transparent,
                  child: Image.asset(
                    IconPath.verifiedlogo,
                    width: 24,
                    height: 24,
                  ),
                ),
              ),
          ],
        ),

        /// Avatar name
        Text(
          SpAuthController.spUser?.name ?? "unknown",
          style: getTextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: isDarkMode ? AppColors.backgroundColor : Color(0xFF003285),
          ),
        ),
        // Location
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.location_on_outlined,
              color:
                  isDarkMode ? AppColors.buttonColor : AppColors.buttonColor2,
              size: 20,
            ),
            Text(
              SpAuthController.spUser?.profile?.location ?? "unknown",
              style: getTextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color:
                    isDarkMode
                        ? AppColors.backgroundColor
                        : AppColors.textColor,
              ),
            ),
          ],
        ),
        // Project
        Text(
          'Project-10',
          style: getTextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: Color(0xFF5C5C5C),
          ),
        ),
      ],
    );
  }

  Widget _buildSettingsSection(BuildContext context, bool isDarkMode) {
    final controller = Get.put(SpProfileController());
    final profileSetupController = Get.put(SpProfileUpdateSetupController());
    final spTypeController = Get.put(ServiceProviderTypesController());
    return Column(
      children: [
        _buildSettingsTile(
          isDarkMode,
          iconPath: IconPath.editProfile,
          title: "Edit Profile",
          onTap: () async {
            profileSetupController.clearAllData();
            await profileSetupController.getEventPreferences();
            await spTypeController.fetchServiceProviderTypes();
            Get.to(SpProfileSetupAndEditScreen(isEdit: true));
          },
        ),
        Obx(
          () => _buildSettingsTile(
            isDarkMode,
            title: "Dark Mode",
            iconPath: IconPath.dartMood, // Replace with your actual icon path
            isSwitch: true,
            switchValue: controller.isDarkMode.value,
            onTap: () {
              // Toggle the dark mode using the spUserProfileControler
              controller.toggleDarkMode();
              Get.isDarkMode
                  ? Get.changeThemeMode(ThemeMode.light)
                  : Get.changeThemeMode(ThemeMode.dark);
            },
          ),
        ),
        _buildSettingsTile(
          onTap: () {},
          isDarkMode,
          title: "Language",
          iconPath: IconPath.language,
        ),
        Obx(
          () => _buildSettingsTile(
            isDarkMode,
            title: "Notification",
            iconPath: IconPath.notification,
            isSwitch: true,
            switchValue: controller.showNotifications.value,
            onTap: () => controller.toggleNotifications(),
          ),
        ),
        _buildSettingsTile(
          isDarkMode,
          title: "Switch Role",
          iconPath: IconPath.switchRole,
          onTap: () async {
            await SpAuthController.clearUserData();
            Get.delete<
              SpProfileUpdateSetupController
            >(); // Delete the controller instance
            Get.offAll(() => RoleScreen());
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
                    isDarkMode ? AppColors.buttonColor : AppColors.buttonColor2,
              ),
              Text(
                "Log out",
                style: getTextStyle(
                  color: isDarkMode ? AppColors.buttonColor : Color(0xFF003285),
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          onTap: () async {
            await SpAuthController.clearUserData();
            Get.delete<
              SpProfileUpdateSetupController
            >(); // Delete the controller instance
            Get.offAll(() => RoleScreen());
          },
        ),
      ],
    );
  }

  Widget _buildSettingsTile(
    bool isDarkMode, {
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
                color: isDarkMode ? AppColors.buttonColor : AppColors.textColor,
              ),
              Text(
                title,
                style: getTextStyle(
                  color:
                      isDarkMode
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
