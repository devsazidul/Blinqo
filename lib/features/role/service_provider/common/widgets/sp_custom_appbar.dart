import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:blinqo/core/utils/constants/icon_path.dart';
import 'package:blinqo/features/role/service_provider/sp_profile/controller/sp_profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SpCustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => Size.fromHeight(56);

  const SpCustomAppBar({
    super.key,
    this.title,
    this.isBackButton = true,
    this.onPressed,
    this.actions,
  });

  final String? title;
  final bool? isBackButton;
  final void Function()? onPressed;
  final List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SpProfileController>(
      builder: (controller) {
        bool isDarkMode = controller.isDarkMode.value;
        return AppBar(
          backgroundColor:
              isDarkMode
                  ? AppColors.darkBackgroundColor
                  : AppColors.backgroundColor,
          forceMaterialTransparency: true,
          leading:
              isBackButton == true
                  ? Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: GestureDetector(
                      onTap:
                          onPressed ??
                          () {
                            Navigator.pop(context);
                          },
                      child: CircleAvatar(
                        backgroundColor:
                            isDarkMode
                                ? Color(0xFFD9D9D9).withValues(alpha: 0.4)
                                : const Color(
                                  0xFFD9D9D9,
                                ).withValues(alpha: 0.4),
                        child: Image.asset(
                          IconPath.arrowLeftAlt,
                          width: 16,
                          height: 12,
                          color:
                              isDarkMode ? Colors.white : AppColors.textColor,
                        ),
                      ),
                    ),
                  )
                  : null,

          title: Text(
            title ?? '',
            style: getTextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: isDarkMode ? Colors.red : AppColors.textColor,
            ),
          ),
          centerTitle: true,
          actions: actions ?? [],
        );
      },
    );
  }
}
