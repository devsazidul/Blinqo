import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:blinqo/core/utils/constants/icon_path.dart';
import 'package:blinqo/features/profile/controller/profile_controller.dart';
import 'package:blinqo/features/role/venue_owner/bottom_nav_bar/screen/vanueOwner_bottom_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PaymentAppBar extends StatelessWidget implements PreferredSize {
  final String title;
  final bool? isBackButtonVisible;
  final bool? isCloseButtonVisible;

  const PaymentAppBar({
    super.key,
    required this.title,
    this.isCloseButtonVisible,
    this.isBackButtonVisible = true,
  });

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = Get.put(ProfileController()).isDarkMode.value;
    return AppBar(
      backgroundColor: AppColors.backgroundColor,
      forceMaterialTransparency: true,
      leading: Padding(
        padding: const EdgeInsets.only(left: 20.0),
        child: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Visibility(
            visible: isBackButtonVisible ?? false,
            child: CircleAvatar(
              backgroundColor:
                  isDarkMode ? Color(0x1AFFFFFF) : const Color(0x1A333333),
              child: Image.asset(
                IconPath.arrowLeftAlt,
                width: 16,
                height: 12,
                color: isDarkMode ? Colors.white : AppColors.textColor,
              ),
            ),
          ),
        ),
      ),

      title: Text(
        title,
        style: getTextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w600,
          color: isDarkMode ? Colors.white : AppColors.textColor,
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 20.0),
          child: GestureDetector(
            onTap: () {
              Get.off(VanueOwnerBottomNavBar());
            },
            child: Visibility(
              visible: isCloseButtonVisible ?? false,
              child: CircleAvatar(
                backgroundColor:
                    isDarkMode ? Color(0x1AFFFFFF) : Color(0x1A333333),
                child: Image.asset(
                  IconPath.close,
                  width: 16,
                  height: 16,
                  color: isDarkMode ? Colors.white : AppColors.textColor,
                ),
              ),
            ),
          ),
        ),
      ],
      centerTitle: true,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(56.0);

  @override
  Widget get child => throw UnimplementedError();
}
