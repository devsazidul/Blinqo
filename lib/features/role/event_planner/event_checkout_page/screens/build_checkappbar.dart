import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:blinqo/core/utils/constants/icon_path.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

AppBar buildCheckVenueAppBar() {
  return AppBar(
    backgroundColor: AppColors.backgroundColor,
    forceMaterialTransparency: true,
    leading: Padding(
      padding: const EdgeInsets.fromLTRB(16.0, 8.0, 8.0, 8.0),
      child: GestureDetector(
        onTap: () {
          Get.back();
        },
        child: CircleAvatar(
          backgroundColor: const Color(0xFFD9D9D9),
          child: Image.asset(IconPath.arrowLeftAlt, width: 20),
        ),
      ),
    ),
    title: Text(
      'Checklist',
      style: getTextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: AppColors.textColor,
      ),
    ),
    centerTitle: true,
  );
}
