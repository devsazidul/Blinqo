import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AmenitiesCard extends StatelessWidget {
  final String text;
  final String icon;
  const AmenitiesCard({super.key, required this.text, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      margin: EdgeInsets.only(right: 8),

      decoration: BoxDecoration(
        color: Color(0xffFBF7EB),
        borderRadius: BorderRadius.circular(34.r),
        boxShadow: [
          BoxShadow(
            color: Color(0xff000000).withValues(alpha: .1),
            blurRadius: 10,
            offset: Offset(0, 3),
          ),
        ],
      ),

      // height: 15,
      child: Row(
        children: [
          SizedBox(height: 15, width: 20, child: Image.asset(icon)),
          SizedBox(width: 5),
          Text(
            text,
            style: getTextStyle(fontSize: 14.sp, fontWeight: FontWeight.w400),
          ),
        ],
      ),
    );
  }
}
