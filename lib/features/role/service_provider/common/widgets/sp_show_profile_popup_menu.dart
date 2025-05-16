import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:blinqo/core/utils/constants/icon_path.dart';
import 'package:blinqo/features/role/service_provider/common/controller/auth_controller.dart';
import 'package:blinqo/features/role/service_provider/payment_page/screen/sp_get_verified_screen.dart';
import 'package:blinqo/features/role/service_provider/profile_setup_page/controller/sp_profile_setup_controller.dart';
import 'package:blinqo/features/role/service_provider/profile_setup_page/screeen/sp_profile_setup_screen.dart';
import 'package:blinqo/features/role/service_provider/sp_profile/screen/edit_profile_page.dart';
import 'package:blinqo/features/role/service_provider/sp_profile/screen/profile_settings_screen.dart';
import 'package:blinqo/features/role/service_provider/sp_profile/screen/sp_share_work_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<void> spShowPopupMenu(BuildContext context, bool isDarkMode) async {
  // Show the popup menu
  showMenu(
    color: isDarkMode ? Color(0xff32383D) : Colors.white,
    context: context,
    position: RelativeRect.fromLTRB(100, 50, 0, 0),
    items: [
      _buildPopupMenuItem(
        context,
        isDarkMode,
        text: "Edit Profile",
        value: "Edit Profile",
        iconPath: IconPath.editPencil,
        onTap: () async {
          await Get.put(SpProfileSetupController()).getEventPreferences();
          Navigator.push(
            // ignore: use_build_context_synchronously
            context,
            MaterialPageRoute(
              builder: (context) => SpProfileSetupScreen(isEdit: true),
            ),
          );
        },
      ),
      _buildPopupMenuItem(
        context,
        isDarkMode,
        text: "View As",
        value: "view_as",
        iconPath: IconPath.viewAs,
        onTap: () {
          Get.to(SpEditProfilePage());
        },
      ),
      _buildPopupMenuItem(
        context,
        isDarkMode,
        text: "Settings",
        value: "settings",
        iconPath: IconPath.settings,
        onTap: () {
          Navigator.pushNamed(context, SpProfileSettingsScreen.name);
        },
        addDivider: false,
      ),
      if (SpAuthController.spUser?.profile?.isPro != true)
        _buildPopupMenuItem(
          context,
          isDarkMode,
          text: "Go Pro",
          value: "go_pro",
          iconPath: IconPath.goPro,
          onTap: () {
            Get.to(SpGetVerifiedScreen());
          },
          addDivider: false,
          isPro: true,
        ),
    ],
  );
}

Future<void> spShowEditDeletePopup(
  BuildContext context,
  bool isDarkMode,
) async {
  // Show the popup menu
  showMenu(
    color: isDarkMode ? Color(0xff32383D) : Colors.white,
    context: context,
    position: RelativeRect.fromLTRB(100, 50, 0, 0),
    items: [
      _buildPopupMenuItem(
        context,
        isDarkMode,
        text: "Edit Project",
        value: "Edit Project",
        iconPath: IconPath.editPencil,
        onTap: () {
          Navigator.pushNamed(context, SpShareWorkScreen.name);
        },
      ),
      _buildPopupMenuItem(
        context,
        isDarkMode,
        text: "Delete Project",
        value: "Delete Project",
        iconPath: IconPath.delete,
        onTap: () {},
        addDivider: false,
      ),
    ],
  );
}

PopupMenuItem<String> _buildPopupMenuItem(
  BuildContext context,
  bool isDarkMood, {
  required String text,
  required String value,
  required void Function() onTap,
  String iconPath = IconPath.editPencil,
  bool addDivider = true,
  bool isPro = false,
}) {
  return PopupMenuItem<String>(
    onTap: onTap,
    value: value,
    padding: EdgeInsets.zero,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          constraints: BoxConstraints(
            minWidth: MediaQuery.of(context).size.width * 0.4,
          ),
          child: Row(
            children: [
              SizedBox(width: 10),
              // Icon prefix
              Padding(
                padding: const EdgeInsets.only(right: 12.0),
                child: Image.asset(
                  iconPath,
                  width: 15,
                  color: isDarkMood ? Color(0xFFD4AF37) : AppColors.textColor,
                ),
                // child: Icon(icon, size: 20, color: Colors.black87),
              ),

              // Menu item text
              if (!isPro)
                Text(
                  text,
                  style: getTextStyle(
                    color: isDarkMood ? Color(0xFFEBEBEB) : Color(0xFF003285),
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    lineHeight: 1.6,
                  ),
                ),
              if (isPro)
                Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: Color(0xD4AF371A).withAlpha(10),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    text,
                    style: getTextStyle(
                      color: Color(0xFFD4AF37),
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      lineHeight: 1.6,
                    ),
                  ),
                ),
            ],
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
