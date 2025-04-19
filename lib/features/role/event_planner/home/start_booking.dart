import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:flutter/material.dart';

import 'wigate/start_booking_shearh_bar.dart';

class StartBooking extends StatelessWidget {
  const StartBooking({super.key});

  @override
  Widget build(BuildContext context) {
    // Get screen width and height for responsive design
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Color(0xffF4F4F4),
      appBar: AppBar(
        forceMaterialTransparency: true,
        centerTitle: true,
        title: Text(
          'Start Booking',
          style: TextStyle(
            fontSize:
                screenWidth * 0.05, // Adjust font size based on screen width
            fontWeight: FontWeight.w600,
            color: AppColors.buttonColor2, // Ensure AppColors is defined
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: screenWidth * 0.05,
        ), // Horizontal padding based on screen width
        child: Column(
          children: [
            StartBookingShearshBar(
              screenHeight: screenHeight,
              screenWidth: screenWidth,
            ),
          ],
        ),
      ),
    );
  }
}
