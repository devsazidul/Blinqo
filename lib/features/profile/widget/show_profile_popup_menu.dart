import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:blinqo/core/utils/constants/icon_path.dart';
import 'package:blinqo/features/profile/controller/profile_controller.dart';
import 'package:blinqo/features/role/service_provider/service_profile_page/screen/edit_profile_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<void> showPopupMenu(BuildContext context) async {
  // Show the popup menu
  showMenu(
    color:
        Get.find<ProfileController>().isDarkMode.value
            ? Color(0xff32383D)
            : Colors.white,
    context: context,
    position: RelativeRect.fromLTRB(100, 50, 0, 0),
    items: [
      _buildPopupMenuItem(
        context,
        text: "Edit Profile",
        value: "Edit Profile",
        iconPath: IconPath.editPencil,
        onTap: () {
          // Navigator.pushNamed(context, EditProfilePage.name);
        },
      ),
      _buildPopupMenuItem(
        context,
        text: "View As",
        value: "view_as",
        iconPath: IconPath.viewAs,
        onTap: () {},
      ),
      _buildPopupMenuItem(
        context,
        text: "Settings",
        value: "settings",
        iconPath: IconPath.settings,
        onTap: () {
          // Navigator.pushNamed(context, SpProfilePage.name);
        },
        addDivider: false,
      ),
      _buildPopupMenuItem(
        context,
        text: "Go Pro",
        value: "go_pro",
        iconPath: IconPath.goPro,
        onTap: () {},
        addDivider: false,
        isPro: true,
      ),
    ],
  );
}

Future<void> showEditDeletePopup(BuildContext context) async {
  // Show the popup menu
  showMenu(
    color: Colors.white,
    context: context,
    position: RelativeRect.fromLTRB(100, 50, 0, 0),
    items: [
      _buildPopupMenuItem(
        context,
        text: "Edit Project",
        value: "Edit Project",
        iconPath: IconPath.editPencil,
        onTap: () {
          Navigator.pushNamed(context, SpEditProfilePage.name);
        },
      ),
      _buildPopupMenuItem(
        context,
        text: "Delete Project",
        value: "Delete Project",
        iconPath: IconPath.delete,
        onTap: () {},
        addDivider: false,
      ),
    ],
  );
}

// Helper method to build a PopupMenuItem with an icon and a Divider
PopupMenuItem<String> _buildPopupMenuItem(
  BuildContext context, {
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
                  color:
                      Get.find<ProfileController>().isDarkMode.value
                          ? Color(0xFFD4AF37)
                          : AppColors.textColor,
                ),
                // child: Icon(icon, size: 20, color: Colors.black87),
              ),

              // Menu item text
              if (!isPro)
                Text(
                  text,
                  style: getTextStyle(
                    color:
                        Get.find<ProfileController>().isDarkMode.value
                            ? Color(0xFFEBEBEB)
                            : Color(0xFF003285),
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
