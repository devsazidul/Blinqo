import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/common/widgets/custom_appbar_widget.dart';
import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:blinqo/core/utils/constants/icon_path.dart';
import 'package:blinqo/features/profile/controller/profile_controller.dart';
import 'package:blinqo/features/profile/widget/show_profile_popup_menu.dart';
import 'package:blinqo/features/role/event_planner/payment_history/screens/payment_history_screen.dart';
import 'package:blinqo/features/role_page/screen/role_screen.dart';
import 'package:blinqo/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../role/event_planner/bottom_nav_bar/screen/event_bottom_nav_bar.dart';

class MainProfileScreen extends StatelessWidget {
  const MainProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
              Get.offAll(EventBottomNavBar());
            },
            actions: [
              IconButton(
                icon: Image.asset(
                  IconPath.moreVert,
                  width: 24,
                  height: 24,
                  color: isDarkMode ? Colors.white : AppColors.textColor,
                ),
                onPressed: () {
                  showPopupMenu(context);
                },
              ),
            ],
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
        // Obx(() {
        // return
        Stack(
          alignment: Alignment.bottomRight,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundColor: Colors.grey[300],
              child: ClipOval(
                child:
                    controller.profileImage.value == null
                        ? Image.asset(
                          IconPath.profile01,
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                        )
                        : Image.file(
                          controller.profileImage.value!,
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
                  controller.pickImage();
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
        ),
        // }),

        /// Avater name
        Text(
          'Ronald Richards',
          style: getTextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color:
                controller.isDarkMode.value
                    ? AppColors.backgroundColor
                    : Color(0xFF003285),
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
            Text(
              'Radio Colony, Savar',
              style: getTextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color:
                    controller.isDarkMode.value
                        ? AppColors.backgroundColor
                        : AppColors.textColor,
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
            Get.to(PaymentHistoryScreen());
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
        // _buildSettingsTile(
        //   controller: controller,
        //   title: "Colors",
        //   iconPath: IconPath.colorsIcon,
        //   onTap: () {
        //     Navigator.pushNamed(context, AppRoute.getPickColorScreen());
        //   },
        // ),
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
          onTap: () {},
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
