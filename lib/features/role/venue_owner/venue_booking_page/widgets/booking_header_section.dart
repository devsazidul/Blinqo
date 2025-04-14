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
        Positioned(
          top: 60,
          left: 20,
          child: GestureDetector(
            onTap: () {
              // Get.back();
            },
            child: CircleAvatar(
              radius: 20,
              backgroundColor: Colors.white.withAlpha(100),
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
              // Need to be implemented
            },
            child: Icon(Icons.threesixty, size: 32, color: Colors.white),
          ),
        ),
      ],
    );
  }
}
