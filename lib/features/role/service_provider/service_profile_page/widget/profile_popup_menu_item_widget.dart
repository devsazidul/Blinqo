

// import 'package:blinqo/core/common/styles/global_text_style.dart';
// import 'package:blinqo/core/utils/constants/colors.dart';
// import 'package:flutter/material.dart';

// class ProfilePopupMenuItemWidget extends StatelessWidget {
//   const ProfilePopupMenuItemWidget({
//     super.key,
//     required this.title,
//     required this.value,
//     required this.iconPath,
//     this.addDivider = true,
//   });

//   final String title;
//   final String value;
//   final String iconPath;
//   final bool addDivider;

//   @override
//   Widget build(BuildContext context) {
//     return PopupMenuItem<String>(
//       value: value,
//       // Set padding to zero since we're handling it in the Container
//       padding: EdgeInsets.zero,
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           // Wrap in InkWell to show ripple effect
//           InkWell(
//             onTap: () {
//               // Close the menu
//               Navigator.pop(context, value);
//             },
//             // Make the InkWell take the full width
//             child: Container(
//               width: double.infinity,
//               padding: const EdgeInsets.symmetric(vertical: 8.0),
//               child: Row(
//                 children: [
//                   SizedBox(width: 10),

//                   // Icon prefix
//                   Padding(
//                     padding: const EdgeInsets.only(right: 12.0),
//                     child: Image.asset(
//                       iconPath,
//                       width: 15,
//                       color: AppColors.textColor,
//                     ),
//                     // child: Icon(icon, size: 20, color: Colors.black87),
//                   ),

//                   // Menu item text
//                   Text(
//                     title,
//                     style: getTextStyle(
//                       color: Color(0xFF003285),
//                       fontSize: 14,
//                       fontWeight: FontWeight.w400,
//                       lineHeight: 1.6,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           // Add divider if needed
//           if (addDivider)
//             const Divider(
//               height: 1,
//               thickness: 1,
//               color: Color(0xFFEEEEEE), // Light gray color
//               endIndent: 0,
//               indent: 0,
//             ),
//         ],
//       ),
//     );
//   }
// }

// import 'package:blinqo/core/common/styles/global_text_style.dart';
// import 'package:blinqo/core/utils/constants/colors.dart';
// import 'package:flutter/material.dart';

// class ProfilePopupMenuItemWidget extends StatelessWidget {
//   const ProfilePopupMenuItemWidget({
//     super.key,
//     required this.iconPath,
//     required this.title,
//     this.hasDivider = true,
//   });

//   final String iconPath;
//   final String title;
//   final bool hasDivider;

//   @override
//   Widget build(BuildContext context) {
//     return ConstrainedBox(
//       constraints: BoxConstraints(
//         minWidth: MediaQuery.of(context).size.width * 0.4,
//       ),
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Row(
//             children: [
//               SizedBox(width: 10),
//               Image.asset(iconPath, width: 15, color: AppColors.textColor),
//               SizedBox(width: 10),
//               Text(
//                 title,
//                 style: getTextStyle(
//                   color: Color(0xFF003285),
//                   fontSize: 14,
//                   fontWeight: FontWeight.w400,
//                   lineHeight: 1.6,
//                 ),
//               ),
//             ],
//           ),
//           Divider(
//             // height: 1,
//             color: hasDivider ? Color(0xFFEEEEEE) : Colors.transparent,
//             // thickness: 1,
//           ),
//         ],
//       ),
//     );
//   }
// }
