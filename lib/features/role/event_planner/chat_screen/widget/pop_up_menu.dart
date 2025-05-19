import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PopUpMenu extends StatelessWidget {
  const PopUpMenu({super.key, required this.isDarkMode});
  final bool isDarkMode;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      color:
          isDarkMode ? AppColors.textFieldDarkColor : AppColors.popUpBackground,
      onSelected: (String value) {},
      itemBuilder: (BuildContext context) {
        return [
          PopupMenuItem<String>(
            value: 'Delete',
            child: Center(
              child: Text(
                'Delete Conversation',
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400,
                  color:
                      isDarkMode ? AppColors.borderColor2 : AppColors.textColor,
                ),
              ),
            ),
          ),
          PopupMenuDivider(),
          PopupMenuItem<String>(
            value: 'Mark',
            child: Center(
              child: Text(
                'Mark as Unread',
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400,
                  color:
                      isDarkMode ? AppColors.borderColor2 : AppColors.textColor,
                ),
              ),
            ),
          ),
          PopupMenuDivider(),
          PopupMenuItem<String>(
            value: 'Block',
            child: Center(
              child: Text(
                'Block',
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400,
                  color:
                      isDarkMode ? AppColors.borderColor2 : AppColors.textColor,
                ),
              ),
            ),
          ),
          PopupMenuDivider(),
          PopupMenuItem<String>(
            value: 'Report',
            child: Center(
              child: Text(
                'Report',
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400,
                  color:
                      isDarkMode ? AppColors.borderColor2 : AppColors.textColor,
                ),
              ),
            ),
          ),
        ];
      },
      icon: Icon(
        Icons.more_vert,
        size: 26,
        color: isDarkMode ? AppColors.borderColor2 : AppColors.textColor,
      ),
    );
  }
}
