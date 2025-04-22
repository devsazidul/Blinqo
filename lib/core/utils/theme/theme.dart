import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppTheme {
  // Light Theme
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: Colors.blue, // Primary color for light theme
    scaffoldBackgroundColor:
        Colors.white, // Background color for light theme (white)
    textTheme: TextTheme(labelMedium: getTextStyle(fontSize: 14)),
    appBarTheme: AppBarTheme(
      elevation: 0,
      backgroundColor: Colors.transparent,
      titleTextStyle: TextStyle(color: Colors.black, fontSize: 24),
    ),
    buttonTheme: ButtonThemeData(
      buttonColor: Colors.blue, // Button color for light theme
      textTheme: ButtonTextTheme.primary,
    ),

    inputDecorationTheme: InputDecorationTheme(
      fillColor: Color(0xffA1A1A1), // Input fields background for light theme
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Color(
            0xffA1A1A1,
          ), // Set your desired color for the focused border
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Color(
            0xffA1A1A1,
          ), // Set your desired color for the enabled border
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      labelStyle: TextStyle(
        fontSize: 12.sp,
        fontWeight: FontWeight.w500,
        color: Color(0xff767676),
      ),
      hintStyle: TextStyle(
        fontSize: 14.sp,
        fontWeight: FontWeight.w500,
        color: Color(0xffA1A1A1),
      ),
    ),

    // You can add other customizations for light theme here
  );

  // Dark Theme
  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: Colors.blueGrey, // Primary color for dark theme
    scaffoldBackgroundColor:
        Colors.black, // Background color for dark theme (black)
    textTheme: TextTheme(
      labelMedium: getTextStyle(fontSize: 14, color: AppColors.darkSecondary),
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.black,
      titleTextStyle: TextStyle(color: Colors.white, fontSize: 24),
    ),
    buttonTheme: ButtonThemeData(
      buttonColor: Colors.blueGrey, // Button color for dark theme
      textTheme: ButtonTextTheme.primary,
    ),
    inputDecorationTheme: InputDecorationTheme(
      fillColor: Color(0xffA1A1A1), // Input fields background for light theme
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Color(
            0xffA1A1A1,
          ), // Set your desired color for the focused border
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Color(
            0xffA1A1A1,
          ), // Set your desired color for the enabled border
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      labelStyle: TextStyle(
        fontSize: 12.sp,
        fontWeight: FontWeight.w500,
        color: Color(0xff767676),
      ),
      hintStyle: TextStyle(
        fontSize: 14.sp,
        fontWeight: FontWeight.w500,
        color: Color(0xffA1A1A1),
      ),
    ),
    // You can add other customizations for dark theme here
  );
}
