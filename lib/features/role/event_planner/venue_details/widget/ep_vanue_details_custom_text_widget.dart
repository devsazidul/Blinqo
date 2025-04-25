import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:flutter/material.dart';

class EpVanueDetailsCustomTextWidget extends StatelessWidget {
  final String text;
  final double fontSize;
  final Color color;
  final Alignment alignment;
  final FontWeight fontWeight;

  const EpVanueDetailsCustomTextWidget({
    super.key,
    required this.text,
    required this.fontSize,
    required this.color,
    required this.alignment,
    required this.fontWeight,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignment,
      child: Text(
        text,
        style: getTextStyle(
          fontSize: fontSize,
          fontWeight: fontWeight,
          color: color,
        ),
      ),
    );
  }
}
