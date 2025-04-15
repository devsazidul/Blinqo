import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/utils/constants/image_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../core/utils/constants/colors.dart';
import '../../../../../core/utils/constants/icon_path.dart';
import '../../service_home_page/widget/booking_list_card.dart';
import '../../service_profile_page/controller/service_user_profile_controler.dart';

class SpEarningPage extends StatelessWidget {
  const SpEarningPage({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    final controller = Get.put(SpProfileController());
    return Obx(() {
      // Get the current theme mode (light or dark)
      final themeMode =
          controller.isDarkMode.value ? ThemeMode.dark : ThemeMode.light;

      return Scaffold(
        backgroundColor:
            themeMode == ThemeMode.dark
                ? Colors.black
                : AppColors.backgroundColor,
        appBar: AppBar(
          // backgroundColor:
          //     themeMode == ThemeMode.dark
          //         ? Colors.black
          //         : AppColors.backgroundColor,
          forceMaterialTransparency: true,
          leading:
              themeMode == ThemeMode.dark
                  ? SizedBox()
                  : Padding(
                    padding: EdgeInsets.only(left: screenWidth * 0.05),
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
          centerTitle: true,
          title: Text(
            'Booking',
            style: getTextStyle(
              fontSize: screenWidth * 0.05,
              fontWeight: FontWeight.w600,
              color:
                  themeMode == ThemeMode.dark
                      ? AppColors.borderColor2
                      : AppColors.buttonColor2,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: screenWidth * 0.05,
            ), // 5% horizontal padding
            child: Column(
              children: [
                SizedBox(height: screenHeight * 0.03), // 3% of screen height
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(width: screenWidth * 0.05), // 5% of screen width
                    Text(
                      'Booking List',
                      style: getTextStyle(
                        fontSize: screenWidth * 0.05, // 5% of screen width
                        fontWeight: FontWeight.w600,
                        color:
                            themeMode == ThemeMode.dark
                                ? AppColors.borderColor2
                                : AppColors.buttonColor2,
                      ),
                    ),
                    Spacer(),
                    Container(
                      height: screenHeight * 0.05, // 5% of screen height
                      width: screenWidth * 0.25, // 25% of screen width
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4.r),
                        color:
                            themeMode == ThemeMode.dark
                                ? Colors.black
                                : AppColors.primary,
                        border: Border.all(
                          color: AppColors.subTextColor2,
                          width: 1.5,
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Short by',
                            style: getTextStyle(
                              fontSize:
                                  screenWidth * 0.03, // 3% of screen width
                              fontWeight: FontWeight.w400,
                              color: AppColors.subTextColor2,
                            ),
                          ),
                          SizedBox(
                            width: screenWidth * 0.02,
                          ), // 2% of screen width
                          Image.asset(
                            ImagePath.newIcon,
                            width: screenWidth * 0.04, // 4% of screen width
                            height: screenHeight * 0.02, // 2% of screen height
                            color: AppColors.subTextColor2,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: screenHeight * 0.03),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'In Progress',
                      style: getTextStyle(
                        fontSize: screenWidth * 0.04,
                        fontWeight: FontWeight.w600,
                        color: AppColors.buttonColor2,
                      ),
                    ),
                    SizedBox(
                      height: screenHeight * 0.02,
                    ), // 2% of screen height
                    ListView.builder(
                      itemCount: 2,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return BookingListCard(
                          screenHeight: screenHeight,
                          screenWidth: screenWidth,
                          bookingName: "Wedding Ceremony",
                          bookingDate: "25th December 2023",
                          bookingTime: "5:00 PM - 11:00 PM",
                          bookingLocation: "Grand Hotel, Los Angeles",
                          bookingStatus: "Pending",
                          bookingPrice: "\$1200",
                        );
                      },
                    ),
                  ],
                ),

                SizedBox(height: screenHeight * 0.05), // 5% of screen height
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      backgroundColor:
                          AppColors.buttonColor2, // Background color
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          12,
                        ), // Border radius
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Add Booking",
                          style: getTextStyle(
                            fontSize: screenWidth * 0.04, // 4% of screen width
                            color: Colors.white, // Text color set to white
                          ),
                        ),
                        SizedBox(
                          width: screenWidth * 0.02,
                        ), // 2% of screen width
                        Icon(
                          Icons.add,
                          size: screenWidth * 0.06,
                          color: Colors.white,
                        ), // Icon size adjusted based on screen width
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: screenHeight * 0.25,
                ), // Add more space at the bottom
              ],
            ),
          ),
        ),
      );
    });
  }
}
