import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// TextStyle getTextStyle({
// //   double fontSize = 14.0,
// //   FontWeight fontWeight = FontWeight.w400,
// //   double lineHeight = 21.0,
// //   TextAlign textAlign = TextAlign.center,
// //   Color color = Colors.black,
// // }) {
// //   return GoogleFonts.roboto(
// //     fontSize: fontSize.sp,
// //     fontWeight: fontWeight,
// //     height: fontSize.sp / lineHeight.sp,
// //     color: color,
// //   );
//
//
// }

TextStyle getTextStyle({
  double fontSize = 15.0,
  FontWeight fontWeight = FontWeight.normal,
  double lineHeight = 1.5,
  TextAlign textAlign = TextAlign.center,
  Color color = Colors.black,
}) {
  return GoogleFonts.roboto(
    fontSize: fontSize,
    fontWeight: fontWeight,
    height: lineHeight,
    color: color,
  );
}
