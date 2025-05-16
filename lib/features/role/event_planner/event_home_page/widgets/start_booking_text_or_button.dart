import 'package:blinqo/features/profile/controller/pick_color_controller.dart';
import 'package:blinqo/features/role/event_planner/home/controller/booking_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'start_booking_decoration_card.dart';

// ignore: must_be_immutable
class StartBookingTextOrButton extends StatelessWidget {
  StartBookingTextOrButton({
    super.key,
    required this.screenHeight,
    required this.screenWidth,
    required this.themeMode,
    this.pickColorController,
  });

  final double screenHeight;
  final double screenWidth;
  final PickColorController? pickColorController;

  final ThemeMode themeMode;

  List<String> tableShapes = [
    'Round',
    'Square',
    'Rectangle',
    'Oval',
    'Cocktail Table'
  ];

  List<String> seatingStyles = [
    'Banquet',
    'Theater',
    'Classroom',
    'U-Shape',
    'Cocktail Style'
  ];

  List<String> lightingStyles = [
    'Chandeliers',
    'Fairy Lights',
    'Spotlights',
    'Pendant Lights',
    'String Lights'
  ];

  List<String> flowerColors = [
    'Red',
    'White',
    'Pink',
    'Yellow',
    'Blue',
    'Purple',
    'Orange'
  ];

  List<String> flowerTypes = [
    'Roses',
    'Tulips',
    'Lilies',
    'Daisies',
    'Orchids',
    'Sunflowers'
  ];

  List<String> fragrances = [
    'Lavender',
    'Rose',
    'Jasmine',
    'Sandalwood',
    'Lily of the Valley',
    'Vanilla'
  ];


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        StartBookingDecorationCard(
          dropdownItems: tableShapes,
          text2: "Table Shape",
          screenHeight: screenHeight,
          screenWidth: screenWidth,
          controller: Get.find<BookingController>().tableShapeController,
          onTap: () {
            // print("Short by Table Shape");
          },
          themeMode: themeMode,
          pickColorController: pickColorController,
        ),
        SizedBox(height: screenHeight * 0.02),
        StartBookingDecorationCard(
          dropdownItems: seatingStyles,
          text2: "Seating Style",
          screenHeight: screenHeight,
          screenWidth: screenWidth,
          controller: Get.find<BookingController>().seatingStyleController,
          onTap: () {},
          themeMode: themeMode,
          pickColorController: pickColorController,
        ),
        SizedBox(height: screenHeight * 0.02),
        StartBookingDecorationCard(
          dropdownItems: lightingStyles,
          text2: "Lighting Style",
          screenHeight: screenHeight,
          screenWidth: screenWidth,
          controller: Get.find<BookingController>().lightingController,
          onTap: () {},
          themeMode: themeMode,
          pickColorController: pickColorController,
        ),
        SizedBox(height: screenHeight * 0.02),
        StartBookingDecorationCard(
          dropdownItems: flowerColors,
          text2: "Flower Color",
          screenHeight: screenHeight,
          screenWidth: screenWidth,
          controller: Get.find<BookingController>().flowerColorController,
          onTap: () {},
          themeMode: themeMode,
          pickColorController: pickColorController,
        ),
        SizedBox(height: screenHeight * 0.02),
        StartBookingDecorationCard(
          dropdownItems: flowerTypes,
          text2: "Flower Type",
          screenHeight: screenHeight,
          screenWidth: screenWidth,
          controller: Get.find<BookingController>().flowerTypeController,
          onTap: () {},
          themeMode: themeMode,
          pickColorController: pickColorController,
        ),
        SizedBox(height: screenHeight * 0.02),
        StartBookingDecorationCard(
          dropdownItems: fragrances,
          text2: "Fragrance",
          screenHeight: screenHeight,
          screenWidth: screenWidth,
          controller: Get.find<BookingController>().fragranceController,
          onTap: () {},
          themeMode: themeMode,
          pickColorController: pickColorController,
        ),
        SizedBox(height: screenHeight * 0.02),
      ],
    );
  }
}
