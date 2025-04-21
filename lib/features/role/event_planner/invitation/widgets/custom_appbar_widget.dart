import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:blinqo/core/utils/constants/icon_path.dart';
import 'package:blinqo/features/role/service_provider/service_profile_page/controller/service_user_profile_controler.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomAppBarWidget extends StatelessWidget
    implements PreferredSizeWidget {
  @override
  Size get preferredSize => Size.fromHeight(56);

  const CustomAppBarWidget({
    super.key,
    this.title,
    this.onPressed,
    this.actions,
  });

  final String? title;
  final void Function()? onPressed;
  final List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = Get.put(SpProfileController()).isDarkMode.value;
    return AppBar(
      backgroundColor: AppColors.backgroundColor,
      forceMaterialTransparency: true,
      leading: Padding(
        padding: const EdgeInsets.only(left: 20.0),
        child: GestureDetector(
          onTap: () {
            Get.back();
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
      actions: actions ?? [],
    );
  }
}
