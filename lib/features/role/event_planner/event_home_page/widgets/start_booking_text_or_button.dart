import 'package:flutter/material.dart';

import 'start_booking_decoration_card.dart';

class StartBookingTextOrButton extends StatelessWidget {
  const StartBookingTextOrButton({
    super.key,
    required this.screenHeight,
    required this.screenWidth,
  });

  final double screenHeight;
  final double screenWidth;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        StartBookingDecorationCard(
          text: "Short by",
          text2: "Table Shape",
          screenHeight: screenHeight,
          screenWidth: screenWidth,
          onTap: () {
            print("Short by Table Shape");
          },
        ),
        SizedBox(height: screenHeight * 0.02),
        StartBookingDecorationCard(
          text: "Short by",
          text2: "Seating Style",
          screenHeight: screenHeight,
          screenWidth: screenWidth,
          onTap: () {},
        ),
        SizedBox(height: screenHeight * 0.02),
        StartBookingDecorationCard(
          text: "Short by",
          text2: "Lighting Style",
          screenHeight: screenHeight,
          screenWidth: screenWidth,
          onTap: () {},
        ),
        SizedBox(height: screenHeight * 0.02),
        StartBookingDecorationCard(
          text: "Short by",
          text2: "Flower Color",
          screenHeight: screenHeight,
          screenWidth: screenWidth,
          onTap: () {},
        ),
        SizedBox(height: screenHeight * 0.02),
        StartBookingDecorationCard(
          text: "Short by",
          text2: "Flower Type",
          screenHeight: screenHeight,
          screenWidth: screenWidth,
          onTap: () {},
        ),
        SizedBox(height: screenHeight * 0.02),
        StartBookingDecorationCard(
          text: "Short by",
          text2: "Fragrance",
          screenHeight: screenHeight,
          screenWidth: screenWidth,
          onTap: () {},
        ),
        SizedBox(height: screenHeight * 0.02),
      ],
    );
  }
}
