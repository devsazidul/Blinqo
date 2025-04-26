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
    double screenWidth = MediaQuery.of(context).size.width;
    final SpProfileController spUserProfileControler =
        Get.find<SpProfileController>();
    double fontSize = screenWidth > 600 ? 15 : 13;
    double paddingValue = screenWidth > 600 ? 16.0 : 8.0;

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
          leading: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: CircleAvatar(
              backgroundColor:
                  themeMode == ThemeMode.dark
                      ? AppColors.primary.withValues(alpha: 0.1)
                      : AppColors.textColor.withValues(alpha: 0.15),
              child: IconButton(
                padding: EdgeInsets.all(0),
                icon: Icon(
                  Icons.arrow_back,
                  color:
                      themeMode == ThemeMode.dark
                          ? AppColors.primary
                          : AppColors.textColor,
                ),

                onPressed: () => Get.back(),
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
                    ),

                    _buildHeaderCell(
                      fontSize: fontSize,
                      text: "Grand Elegance Hall",
                    ),
                  ],
                ),

                TableRow(
                  children: [
                    _buildEmptyCell(),
                    _buildHeaderCell(fontSize: 16.0, isImageShow: true),

                    _buildHeaderCell(fontSize: 16.0, isImageShow: true),
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

    bool? isImageShow,
  }) {
    return Container(
      color:
          isImageShow == true
              ? AppColors.appBarIcolor
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
                    color: AppColors.buttonColor2,
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
        textAlign: TextAlign.start,
        style: getTextStyle(
          color:
              isColorChinged == true
                  ? AppColors.buttonColor2
                  : AppColors.textColor,
          fontSize: fontSize,
          fontWeight:
              isColorChinged == true ? FontWeight.w600 : FontWeight.normal,
        ),
      ),
    );
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
            color: AppColors.locationIconColor,
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
