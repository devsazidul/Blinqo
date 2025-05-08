import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:blinqo/core/common/styles/global_text_style.dart';

class DropdownSelector extends StatelessWidget {
  final String? selectedValue;
  final List<String> options;
  final String hintText;
  final ValueChanged<String?> onChanged;

  const DropdownSelector({
    super.key,
    required this.selectedValue,
    required this.options,
    required this.hintText,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = Get.isDarkMode;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: isDarkMode ? Color(0xffAFB1B6) : Color(0xffABB7C2),
        ),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          isExpanded: true,
          iconSize: 24,
          style: getTextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: isDarkMode ? Color(0xffEBEBEB) : Color(0xff333333),
          ),
          hint: Text(
            hintText,
            style: getTextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: isDarkMode ? Color(0xffA1A1A1) : Color(0xff767676),
            ),
          ),
          borderRadius: BorderRadius.circular(8),
          menuWidth: Get.width * 0.7,
          icon: const Icon(Icons.arrow_drop_down, color: Color(0xff003366)),
          dropdownColor:
              isDarkMode
                  ? AppColors.darkBackgroundColor
                  : AppColors.backgroundColor,
          value: selectedValue,
          items:
              options.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }
}
