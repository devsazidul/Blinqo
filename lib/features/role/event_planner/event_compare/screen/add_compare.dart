import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../core/utils/constants/icon_path.dart';
import '../../../service_provider/service_profile_page/controller/service_user_profile_controler.dart';

class AddCompare extends StatelessWidget {
  const AddCompare({super.key});

  @override
  Widget build(BuildContext context) {
    // Use MediaQuery to get screen size
    double screenWidth = MediaQuery.of(context).size.width;
    final SpProfileController spUserProfileControler =
        Get.find<SpProfileController>();
    // Determine font size and padding based on screen size
    double fontSize =
        screenWidth > 600 ? 15 : 13; // Adjust font size for larger screens
    double paddingValue =
        screenWidth > 600 ? 16.0 : 8.0; // Adjust padding for smaller screens

    return Obx(() {
      final themeMode =
          spUserProfileControler.isDarkMode.value
              ? ThemeMode.dark
              : ThemeMode.light;

      return Scaffold(
        backgroundColor:
            themeMode == ThemeMode.dark
                ? Colors.black
                : AppColors.backgroundColor,
        appBar: AppBar(
          backgroundColor: AppColors.backgroundColor,
          forceMaterialTransparency: true,
          leading:
              themeMode == ThemeMode.dark
                  ? SizedBox()
                  : Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: CircleAvatar(
                        backgroundColor: const Color(0xFFD9D9D9),
                        child: Image.asset(
                          IconPath.arrowLeftAlt,
                          color: AppColors.textColor,
                        ),
                      ),
                    ),
                  ),
          title: Text(
            'Compare',
            style: getTextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color:
                  themeMode == ThemeMode.dark
                      ? AppColors.backgroundColor
                      : AppColors.textColor,
            ),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(paddingValue),
            child: Table(
              border: TableBorder.all(color: Colors.blueGrey, width: 1.5),
              children: [
                TableRow(
                  children: [
                    _buildEmptyCell(),
                    _buildHeaderCell(
                      fontSize: fontSize,
                      text: "Grand Elegance Hall",
                      isSelected: false,
                      themeMode: themeMode,
                    ),

                    _buildHeaderCell(
                      fontSize: fontSize,
                      text: "Grand Elegance Hall",
                      themeMode: themeMode,
                      isSelected: false, // This will display the image if true
                    ),
                  ],
                ),

                TableRow(
                  children: [
                    _buildEmptyCell(),
                    _buildHeaderCell(
                      fontSize: 16.0,

                      isSelected: false, // This will display the image if true
                      isImageShow: true,
                    ),

                    _buildHeaderCell(
                      fontSize: 16.0,
                      isImageShow: true,
                      isSelected: false, // This will display the image if true
                    ),
                  ],
                ),

                TableRow(
                  children: [
                    _buildCell(
                      'Location',
                      fontSize,
                      isColorChinged: true,
                      themeMode: themeMode,
                    ),
                    _buildCellWithIcon(
                      Icons.location_on,
                      'Downtown City Center',
                      fontSize,
                      themeMode: themeMode,
                    ),
                    _buildCellWithIcon(
                      Icons.location_on,
                      'Suburban Riverfront',
                      fontSize,
                      themeMode: themeMode,
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    _buildCell(
                      'Capacity',
                      fontSize,
                      isColorChinged: true,
                      themeMode: themeMode,
                    ),
                    _buildCell(
                      themeMode: themeMode,
                      'Upto 300 Guests',
                      fontSize,
                    ),
                    _buildCell(
                      themeMode: themeMode,
                      'Upto 200 Guests',
                      fontSize,
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    _buildCell(
                      'Pricing & Packages',
                      fontSize,
                      isColorChinged: true,
                      themeMode: themeMode,
                    ),
                    _buildCell(
                      themeMode: themeMode,
                      '\$5,000 for 8 hours',
                      fontSize,
                    ),
                    _buildCell(
                      themeMode: themeMode,
                      '\$3,500 for 6 hours',
                      fontSize,
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    _buildCell(
                      'Catering Options',
                      fontSize,
                      isColorChinged: true,
                      themeMode: themeMode,
                    ),
                    _buildCell(
                      themeMode: themeMode,
                      'In-house catering with customizable menus',
                      fontSize,
                    ),
                    _buildCell(
                      themeMode: themeMode,
                      'External catering allowed',
                      fontSize,
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    _buildCell(
                      'Parking Space',
                      fontSize,
                      isColorChinged: true,
                      themeMode: themeMode,
                    ),
                    _buildCell(themeMode: themeMode, '100 car slots', fontSize),
                    _buildCell(themeMode: themeMode, '50 car slots', fontSize),
                  ],
                ),
                TableRow(
                  children: [
                    _buildCell(
                      'Review',
                      fontSize,
                      isColorChinged: true,
                      themeMode: themeMode,
                    ),
                    _buildCell(themeMode: themeMode, '4.5/5', fontSize),
                    _buildCell(themeMode: themeMode, '4.7/5', fontSize),
                  ],
                ),
                TableRow(
                  children: [
                    _buildCell(
                      'Availability',
                      fontSize,
                      isColorChinged: true,
                      themeMode: themeMode,
                    ),
                    _buildCell(
                      themeMode: themeMode,
                      'Open on weekends',
                      fontSize,
                    ),
                    _buildCell(
                      themeMode: themeMode,
                      'Flexible weekdays and weekends',
                      fontSize,
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    _buildCell(
                      'Extra Services',
                      fontSize,
                      isColorChinged: true,
                      themeMode: themeMode,
                    ),
                    _buildCell(
                      themeMode: themeMode,
                      'Event planning support and preferred vendor list',
                      fontSize,
                    ),
                    _buildCell(
                      themeMode: themeMode,
                      'On-site event coordination and floral design options',
                      fontSize,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    });
  }

  Widget _buildHeaderCell({
    required double fontSize,
    String? text,
    bool isSelected = false,
    ThemeMode? themeMode,
    bool? isImageShow,
  }) {
    return Container(
      color:
          isSelected == true
              ? themeMode == ThemeMode.dark
                  ? Colors.black87
                  : Colors.black87
              : AppColors.backgroundColor,
      padding: EdgeInsets.all(12.0),
      child:
          isImageShow == true
              ? Padding(
                padding: const EdgeInsets.all(27.0),
                child: Image.asset(
                  IconPath.imagePath,
                  width: 5,
                  color: Colors.grey,
                ),
              )
              : Align(
                alignment: Alignment.center,
                child: Text(
                  text ?? "",
                  textAlign: TextAlign.center,

                  style: getTextStyle(
                    color:
                        themeMode == ThemeMode.dark
                            ? AppColors.secondary
                            : AppColors.buttonColor2,
                    fontWeight: FontWeight.bold,
                    fontSize: fontSize,
                  ),
                ),
              ),
    );
  }

  Widget _buildCell(
    String text,
    double fontSize, {
    bool? isColorChinged,
    ThemeMode? themeMode,
  }) {
    return Container(
      padding: EdgeInsets.all(5.0),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: _getTextColor(themeMode, isColorChinged),
          fontSize: fontSize,
          fontWeight:
              isColorChinged == true ? FontWeight.w600 : FontWeight.normal,
        ),
      ),
    );
  }

  Color _getTextColor(ThemeMode? themeMode, bool? isColorChinged) {
    if (themeMode == ThemeMode.dark && isColorChinged == true) {
      return AppColors.secondary;
    } else if (themeMode == ThemeMode.dark) {
      return AppColors.backgroundColor;
    } else {
      return Colors.black87;
    }
  }

  Widget _buildCellWithIcon(
    IconData icon,
    String text,
    double fontSize, {
    ThemeMode? themeMode,
  }) {
    return Container(
      padding: EdgeInsets.all(10.0),
      child: Row(
        mainAxisAlignment:
            MainAxisAlignment.start, // Start alignment for the row
        children: [
          Image.asset(
            IconPath.locationOnPath,
            color:
                themeMode == ThemeMode.dark
                    ? AppColors.backgroundColor
                    : Colors.blue,
            width: 10,
          ),
          SizedBox(width: 8),
          Flexible(
            child: Text(
              text,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.start,
              style: TextStyle(
                color:
                    themeMode == ThemeMode.dark
                        ? AppColors.backgroundColor
                        : Colors.black87,
                fontSize: fontSize,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Helper function to build empty cell for spacing
  Widget _buildEmptyCell() {
    return Container(
      color: Colors.blueGrey[50], // Light background for the empty cell
      child: SizedBox(
        width: 1, // Empty cell with no content
      ),
    );
  }
}
