import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:flutter/material.dart';

class EpVenueDeatilsCustomWidget extends StatelessWidget {
  final String imagePath;
  final String guestText;

  const EpVenueDeatilsCustomWidget({
    super.key,
    required this.imagePath,
    required this.guestText,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(imagePath, width: 20, height: 20, fit: BoxFit.cover),
        SizedBox(width: 5),
        Text(
          guestText,
          style: getTextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: AppColors.textColor,
          ),
        ),
      ],
    );
  }
}
