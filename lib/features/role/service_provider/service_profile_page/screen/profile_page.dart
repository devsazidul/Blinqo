import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:blinqo/core/utils/constants/icon_path.dart';
import 'package:blinqo/features/role/service_provider/service_profile_page/controller/service_user_profile_controler.dart';
import 'package:blinqo/features/role/service_provider/service_profile_page/screen/edit_profile_page.dart';
import 'package:blinqo/features/role/service_provider/service_profile_page/screen/share_work_page.dart';
import 'package:blinqo/features/role/service_provider/service_profile_page/widget/profile_popup_menu_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SpProfilePage extends StatelessWidget {
  SpProfilePage({super.key});

  final ServiceUserProfileControler spUserProfileControler = Get.put(
    ServiceUserProfileControler(),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: _buildAppBar(context),
      body: ColoredBox(
        color: AppColors.backgroundColor,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 40),
              _buildProfileSection(context),
              SizedBox(height: 34),
              _buildSettingsSection(context),
              SizedBox(height: 80),
            ],
          ),
        ),
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.backgroundColor,
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
          color: AppColors.textColor,
        ),
      ),
      centerTitle: true,
      actions: [
        IconButton(
          onPressed: () {
            _showPopupMenu(context);
          },

          icon: Image.asset(IconPath.moreVert),
        ),
      ],
    );
  }

  // Function to show the popup menu
  void _showPopupMenu(BuildContext context) {
    // Show the popup menu
    showMenu(
      color: Colors.white,
      context: context,
      position: RelativeRect.fromLTRB(100, 50, 0, 0),
      items: [
        // Edit Profile
        PopupMenuItem<String>(
          padding: EdgeInsets.zero,
          onTap: () {
            Get.to(SpEditProfilePage(), arguments: 4);
          },
          // value: 'Edit Profile',
          child: ProfilePopupMenuItemWidget(
            iconPath: IconPath.editPencil,
            title: 'Edit Profile',
          ),
        ),

        // View as
        PopupMenuItem<String>(
          padding: EdgeInsets.zero,
          onTap: () {
            Get.to(SpEditProfilePage(), arguments: 4);
          },
          // value: 'view_as',
          child: ProfilePopupMenuItemWidget(
            iconPath: IconPath.viewAs,
            title: 'View As',
          ),
        ),

        // Settings
        PopupMenuItem<String>(
          padding: EdgeInsets.zero,
          height: 40,
          onTap: () {
            Get.to(SpShareWorkPage(), arguments: 4);
          },
          // value: 'settings',
          child: ProfilePopupMenuItemWidget(
            iconPath: IconPath.settings,
            title: 'Settings',
            hasDivider: false,
          ),
        ),

        // Go Pro
        PopupMenuItem<String>(
          padding: EdgeInsets.symmetric(vertical: 0),

          // height: 10,
          onTap: () {
            Get.to(SpEditProfilePage(), arguments: 4);
          },
          // value: 'go_pro',
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(width: 10),
              Image.asset(
                IconPath.goPro,
                width: 15,
                color: AppColors.textColor,
              ),
              SizedBox(width: 10),
              Container(
                margin: EdgeInsets.zero,
                decoration: BoxDecoration(
                  color: Color(0x15AF371A),
                  borderRadius: BorderRadius.circular(4),
                ),
                padding: EdgeInsets.symmetric(horizontal: 4.0),
                child: Text(
                  "Go Pro",
                  style: getTextStyle(
                    color: Color.fromARGB(255, 205, 168, 46),
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    lineHeight: 1.6,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildProfileSection(BuildContext context) {
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
              color: AppColors.buttonColor2,
              size: 20,
            ),
            Text(
              'New York',
              style: getTextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: AppColors.textColor,
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

  Widget _buildSettingsSection(BuildContext context) {
    return Column(
      children: [
        _buildSettingsTile(
          iconPath: IconPath.editProfile,
          title: "Edit Profile",
          onTap: () {
            Get.to(SpEditProfilePage(), arguments: 4);
          },
        ),
        Obx(
          () => _buildSettingsTile(
            title: "Dark mood",
            iconPath: IconPath.dartMood,
            isSwitch: true,
            switchValue: spUserProfileControler.isDarkMode.value,
            onTap: () {
              spUserProfileControler.toggleDarkMode();
            },
          ),
        ),
        _buildSettingsTile(title: "Language", iconPath: IconPath.language),
        Obx(
          () => _buildSettingsTile(
            title: "Notification",
            iconPath: IconPath.notification,
            isSwitch: true,
            switchValue: spUserProfileControler.showNotifications.value,
            onTap: () => spUserProfileControler.toggleNotifications(),
          ),
        ),
        _buildSettingsTile(title: "Switch Role", iconPath: IconPath.switchRole),
        _buildSettingsTile(
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

  Widget _buildSettingsTile({
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
              Image.asset(iconPath, width: 16, color: AppColors.textColor),
              Text(
                title,
                style: getTextStyle(
                  color: AppColors.textColor,
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
}
