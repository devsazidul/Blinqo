import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:blinqo/core/utils/constants/icon_path.dart';
import 'package:blinqo/core/utils/theme/custom_themes/text_theme.dart';
import 'package:blinqo/features/role/service_provider/service_profile_page/controller/service_user_profile_controler.dart';
import 'package:blinqo/features/role/service_provider/service_profile_page/screen/edit_profile_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SpProfilePage extends StatelessWidget {
  SpProfilePage({super.key});

  final ServiceUserProfileControler spUserProfileControler = Get.put(
    ServiceUserProfileControler(),
  );
  final ThemeController themeController = Get.find<ThemeController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      // Observe the isDarkMode value and update the UI when it changes
      bool isDarkMode = spUserProfileControler.isDarkMode.value;

      return Scaffold(
        backgroundColor: isDarkMode ? Colors.black : Colors.white,
        appBar: _buildAppBar(context, isDarkMode), // Pass isDarkMode to AppBar
        body: ColoredBox(
          color:
              isDarkMode
                  ? Colors.black
                  : AppColors
                      .backgroundColor, // Change background color based on theme
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 40),
                _buildProfileSection(context, isDarkMode),
                SizedBox(height: 34),
                _buildSettingsSection(context, isDarkMode),
                SizedBox(height: 80),
              ],
            ),
          ),
        ),
      );
    });
  }

  AppBar _buildAppBar(BuildContext context, bool isDarkMode) {
    return AppBar(
      backgroundColor: isDarkMode ? Colors.black : AppColors.backgroundColor,
      forceMaterialTransparency: true,
      leading: Padding(
        padding: const EdgeInsets.only(left: 20.0),
        child: CircleAvatar(
          backgroundColor: const Color(0xFFD9D9D9),
          child: Image.asset(IconPath.arrowLeftAlt),
        ),
      ),
      title: Text(
        'Profile',
        style: getTextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: isDarkMode ? Colors.white : AppColors.textColor,
        ),
      ),
      centerTitle: true,
      actions: [
        IconButton(
          onPressed: () {
            _showPopupMenu(context, isDarkMode);
          },

          icon: Image.asset(
            IconPath.moreVert,
            color: isDarkMode ? Colors.white : AppColors.textColor,
          ),
        ),
      ],
    );
  }

  // Function to show the popup menu
  void _showPopupMenu(BuildContext context, bool isDarkMode) {
    // Show the popup menu
    showMenu(
      color: Colors.white,
      context: context,
      position: RelativeRect.fromLTRB(100, 50, 0, 0),
      items: [
        _buildPopupMenuItem(
          isDarkMode,
          "Edit Profile",
          "Edit Profile",
          context,
          iconPath: IconPath.editPencil,
        ),
        _buildPopupMenuItem(
          isDarkMode,
          "View As",
          "view_as",
          context,
          iconPath: IconPath.viewAs,
        ),
        _buildPopupMenuItem(
          isDarkMode,
          "Settings",
          "settings",
          context,
          iconPath: IconPath.settings,
        ),
        _buildPopupMenuItem(
          isDarkMode,
          "Go Pro",
          "go_pro",
          context,
          iconPath: IconPath.goPro,
        ),
      ],
    );
  }

  Widget _buildProfileSection(BuildContext context, bool isDarkMode) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      spacing: 10,
      children: [
        Center(
          child: CircleAvatar(
            radius: 60,
            backgroundColor: AppColors.primary,
            child: Image.asset(
              IconPath.profile01,
              width: 125,
              height: 125,
              fit: BoxFit.cover,
            ),
          ),
        ),

        // name
        Text(
          'Ronald Richards',
          style: getTextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: Color(0xFF003285),
          ),
        ),

        // location
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.location_on_outlined,
              color: isDarkMode ? Colors.white : AppColors.buttonColor2,
              size: 20,
            ),
            Text(
              'New York',
              style: getTextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: isDarkMode ? Colors.white : AppColors.textColor,
              ),
            ),
          ],
        ),

        // project
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
    return Column(
      children: [
        _buildSettingsTile(
          isDarkMode,
          iconPath: IconPath.editProfile,
          title: "Edit Profile",
          onTap: () {
            Get.to(SpEditProfilePage(), arguments: 4);
          },
        ),
        Obx(
          () => _buildSettingsTile(
            isDarkMode,
            title: "Dark mood",
            iconPath: IconPath.dartMood,
            isSwitch: true,
            switchValue: spUserProfileControler.isDarkMode.value,
            onTap: () {
              spUserProfileControler.toggleDarkMode();
              themeController.setThemeMode(
                spUserProfileControler.isDarkMode.value
                    ? ThemeMode.dark
                    : ThemeMode.light,
              );
            },
          ),
        ),
        _buildSettingsTile(
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
            switchValue: spUserProfileControler.showNotifications.value,
            onTap: () => spUserProfileControler.toggleNotifications(),
          ),
        ),
        _buildSettingsTile(
          isDarkMode,
          title: "Switch Role",
          iconPath: IconPath.switchRole,
        ),
        _buildSettingsTile(
          isDarkMode,
          title: "Payment History",
          iconPath: IconPath.paymentHistory,
        ),
        ListTile(
          minTileHeight: 60,
          contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
          title: Row(
            spacing: 10,
            children: [
              Image.asset(
                IconPath.logOut,
                width: 14.06,
                color: AppColors.buttonColor2,
              ),
              Text(
                "Log out",
                style: getTextStyle(
                  color: Color(0xFF003285),
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),

          onTap: () {},
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
                color: isDarkMode ? Color(0xffD4AF37) : AppColors.textColor,
              ),
              Text(
                title,
                style: getTextStyle(
                  color: isDarkMode ? Colors.white : AppColors.textColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),

              Spacer(),
              // switch
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

  // Helper method to build a PopupMenuItem with an icon and a Divider
  PopupMenuItem<String> _buildPopupMenuItem(
    bool isDarkMode,
    String text,
    String value,
    BuildContext context, {
    String iconPath = IconPath.editPencil,
    bool addDivider = true,
  }) {
    return PopupMenuItem<String>(
      value: value,
      // Set padding to zero since we're handling it in the Container
      padding: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Wrap in InkWell to show ripple effect
          InkWell(
            onTap: () {
              // Close the menu
              Navigator.pop(context, value);
            },
            // Make the InkWell take the full width
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                children: [
                  SizedBox(width: 10),

                  // Icon prefix
                  Padding(
                    padding: const EdgeInsets.only(right: 12.0),
                    child: Image.asset(
                      iconPath,
                      width: 15,
                      color: isDarkMode ? AppColors.textColor : Colors.white,
                    ),
                    // child: Icon(icon, size: 20, color: Colors.black87),
                  ),

                  // Menu item text
                  Text(
                    text,
                    style: getTextStyle(
                      color: Color(0xFF003285),
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      lineHeight: 1.6,
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Add divider if needed
          if (addDivider)
            const Divider(
              height: 1,
              thickness: 1,
              color: Color(0xFFEEEEEE), // Light gray color
              endIndent: 0,
              indent: 0,
            ),
        ],
      ),
    );
  }
}
