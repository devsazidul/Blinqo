import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:blinqo/core/utils/constants/icon_path.dart';
import 'package:blinqo/features/role/service_provider/service_profile_page/screen/edit_profile_page.dart';
import 'package:blinqo/features/role/service_provider/service_profile_page/screen/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<void> showPopupMenu(BuildContext context) async {
  // Show the popup menu
  showMenu(
    color: Colors.white,
    context: context,
    position: RelativeRect.fromLTRB(100, 50, 0, 0),
    items: [
      _buildPopupMenuItem(
        "Edit Profile",
        "Edit Profile",
        context,
        iconPath: IconPath.editPencil,
        onTap: () {
          Get.to(SpEditProfilePage(), arguments: 4);
        },
      ),
      _buildPopupMenuItem(
        "View As",
        "view_as",
        context,
        iconPath: IconPath.viewAs,
        onTap: () {},
      ),
      _buildPopupMenuItem(
        "Settings",
        "settings",
        context,
        iconPath: IconPath.settings,
        onTap: () {
          Get.to(SpProfilePage());
        },
      ),
      _buildPopupMenuItem(
        "Go Pro",
        "go_pro",
        context,
        iconPath: IconPath.goPro,
        onTap: () {},
      ),
    ],
  );
}

// Helper method to build a PopupMenuItem with an icon and a Divider
PopupMenuItem<String> _buildPopupMenuItem(
  String text,
  String value,
  BuildContext context, {
  String iconPath = IconPath.editPencil,
  bool addDivider = true,
  required void Function() onTap,
}) {
  return PopupMenuItem<String>(
    value: value,
    padding: EdgeInsets.zero,
    child: InkWell(
      onTap: () {
        onTap();
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Wrap in InkWell to show ripple effect
          Container(
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
                    color: AppColors.textColor,
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
    ),
  );
}
