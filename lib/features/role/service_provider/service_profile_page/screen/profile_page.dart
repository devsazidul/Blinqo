import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:blinqo/core/utils/constants/icon_path.dart';
import 'package:blinqo/features/role/service_provider/service_profile_page/screen/edit_profile_page.dart';
import 'package:blinqo/features/role/service_provider/service_profile_page/screen/share_work_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SpProfilePage extends StatelessWidget {
  const SpProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
        forceMaterialTransparency: true,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
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
              Get.to(SpShareWorkPage(), arguments: 4);
            },
            icon: Image.asset(IconPath.moreVert),
          ),
        ],
      ),
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
              color: AppColors.textColor,
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
          'Project - 10',
          style: getTextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: AppColors.textColor,
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
        _buildSettingsTile(
          title: "Dark mood",
          iconPath: IconPath.dartMood,
          isSwitch: true,
        ),
        _buildSettingsTile(title: "Language", iconPath: IconPath.language),
        _buildSettingsTile(
          title: "Notification",
          iconPath: IconPath.notification,
          isSwitch: true,
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
                color: AppColors.textColor,
              ),
              Text(
                "Log out",
                style: getTextStyle(
                  color: AppColors.textColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          // trailing: Switch(value: false, onChanged: (value) {}),
          onTap: () {},
        ),
        // _buildSettingsTile(title: "Log out", iconPath: IconPath.logOut),
      ],
    );
  }

  Widget _buildSettingsTile({
    required String iconPath,
    required String title,
    void Function()? onTap,
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
              Image.asset(iconPath, width: 14.06, color: AppColors.textColor),
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
                  value: true,
                  onChanged: (value) {},
                  activeTrackColor: AppColors.buttonColor2,
                ),
            ],
          ),
          // trailing: Switch(value: false, onChanged: (value) {}),
          onTap: onTap,
        ),
        const Divider(height: 1, color: Color(0xFFEBEBEB)),
      ],
    );
  }
}
