import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:flutter/material.dart';

class ThemeStyle {
  ThemeStyle._();
  // static final bool isDarkMode = Get.find<ProfileController>().isDarkMode.value;

  /// Text Color2: Dark: [151515], Light: [F4F4F4]
  static Color bodyBackgroundColor(bool isDarkMode) =>
      isDarkMode ? AppColors.darkBackgroundColor : AppColors.backgroundColor;

  /// Text Color2: Dark: [white], Light: [black]
  static Color whiteBlackColor(bool isDarkMode) =>
      isDarkMode ? Colors.white : Colors.black;

  // darkLight1: dark:[003366], light: [#E4E4E7]
  static Color darkLight1(bool isDarkMode) =>
      isDarkMode ? Color(0xFF003366) : Color(0xFFE4E4E7);

  /// Text Color2: Dark: [343A40], Light: [efefef]
  static Color darkGreyWhite(bool isDark) =>
      isDark ? Color(0xff343A40) : Color(0xffefefef);

  /// Text Color2: Dark: [2E2E2E], Light: [D9D9D9]
  static Color circleAvatarColor(bool isDarkMode) =>
      isDarkMode ? Color(0xff2E2E2E) : Color(0xFFD9D9D9);

  /// Text Color1: Dark: [ebebeb], Light: [171725]
  static Color text1(bool isDarkMode) =>
      isDarkMode ? Color(0xffebebeb) : Color(0xff171725);

  /// Text Color2: Dark: [ebebeb], Light: [003366]
  static Color text2(bool isDarkMode) =>
      isDarkMode ? Color(0xffebebeb) : Color(0xff003366);

  /// Gold to Black: Dark: [D4AF37], Light: [003366]
  static Color goldToBlack(bool isDarkMode) =>
      isDarkMode ? Color(0xffD4AF37) : Color(0xff003366);

  /// Gold to Black: Dark: [D4AF37], Light: [003285]
  static Color goldToDark(bool isDarkMode) =>
      isDarkMode ? Color(0xffD4AF37) : Color(0xff003285);
}
