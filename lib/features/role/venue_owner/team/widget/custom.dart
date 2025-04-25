import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:flutter/material.dart';

Widget customTimeContainer({
  required String text,
  required VoidCallback onTap,
  required bool isDarkMode,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: isDarkMode ? Color(0xff003366) : Colors.grey,
            width: 1.5,
          ),
        ),
      ),
      child: Row(
        children: [
          Text(
            text,
            style: getTextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              
              color: isDarkMode ? Color(0xffEBEBEB) : Color(0xff333333),
            ),
          ),
          SizedBox(width: 30,),
          Icon(
            Icons.keyboard_arrow_down,
            color: isDarkMode ? Color(0xffEBEBEB) : Color(0xff003366),
          ),
        ],
      ),
    ),
  );
}
