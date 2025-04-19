import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:blinqo/core/utils/constants/icon_path.dart';
import 'package:flutter/material.dart';

class VPaymentAppBar extends StatelessWidget implements PreferredSize {
  final String title;
  final bool? isBackButtonVisible;
  final bool? isCloseButtonVisible;

  const VPaymentAppBar({
    super.key,
    required this.title,
    this.isCloseButtonVisible, this.isBackButtonVisible =true,
  });

  @override
  Widget build(BuildContext context) {
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
              backgroundColor: const Color(0x1A333333),
              child: Image.asset(
                IconPath.arrowLeftAlt,
                width: 16,
                height: 12,
                color: AppColors.textColor,
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
          color: AppColors.textColor,
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 20.0),
          child: GestureDetector(
            onTap: () {
              // Add your onTap logic here
            },
            child: Visibility(
              visible: isCloseButtonVisible ?? false,
              child: CircleAvatar(
                backgroundColor: const Color(0x1A333333),
                child: Image.asset(
                  IconPath.close,
                  width: 16,
                  height: 16,
                  color: AppColors.textColor,
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
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(56.0);

  @override
  // TODO: implement child
  Widget get child => throw UnimplementedError();
}
