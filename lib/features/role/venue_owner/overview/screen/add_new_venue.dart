import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:blinqo/core/utils/constants/icon_path.dart';
import 'package:blinqo/core/utils/constants/image_path.dart';
import 'package:blinqo/features/role/venue_owner/myvenue/controller/myview_controller.dart';
import 'package:blinqo/features/role/venue_owner/myvenue/widget/custom_shape.dart';
import 'package:blinqo/features/role/venue_owner/myvenue/widget/custom_textfield.dart';
import 'package:blinqo/features/role/venue_owner/myvenue/widget/facilty_Tag.dart';
import 'package:blinqo/features/role/venue_owner/profile_page/controller/venue_owner_profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class AddNewVenue extends StatelessWidget {
  final String image;

  const AddNewVenue({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode =
        Get
            .put(VenueOwnerProfileController())
            .isDarkMode
            .value;
    final controller = Get.put(MyVenueController());
    TextEditingController venueName = TextEditingController();
    TextEditingController location = TextEditingController();
    TextEditingController numberGuests = TextEditingController();
    final Size screenSize = MediaQuery
        .of(context)
        .size;
    final double screenHeight = screenSize.height;
    final double screenWidth = screenSize.width;
    return Scaffold(
      backgroundColor:
      isDarkMode ? Color(0xff151515) : AppColors.backgroundColor,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Opacity(
                  opacity: 0.8,
                  child: Image.asset(
                    image,
                    width: double.infinity,
                    height: screenHeight * 0.4,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [
                          Color(0xff161616),
                          Color(0xff000000).withValues(alpha: .1),
                        ],
                      ),
                    ),
                    child: Stack(
                      children: [
                        Positioned(
                          left: 24,
                          top: 40,
                          child: GestureDetector(
                            onTap: () {
                              Get.back();
                            },
                            child: CircleAvatar(
                              radius: 20,
                              backgroundColor:
                              isDarkMode
                                  ? Color(0xFFD9D9D9).withAlpha(40)
                                  : Color(0x1A333333),
                              child: Image.asset(
                                IconPath.arrowLeftAlt,
                                width: 16,
                                height: 12,
                                color: isDarkMode ? Colors.white : Colors.white,
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          left: 120,
                          top: 48,
                          child: Text(
                            "Add New Venue",
                            style: getTextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: Color(0xffFFFFFF),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 26,
                          right: 26,
                          child: CircleAvatar(
                            backgroundColor: Color(0xffD4AF37),
                            radius: 15,
                            child: Icon(
                              Icons.mode_edit_outline_outlined,
                              size: 16,
                              color: Color(0xff003366),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomInputField(controller: venueName, label: "Venue Name"),
                  SizedBox(height: 16),
                  CustomInputField(controller: location, label: "Location"),
                  SizedBox(height: 16),
                  Text(
                    'Select From Map',
                    style: getTextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: isDarkMode ? Color(0xffEBEBEB) : Color(0xff333333),
                    ),
                  ),
                  SizedBox(height: 12),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(width: 1, color: Color(0xffABB7C2)),
                    ),
                    child: Image.asset(
                      ImagePath.location,
                      fit: BoxFit.cover,
                      opacity: const AlwaysStoppedAnimation(
                        0.5,
                      ), // 0.0 to 1.0, এখানে 50% opacity
                    ),
                  ),

                  SizedBox(height: 16),
                  CustomInputField(
                    controller: numberGuests,
                    label: "Number of Guests",
                  ),
                  SizedBox(height: 15),
                  Text(
                    'Amenities',
                    style: getTextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 20,
                      color: isDarkMode ? Color(0xffEBEBEB) : Color(0xff333333),
                    ),
                  ),
                  SizedBox(height: 12),
                 
                      FittedBox(
                        child: Row(
                          children: [
                            FacilityTag(
                              icon: Icons.wifi,
                              label: 'Wifi',
                            ),
                            SizedBox(width: 13),
                            FacilityTag(
                              icon: Icons.wifi,
                              label: 'Parking',
                            ),
                            SizedBox(width: 13),
                            FacilityTag(
                              icon: Icons.wifi,
                              label: 'AC',
                            ),
                            SizedBox(width: 13),
                            FacilityTag(
                              icon: Icons.wifi,
                              label: 'Pool',
                            ),
                          ],
                        ),
                      ),
                  
                  SizedBox(height: 16),
                  Text(
                    'Select From Here',
                    style: getTextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: isDarkMode ? Color(0xffEBEBEB) : Color(0xff333333),
                    ),
                  ),
                  SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      // CustomShapeTag(
                      //   label: 'Storage & lighting',
                      //   height: screenHeight * 0.04,
                      //   width: screenWidth * 0.38,
                      //   icon: Icon(
                      //     Icons.wifi,
                      //     size: 15,
                      //     color: Color(0xffD4AF37),
                      //   ),
                      // ),

                      SizedBox(width: .2),

                      // SizedBox(width: .2),

                      // CustomShapeTag(
                      //   icon: Icon(
                      //     Icons.wifi,
                      //     size: 15,
                      //     color: Color(0xffD4AF37),
                      //   ),
                      //   label: 'Sound System',
                      //   height: screenHeight * 0.04,
                      //   width: screenWidth * 0.38,
                      // ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      // CustomShapeTag(
                      //   label: 'Barservices',
                      //   height: screenHeight * 0.04,
                      //   width: screenWidth * 0.27,
                      //   icon: Icon(
                      //     Icons.wifi,
                      //     size: 15,
                      //     color: Color(0xffD4AF37),
                      //   ),
                      // ),
                      // CustomShapeTag(
                      //   label: '  Elevator',
                      //   height: screenHeight * 0.04,
                      //   width: screenWidth * 0.24,
                      //   icon: Icon(
                      //     Icons.wifi,
                      //     size: 15,
                      //     color: Color(0xffD4AF37),
                      //   ),
                      // ),
                      // CustomShapeTag(
                      //   label: 'Restroom',
                      //   height: screenHeight * 0.04,
                      //   width: screenWidth * 0.25,
                      //   icon: Icon(
                      //     Icons.wifi,
                      //     size: 15,
                      //     color: Color(0xffD4AF37),
                      //   ),
                      // ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      // CustomShapeTag(
                      //   label: 'Event Staff',
                      //   height: screenHeight * 0.04,
                      //   width: screenWidth * 0.30,
                      //   icon: Icon(
                      //     Icons.wifi,
                      //     size: 15,
                      //     color: Color(0xffD4AF37),
                      //   ),
                      // ),
                      // SizedBox(width: .2),
                      // CustomShapeTag(
                      //   icon: Icon(
                      //     Icons.wifi,
                      //     size: 15,
                      //     color: Color(0xffD4AF37),
                      //   ),
                      //   label: 'Sound System',
                      //   height: screenHeight * 0.04,
                      //   width: screenWidth * 0.38,
                      // ),
                    ],
                  ),
                  SizedBox(height: 19),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      width: 48,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Color(0xff003366),
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Icon(Icons.add, color: Colors.white, size: 24),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Decoration',
                    style: getTextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: isDarkMode ? Color(0xffEBEBEB) : Color(0xff333333),
                    ),
                  ),
                  SizedBox(height: 16),
                  SizedBox(
                    height: screenHeight * 0.249,
                    width: double.infinity,
                    child: Image.asset(ImagePath.venueview, fit: BoxFit.cover),
                  ),
                  SizedBox(height: 40),
                  Text(
                    'Table Shape',
                    style: getTextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: isDarkMode ? Color(0xffEBEBEB) : Color(0xff333333),
                    ),
                  ),
                  SizedBox(height: 15),
                  FittedBox(
                    fit: BoxFit.contain,
                    child: Obx(() {
                      final shapes = List<String>.from(
                        controller.tableShapeOptions,
                      );

                      if (shapes.contains("Half-Moon") &&
                          shapes.contains("Banquet")) {
                        shapes.remove("Banquet");
                        final index = shapes.indexOf("Half-Moon");
                        shapes.insert(index + 1, "Banquet");
                      }

                      final firstRowShapes = shapes.take(4).toList();
                      final secondRowShapes = shapes.skip(4).toList();

                      Widget buildRow(List<String> shapeList) {
                        return Row(
                          mainAxisSize: MainAxisSize.min,
                          children:
                          shapeList.map((shape) {
                            final isSelected = controller
                                .selectedTableShapes
                                .contains(shape); // এখানে ইউজ করো
                            return Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Transform.scale(
                                  scale: 1.2,
                                  child: Theme(
                                    data: Theme.of(context).copyWith(
                                      unselectedWidgetColor: const Color(
                                        0xffABB7C2,
                                      ), // unchecked border color
                                      checkboxTheme: CheckboxThemeData(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                          BorderRadius.circular(2),
                                        ),
                                        side: const BorderSide(
                                          width: 1, // thinner border
                                          color: Color(0xff003366),
                                        ),
                                      ),
                                    ),
                                    child: Checkbox(
                                      value: isSelected,
                                      onChanged:
                                          (_) =>
                                          controller
                                              .toggleTableShape(shape),
                                      activeColor: const Color(
                                        0xff003366,
                                      ), // or use .withOpacity(0.5) if needed
                                    ),
                                  ),
                                ),

                                Text(
                                  shape,
                                  style: getTextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color:
                                    isDarkMode
                                        ? Color(0xffEBEBEB)
                                        : Color(0xff333333),
                                  ),
                                ),
                                const SizedBox(width: 8),
                              ],
                            );
                          }).toList(),
                        );
                      }

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          buildRow(firstRowShapes),
                          const SizedBox(height: 4),
                          buildRow(secondRowShapes),
                        ],
                      );
                    }),
                  ),
                  SizedBox(height: 32),
                  Text(
                    "Seating Style",
                    style: getTextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 20,
                      color: isDarkMode ? Color(0xffEBEBEB) : Color(0xff333333),
                    ),
                  ),
                  SizedBox(height: 20),
                  FittedBox(
                    fit: BoxFit.contain,
                    child: Obx(() {
                      final styles = List<String>.from(controller.seatingStyle);

                      // "Classroom" কে index 2 তে আনা
                      if (styles.contains("Classroom")) {
                        styles.remove("Classroom");
                        styles.insert(2, "Classroom");
                      }

                      // 3 করে ভাগ করা
                      final firstRowStyles =
                      styles.take(3).toList(); // index 0,1,2
                      final secondRowStyles =
                      styles.skip(3).take(3).toList(); // index 3,4,5

                      Widget buildRow(List<String> styleList) {
                        return Row(
                          mainAxisSize: MainAxisSize.min,
                          children:
                          styleList.map((style) {
                            final isSelected = controller
                                .selectedSeatingStyles
                                .contains(style);
                            return Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Transform.scale(
                                  scale: 1,
                                  child: Theme(
                                    data: Theme.of(context).copyWith(
                                      unselectedWidgetColor: const Color(
                                        0xffABB7C2,
                                      ), // unchecked border color
                                      checkboxTheme: CheckboxThemeData(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                          BorderRadius.circular(2),
                                        ),
                                        side: const BorderSide(
                                          width:
                                          1, // এখানে width কমিয়ে দিচ্ছি
                                          color: Color(
                                            0xff003366,
                                          ), // light grey border
                                        ),
                                      ),
                                    ),
                                    child: Checkbox(
                                      value: isSelected,
                                      onChanged:
                                          (_) =>
                                          controller
                                              .toggleSeatingStyle(style),
                                      activeColor: Color(
                                        0xff003366,
                                      ).withValues(alpha: .5),
                                    ),
                                  ),
                                ),

                                Text(
                                  style,
                                  style: getTextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color:
                                    isDarkMode
                                        ? Color(0xffEBEBEB)
                                        : Color(0xff333333),
                                  ),
                                ),
                                const SizedBox(width: 8),
                              ],
                            );
                          }).toList(),
                        );
                      }

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          buildRow(firstRowStyles),
                          const SizedBox(height: 4),
                          buildRow(secondRowStyles),
                        ],
                      );
                    }),
                  ),
                  SizedBox(height: 32),
                  Text(
                    'Lighting Style',
                    style: getTextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: isDarkMode ? Color(0xffEBEBEB) : Color(0xff333333),
                    ),
                  ),
                  SizedBox(height: 20),
                  FittedBox(
                    fit: BoxFit.contain,
                    child: Obx(() {
                      final lightingStyles = List<String>.from(
                        controller.lightingStyle,
                      );
                      final firstRowStyles = lightingStyles.take(3).toList();
                      final secondRowStyles = lightingStyles.skip(3).toList();
                      Widget buildRow(List<String> styleList) {
                        return Row(
                          mainAxisSize: MainAxisSize.min,
                          children:
                          styleList.map((style) {
                            final isSelected = controller
                                .selectedLightingStyles
                                .contains(style);
                            return Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Transform.scale(
                                  scale: 1.2,
                                  child: Theme(
                                    data: Theme.of(context).copyWith(
                                      unselectedWidgetColor: const Color(
                                        0xffABB7C2,
                                      ),
                                      checkboxTheme: CheckboxThemeData(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                          BorderRadius.circular(2),
                                        ),
                                        side: const BorderSide(
                                          width: 1,
                                          color: Color(0xff003366),
                                        ),
                                      ),
                                    ),
                                    child: Checkbox(
                                      value: isSelected,
                                      onChanged:
                                          (_) =>
                                          controller
                                              .tooggleLightingStyle(style),
                                      activeColor: const Color(0xff003366),
                                    ),
                                  ),
                                ),
                                Text(
                                  style,
                                  style: getTextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color:
                                    isDarkMode
                                        ? Color(0xffEBEBEB)
                                        : Color(0xff333333),
                                  ),
                                ),
                                const SizedBox(width: 8),
                              ],
                            );
                          }).toList(),
                        );
                      }

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          buildRow(firstRowStyles),
                          const SizedBox(height: 4),
                          buildRow(secondRowStyles),
                        ],
                      );
                    }),
                  ),
                  SizedBox(height: 32),
                  Text(
                    'Flower Color',
                    style: getTextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: isDarkMode ? Color(0xffEBEBEB) : Color(0xff333333),
                    ),
                  ),
                  SizedBox(height: 20),
                  FittedBox(
                    fit: BoxFit.contain,
                    child: Obx(() {
                      final flowerColors = List<String>.from(
                        controller.flowerColor,
                      );
                      final firstRowColors =
                      flowerColors.take(4).toList(); // Ends with "Pink"
                      final secondRowColors =
                      flowerColors.skip(4).toList(); // Starts with "Purple"

                      Widget buildRow(List<String> colorList) {
                        return Row(
                          mainAxisSize: MainAxisSize.min,
                          children:
                          colorList.map((color) {
                            final isSelected = controller
                                .selectedFlowerColor
                                .contains(color);
                            return Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Transform.scale(
                                  scale: 1.2,
                                  child: Theme(
                                    data: Theme.of(context).copyWith(
                                      unselectedWidgetColor: const Color(
                                        0xffABB7C2,
                                      ),
                                      checkboxTheme: CheckboxThemeData(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                          BorderRadius.circular(2),
                                        ),
                                        side: const BorderSide(
                                          width: 1,
                                          color: Color(0xff003366),
                                        ),
                                      ),
                                    ),
                                    child: Checkbox(
                                      value: isSelected,
                                      onChanged:
                                          (_) =>
                                          controller
                                              .toogleFlowerColor(color),
                                      activeColor: const Color(0xff003366),
                                    ),
                                  ),
                                ),
                                Text(
                                  color,
                                  style: getTextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color:
                                    isDarkMode
                                        ? Color(0xffEBEBEB)
                                        : Color(0xff333333),
                                  ),
                                ),
                                const SizedBox(width: 8),
                              ],
                            );
                          }).toList(),
                        );
                      }

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          buildRow(firstRowColors),
                          const SizedBox(height: 4),
                          buildRow(secondRowColors),
                        ],
                      );
                    }),
                  ),
                  SizedBox(height: 32),
                  Text(
                    'Flower Type',
                    style: getTextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: isDarkMode ? Color(0xffEBEBEB) : Color(0xff333333),
                    ),
                  ),
                  FittedBox(
                    fit: BoxFit.contain,
                    child: Obx(() {
                      final types = List<String>.from(controller.flowerType);
                      if (types.contains("Orchids") &&
                          types.indexOf("Orchids") != 3) {
                        types.remove("Orchids");
                        types.insert(3, "Orchids");
                      }
                      final firstRowTypes =
                      types.take(4).toList(); // Ends with "Orchids"
                      final secondRowTypes =
                      types.skip(4).toList(); // Starts with "Tulips"
                      Widget buildRow(List<String> typeList) {
                        return Row(
                          mainAxisSize: MainAxisSize.min,
                          children:
                          typeList.map((type) {
                            final isSelected = controller.selectedFlowerType
                                .contains(type);
                            return Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Transform.scale(
                                  scale: 1.2,
                                  child: Theme(
                                    data: Theme.of(context).copyWith(
                                      unselectedWidgetColor: const Color(
                                        0xffABB7C2,
                                      ),
                                      checkboxTheme: CheckboxThemeData(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                          BorderRadius.circular(2),
                                        ),
                                        side: const BorderSide(
                                          width: 1,
                                          color: Color(0xff003366),
                                        ),
                                      ),
                                    ),
                                    child: Checkbox(
                                      value: isSelected,
                                      onChanged:
                                          (_) =>
                                          controller
                                              .toogleFlowerType(type),
                                      activeColor: const Color(0xff003366),
                                    ),
                                  ),
                                ),
                                Text(
                                  type,
                                  style: getTextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color:
                                    isDarkMode
                                        ? Color(0xffEBEBEB)
                                        : Color(0xff333333),
                                  ),
                                ),
                                const SizedBox(width: 8),
                              ],
                            );
                          }).toList(),
                        );
                      }

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          buildRow(firstRowTypes),
                          const SizedBox(height: 4),
                          buildRow(secondRowTypes),
                        ],
                      );
                    }),
                  ),
                  SizedBox(height: 32),
                  Text(
                    'Fragrance',
                    style: getTextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: isDarkMode ? Color(0xffEBEBEB) : Color(0xff333333),
                    ),
                  ),
                  FittedBox(
                    fit: BoxFit.contain,
                    child: Obx(() {
                      final scents = List<String>.from(controller.frogrance);

                      // Rearranging so "Herbal Scents" is the 3rd (last in 1st row)
                      if (scents.contains("Herba; Scents") &&
                          scents.indexOf("Herba; Scents") != 2) {
                        scents.remove("Herba; Scents");
                        scents.insert(2, "Herba; Scents");
                      }

                      final firstRowScents =
                      scents.take(3).toList(); // Ends with "Herba; Scents"
                      final secondRowScents = scents.skip(3).toList();

                      Widget buildRow(List<String> scentList) {
                        return Row(
                          mainAxisSize: MainAxisSize.min,
                          children:
                          scentList.map((scent) {
                            final isSelected = controller.selectedFragrance
                                .contains(scent);
                            return Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Transform.scale(
                                  scale: 1.2,
                                  child: Theme(
                                    data: Theme.of(context).copyWith(
                                      unselectedWidgetColor: const Color(
                                        0xffABB7C2,
                                      ),
                                      checkboxTheme: CheckboxThemeData(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                          BorderRadius.circular(2),
                                        ),
                                        side: const BorderSide(
                                          width: 1,
                                          color: Color(0xff003366),
                                        ),
                                      ),
                                    ),
                                    child: Checkbox(
                                      value: isSelected,
                                      onChanged:
                                          (_) =>
                                          controller.toogleFrance(
                                            scent,
                                          ),
                                      activeColor: const Color(0xff003366),
                                    ),
                                  ),
                                ),
                                Text(
                                  scent,
                                  style: getTextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color:
                                    isDarkMode
                                        ? Color(0xffEBEBEB)
                                        : Color(0xff333333),
                                  ),
                                ),
                                const SizedBox(width: 8),
                              ],
                            );
                          }).toList(),
                        );
                      }

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          buildRow(firstRowScents),
                          const SizedBox(height: 4),
                          buildRow(secondRowScents),
                        ],
                      );
                    }),
                  ),
                  SizedBox(height: 45),
                  Container(
                    width: double.infinity,
                    height: screenHeight * 0.07,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Color(0xff003366),
                      border: Border.all(width: 1, color: Color(0xff003366)),
                    ),
                    child: Center(
                      child: Text(
                        'Save',
                        style: getTextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Color(0xffF4F4F4),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
