import 'package:flutter/material.dart';
import 'package:blinqo/core/utils/constants/colors.dart';

class CustomCircleAvater extends StatelessWidget {
  final String imagePath;
  final String text;

  const CustomCircleAvater({
    super.key,
    required this.imagePath,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 60,
          backgroundColor: AppColors.primary,
          child: Image.asset(imagePath, width: 110, height: 131),
        ),
        SizedBox(height: 10),
        Text(
          text,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: AppColors.textColor,
          ),
        ),
      ],
    );
  }
}
