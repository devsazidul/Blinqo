import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:blinqo/core/utils/constants/icon_path.dart';
import 'package:blinqo/features/role/venue_owner/owern_network_caller/even_authcontroller.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:blinqo/features/role/venue_owner/profile_page/controller/venue_owner_profile_controller.dart';
import 'package:blinqo/features/role/venue_owner/profile_page/screen/v_edit_profile_page.dart';
import 'package:blinqo/features/role/venue_owner/profile_page/widgets/v_profile_app_bar.dart';
import 'package:blinqo/features/role/venue_owner/venue_payment_history/screens/v_payment_history_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VenueOwnerProfilePage extends StatelessWidget {
  static const String name = '/venue-owner-profile';

  const VenueOwnerProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final VenueOwnerProfileController controller = Get.put(
      VenueOwnerProfileController(),
      permanent: true,
    );

    return Obx(() {
      // Get the current theme mode (light or dark)
      final themeMode =
          controller.isDarkMode.value ? ThemeMode.dark : ThemeMode.light;

      return Scaffold(
        backgroundColor:
            themeMode == ThemeMode.dark
                ? Colors.black
                : AppColors.backgroundColor,
        appBar: VProfileAppBar(title: "Profile"),
        body: ColoredBox(
          color:
              themeMode == ThemeMode.dark
                  ? Colors.black
                  : AppColors.backgroundColor,
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 40),
                _buildProfileSection(context, themeMode, controller),
                SizedBox(height: 34),
                _buildSettingsSection(context, themeMode),
                SizedBox(height: 80),
              ],
            ),
          ),
        ),
      );
    });
  }

  Widget _buildProfileSection(
    BuildContext context,
    ThemeMode themeMode,
    VenueOwnerProfileController controller,
  ) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      spacing: 10,
      children: [
        /// Avater image
        Stack(
          alignment: Alignment.bottomRight,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundColor: Colors.grey[300],
              child: ClipOval(
                child:
                    controller.user?.profile!.image == null
                        ? Image.asset(
                          IconPath.profile01,
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                        )
                        : CachedNetworkImage(
                          imageUrl: controller.user!.profile!.image!.path,
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                        ),
              ),
            ),
          ],
        ),

        /// Avater name
        Text(
          EventAuthController.profileInfo?.name ?? "Unknown",
          style: getTextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color:
                themeMode == ThemeMode.dark
                    ? AppColors.backgroundColor
                    : Color(0xFF003285),
          ),
        ),
        // show user in container in beautiful way
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
            color:
                themeMode == ThemeMode.dark
                    ? AppColors.buttonColor
                    : const Color(0x19003366),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('username:'),
              SizedBox(width: 5),
              Text(
                EventAuthController.profileInfo?.profile?.name ?? "Unknown",
                style: getTextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color:
                      themeMode == ThemeMode.dark
                          ? AppColors.backgroundColor
                          : AppColors.textColor,
                ),
              ),
            ],
          ),
        ),
        // location
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.location_on_outlined,
              color:
                  themeMode == ThemeMode.dark
                      ? AppColors.buttonColor
                      : AppColors.buttonColor2,
              size: 20,
            ),
            Text(
              EventAuthController.profileInfo?.profile?.location ?? "Unknown",
              style: getTextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color:
                    themeMode == ThemeMode.dark
                        ? AppColors.backgroundColor
                        : AppColors.textColor,
              ),
            ),
          ],
        ),
        // project
        Text(
          'Venue 10',
          style: getTextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: Color(0xFF5C5C5C),
          ),
        ),
      ],
    );
  }

  Widget _buildSettingsSection(BuildContext context, ThemeMode themeMode) {
    final VenueOwnerProfileController controller = Get.put(
      VenueOwnerProfileController(),
    );
    return Column(
      children: [
        _buildSettingsTile(
          themeMode,
          iconPath: IconPath.editProfile,
          title: "Edit Profile",
          onTap: () {
            // Navigator.pushNamed(context, SpEditProfilePage.name);
            Get.to(VEditProfilePage(isEditProfile: true));
          },
        ),
        Obx(
          () => _buildSettingsTile(
            themeMode,
            title: "Dark Mode",
            iconPath: IconPath.dartMood,
            // Replace with your actual icon path
            isSwitch: true,
            switchValue: controller.isDarkMode.value,
            onTap: () {
              // Toggle the dark mode using the
              controller.toggleDarkMode();
            },
          ),
        ),
        Obx(
          () => _buildSettingsTile(
            themeMode,
            title: "Notification",
            iconPath: IconPath.notification,
            isSwitch: true,
            switchValue: controller.showNotifications.value,
            onTap: () => controller.toggleNotifications(),
          ),
        ),
        _buildSettingsTile(
          themeMode,
          title: "Switch Role",
          iconPath: IconPath.switchRole,
        ),
        _buildSettingsTile(
          onTap: () {
            Get.to(VPaymentHistoryScreen());
          },
          themeMode,
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
                width: 20.06,
                color:
                    themeMode == ThemeMode.dark
                        ? AppColors.buttonColor
                        : AppColors.buttonColor2,
              ),
              Text(
                "Log out",
                style: getTextStyle(
                  color:
                      themeMode == ThemeMode.dark
                          ? AppColors.buttonColor
                          : Color(0xFF003285),
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          onTap: () {
            controller.logout();
          },
        ),
      ],
    );
  }

  Widget _buildSettingsTile(
    ThemeMode themeMode, {
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
                    themeMode == ThemeMode.dark
                        ? AppColors.buttonColor
                        : AppColors.textColor,
              ),
              Text(
                title,
                style: getTextStyle(
                  color:
                      themeMode == ThemeMode.dark
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
