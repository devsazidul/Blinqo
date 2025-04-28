import 'package:blinqo/core/common/widgets/custom_appbar_widget.dart';
import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:blinqo/features/profile/controller/pick_color_controller.dart';
import 'package:blinqo/features/profile/controller/profile_controller.dart';
import 'package:blinqo/features/role/event_planner/bottom_nav_bar/widgets/bottom_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddCompare extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final ProfileController profileController = Get.find<ProfileController>();
    final themeMode =
        profileController.isDarkMode.value ? ThemeMode.dark : ThemeMode.light;

    return Scaffold(
      backgroundColor:
          themeMode == ThemeMode.dark
              ? AppColors.darkBackgroundColor
              : AppColors.backgroundColor,
      appBar: CustomAppBarWidget(title: 'Compare', onPressed: () => Get.back()),
      body: Stack(
        children: [
          Column(
            children: [
              // Horizontal ScrollView for the Table
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: ConstrainedBox(
                    constraints: BoxConstraints(minHeight: screenHeight),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20.0,
                        vertical: 25,
                      ),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Table(
                          border: TableBorder.all(color: Colors.grey.shade700),
                          columnWidths: const {
                            0: FixedColumnWidth(153.0),
                            1: FixedColumnWidth(153.0),
                            2: FixedColumnWidth(153.0),
                          },

                          defaultVerticalAlignment:
                              TableCellVerticalAlignment.middle,
                          children: [
                            _buildTableRow([
                              '',
                              'Grand Elegance Hall',
                              'Grand Elite Hall',
                            ], isHeader: true),

                            // generate unsplash images url list
                            _buildTableRow([
                              '',
                              'https://plus.unsplash.com/premium_photo-1664530452358-d50d2d4a98d1?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NXx8d2VkZGluZyUyMHZhbnVlJTIwaGFsbHxlbnwwfHwwfHx8MA%3D%3D',
                              'https://plus.unsplash.com/premium_photo-1664530452329-42682d3a73a7?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8d2VkZGluZyUyMHZhbnVlJTIwaGFsbHxlbnwwfHwwfHx8MA%3D%3D',
                            ], isImageShow: true),
                            _buildTableRow([
                              'Location',
                              'Downtown City Center',
                              'Suburban Riverside',
                            ], isIcon: true),
                            _buildTableRow([
                              'Capacity',
                              'Up to 300 Guests',
                              'Up to 200 Guests',
                            ]),
                            _buildTableRow([
                              'Pricing & Packages',
                              '\$5,000 for 8 hours',
                              '\$3,500 for 6 hours',
                            ]),
                            _buildTableRow([
                              'Catering Options',
                              'In-house catering with customizable menus',
                              'External catering allowed',
                            ]),
                            _buildTableRow([
                              'Parking Space',
                              '100 car slots',
                              '50 car slots',
                            ]),
                            _buildTableRow(['Review', '4.5/5', '4.7/5']),
                            _buildTableRow([
                              'Availability',
                              'Open on weekends',
                              'Flexible weekdays and weekends',
                            ]),
                            _buildTableRow([
                              'Extra Services',
                              'Event planning support and preferred vendor list',
                              'On-site coordination and floral decor options',
                            ]),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              SizedBox(height: 50),
            ],
          ),

          Positioned(bottom: 0, left: 0, right: 0, child: EpBottomNavBar()),
        ],
      ),
    );
  }

  TableRow _buildTableRow(
    List<String> cells, {
    bool isHeader = false,
    bool isIcon = false,
    bool isImageShow = false,
  }) {
    bool isDarkMode = Get.find<ProfileController>().isDarkMode.value;
    final femaleColorController = Get.put(PickColorController());
    final bool isFemale = femaleColorController.isFemale.value;
    return TableRow(
      children:
          cells.map((cell) {
            return isImageShow
                ? cell == ""
                    ? SizedBox()
                    : Image.network(cell)
                : Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (isIcon && cells.indexOf(cell) == 1 ||
                            isIcon && cells.indexOf(cell) == 2)
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 2.0,
                              right: 4.0,
                            ),
                            child: Icon(
                              Icons.location_on_outlined,
                              color: Color(0xFF8A8A8A),
                              size: 16,
                            ),
                          ),
                        Expanded(
                          child: Text(
                            cell,
                            style: TextStyle(
                              color:
                                  isDarkMode
                                      ? Colors.white
                                      : (isHeader && isFemale) ||
                                          (cells.indexOf(cell) == 0 && isFemale)
                                      ? femaleColorController.selectedColor
                                      : Colors.black,

                              // isDarkMode
                              //     ? Color(0xFF003336)
                              //     : AppColors.backgroundColor,
                              fontWeight:
                                  isHeader
                                      ? FontWeight.w600
                                      : cells.indexOf(cell) == 0
                                      ? FontWeight.w600
                                      : FontWeight.normal,
                              fontSize: 14.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
          }).toList(),
    );
  }
}
