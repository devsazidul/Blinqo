import 'package:flutter/material.dart';
import 'package:blinqo/core/common/styles/global_text_style.dart';

class FacilityTag extends StatelessWidget {
  final double width;
  final IconData icon;
  final String label;

  const FacilityTag({
    super.key,
    required this.width,
    required this.icon,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      decoration: BoxDecoration(
        color: const Color(0xffFBF7EB),
        borderRadius: BorderRadius.circular(34),
       boxShadow: [
         BoxShadow(
           color: Color(0xff000000).withValues(alpha: .3),
           blurRadius: 8,
           offset: Offset(0, 3)
         )
       ]
      ),
      child: Row(
        children: [
          const SizedBox(width: 6),
          Icon(icon, size: 14, color: const Color(0xffD4AF37)),
          const SizedBox(width: 8),
          Text(
            label,
            style: getTextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: const Color(0xff333333),
            ),
          ),
        ],
      ),
    );
  }
}
