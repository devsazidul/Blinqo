import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:flutter/material.dart';

class ProfilePopupMenuItemWidget extends StatelessWidget {
  const ProfilePopupMenuItemWidget({
    super.key,
    required this.iconPath,
    required this.title,
    this.hasDivider = true,
  });

  final String iconPath;
  final String title;
  final bool hasDivider;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        minWidth: MediaQuery.of(context).size.width * 0.4,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              SizedBox(width: 10),
              Image.asset(iconPath, width: 15, color: AppColors.textColor),
              SizedBox(width: 10),
              Text(
                title,
                style: getTextStyle(
                  color: Color(0xFF003285),
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  lineHeight: 1.6,
                ),
              ),
            ],
          ),
          Divider(
            // height: 1,
            color: hasDivider ? Color(0xFFEEEEEE) : Colors.transparent,
            // thickness: 1,
          ),
        ],
      ),
    );
  }
}
