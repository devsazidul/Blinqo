import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/utils/constants/image_path.dart';
import 'package:flutter/material.dart';


class BookingHeader extends StatelessWidget {
  const BookingHeader({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Stack(
      children: [
        ClipRRect(
          child: Image.asset(
            ImagePath.venuesHall,
            width: double.infinity,
            height: screenHeight * 0.35,
            fit: BoxFit.cover,
          ),
        ),
        // container with gradient
        Container(
          width: double.infinity,
          height: screenHeight * 0.35,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0x00000000),
                Color(0x00000000),
                Color(0xFF000000),
              ]
          ))
        ),
        Positioned(
          top: 60,
          left: 20,
          child: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: CircleAvatar(
              radius: 20,
              backgroundColor: Colors.white.withAlpha(40),
              child: Icon(Icons.arrow_back, size: 24, color: Colors.white),
            ),
          ),
        ),
        Positioned(
          top: 66,
          left: (screenWidth - 120) / 2,
          child: Text(
            'Booking Details',
            style: getTextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ),
        Positioned(
          bottom: 20,
          right: 20,
          child: GestureDetector(
            onTap: () {
            },
            child: Icon(Icons.threesixty, size: 32, color: Colors.white),
          ),
        ),
      ],
    );
  }
}
