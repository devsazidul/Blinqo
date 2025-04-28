import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/utils/constants/icon_path.dart';
import 'package:flutter/material.dart';

class AmenityButton extends StatelessWidget {
  final String icon;
  final String label;

  const AmenityButton({super.key,
    required this.icon,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Color(0xffFBF7EB), // Light background color
        borderRadius: BorderRadius.circular(34), // Rounded corners
        boxShadow: [
          BoxShadow(
            color: Color(0xff000000).withValues(alpha: .1),
            blurRadius: 3,
            offset: Offset(0, 3),
          ),
        ]
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(icon , width: 16, height: 16),
          SizedBox(width: 6),
          Text(
            label,
            style: getTextStyle(
              fontSize: 14,
              color: Color(0xff333333),
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
