// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'amenities_controller.dart';

// // Assuming getTextStyle is defined elsewhere
// TextStyle getTextStyle({
//   required double fontSize,
//   required FontWeight fontWeight,
//   Color? color,
// }) {
//   return TextStyle(fontSize: fontSize, fontWeight: fontWeight, color: color);
// }

// class VenuAmenitiesScreen extends StatelessWidget {
//   const VenuAmenitiesScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final AmenitiesController amenitiesController = Get.put(AmenitiesController());
//     final bool isDarkMode = false; // Replace with your dark mode logic if needed

//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Venue Amenities'),
//       ),
//       body: Obx(() {
//         if (amenitiesController.isLoading.value) {
//           return Center(child: CircularProgressIndicator());
//         }

//         return SingleChildScrollView(
//           padding: EdgeInsets.all(16),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               // Selected Amenities Section
//               Text(
//                 'Selected Amenities',
//                 style: getTextStyle(
//                   fontSize: 16,
//                   fontWeight: FontWeight.w600,
//                   color: isDarkMode ? Color(0xffEBEBEB) : Color(0xff333333),
//                 ),
//               ),
//               SizedBox(height: 16),
//               Obx(
//                     () => amenitiesController.selectedAmenities.isEmpty
//                     ? Text(
//                   'No amenities selected',
//                   style: getTextStyle(
//                     fontSize: 12,
//                     fontWeight: FontWeight.w400,
//                     color: isDarkMode ? Color(0xffEBEBEB) : Colors.grey,
//                   ),
//                 )
//                     : Wrap(
//                   spacing: 8,
//                   runSpacing: 8,
//                   children: amenitiesController.selectedAmenities.map((amenity) {
//                     return _buildAmenityButton(
//                       amenity.name,
//                       false,
//                       amenitiesController,
//                     );
//                   }).toList(),
//                 ),
//               ),
//               SizedBox(height: 24),
//               // Select From Here Section
//               Text(
//                 'Select From Here',
//                 style: getTextStyle(
//                   fontSize: 16,
//                   fontWeight: FontWeight.w600,
//                   color: isDarkMode ? Color(0xffEBEBEB) : Color(0xff333333),
//                 ),
//               ),
//               SizedBox(height: 16),
//               Obx(
//                     () => amenitiesController.availableAmenities.isEmpty
//                     ? Text(
//                   'No more amenities available',
//                   style: getTextStyle(
//                     fontSize: 12,
//                     fontWeight: FontWeight.w400,
//                     color: isDarkMode ? Color(0xffEBEBEB) : Colors.grey,
//                   ),
//                 )
//                     : Wrap(
//                   spacing: 8,
//                   runSpacing: 8,
//                   children: amenitiesController.availableAmenities.map((amenity) {
//                     return _buildAmenityButton(
//                       amenity.name,
//                       true,
//                       amenitiesController,
//                     );
//                   }).toList(),
//                 ),
//               ),
//               const SizedBox(height: 24),
//             ],
//           ),
//         );
//       }),
//     );
//   }

//   Widget _buildAmenityButton(
//       String amenity,
//       bool isSelected,
//       AmenitiesController controller,
//       ) {
//     return GestureDetector(
//       onTap: () {
//         if (isSelected) {
//           controller.selectAmenity(Amenity(
//             id: '', // Placeholder, adjust if ID is needed
//             name: amenity,
//             defaultSelected: false,
//           ));
//         } else {
//           controller.removeAmenity(Amenity(
//             id: '', // Placeholder, adjust if ID is needed
//             name: amenity,
//             defaultSelected: false,
//           ));
//         }
//       },
//       child: Container(
//         padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//         decoration: BoxDecoration(
//           border: Border.all(color: Colors.grey.shade300),
//           borderRadius: BorderRadius.circular(20),
//           color: isSelected ? Colors.white : Color(0xffFBF7EB),
//         ),
//         child: Row(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             const Icon(Icons.wifi, size: 16, color: Color(0xffD4AF37)),
//             const SizedBox(width: 8),
//             Text(
//               amenity,
//               style: getTextStyle(
//                 fontSize: 14,
//                 fontWeight: FontWeight.w400,
//                 color: const Color(0xFF333333),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }