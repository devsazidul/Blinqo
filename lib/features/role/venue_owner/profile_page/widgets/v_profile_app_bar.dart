import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:blinqo/core/utils/constants/icon_path.dart';
import 'package:blinqo/features/role/venue_owner/bottom_nav_bar/screen/vanueOwner_bottom_nav_bar.dart';
import 'package:blinqo/features/role/venue_owner/profile_page/controller/venue_owner_profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VProfileAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => Size.fromHeight(56);

  const VProfileAppBar({
    super.key,
    this.title,
    this.isMoreVertIcon = true,
    this.onPressed,
  });

  final String? title;
  final bool isMoreVertIcon;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode =
        Get.put(VenueOwnerProfileController()).isDarkMode.value;
    return AppBar(
      backgroundColor: AppColors.backgroundColor,
      forceMaterialTransparency: true,
      leading: Padding(
        padding: const EdgeInsets.only(left: 20.0),
        child: GestureDetector(
          onTap: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => VanueOwnerBottomNavBar()),
              (route) => false,
            );
          },
          child: CircleAvatar(
            backgroundColor:
                isDarkMode
                    ? Color(0xFFD9D9D9).withAlpha(40)
                    : const Color(0xFFD9D9D9),
            child: Image.asset(
              IconPath.arrowLeftAlt,
              width: 16,
              height: 12,
              color: isDarkMode ? Colors.white : AppColors.textColor,
            ),
          ),
        ),
      ),
      title: Text(
        title ?? '',
        style: getTextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: isDarkMode ? AppColors.backgroundColor : AppColors.textColor,
        ),
      ),
      centerTitle: true,
      // actions: [
      //   if (isMoreVertIcon)
      //     IconButton(
      //       // onPressed: () {
      //       //   showPopupMenu(context);
      //       // },
      //       onPressed: onPressed ?? () => vShowPopupMenu(context),
      //       icon: Image.asset(
      //         IconPath.moreVert,
      //         width: 4,
      //         height: 22.5,
      //         color:
      //             isDarkMode ? AppColors.backgroundColor : AppColors.textColor,
      //       ),
      //     ),
      // ],
    );
  }
}
