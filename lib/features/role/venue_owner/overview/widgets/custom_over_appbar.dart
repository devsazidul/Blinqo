import 'package:flutter/material.dart';

class ProfileRow extends StatelessWidget {
  final String imagePath;
  final String name;
  final String role;

  ProfileRow({
    required this.imagePath,
    required this.name,
    required this.role,
  });

  TextStyle getTextStyle({
    required double fontSize,
    required FontWeight fontWeight,
    required Color color,
  }) {
    return TextStyle(fontSize: fontSize, fontWeight: fontWeight, color: color);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ClipOval(
          child: Image.asset(
            imagePath,
            width: 40,
            height: 40,
            fit: BoxFit.cover,
          ),
        ),
        SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name,
              style: getTextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Color(0xff333333),
              ),
            ),
            SizedBox(height: 8),
            Text(
              role,
              style: getTextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: Color(0xffA1A1A1),
              ),
            ),
          ],
        ),
        Spacer(),
        Container(
          height: 42,
          width: 82,
          decoration: BoxDecoration(
            color: Color(0xffD4AF37),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Center(
            child: Text(
              "Go Pro",
              style: getTextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
          ),
        ),
        SizedBox(width: 10),
        InkWell(
          onTap: () {},
          child: Icon(Icons.notifications, size: 30),
        ),
      ],
    );
  }
}
