import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:flutter/material.dart';

class BookingListCard extends StatelessWidget {
  const BookingListCard({
    super.key,
    required this.screenHeight,
    required this.screenWidth,

    this.bookingName,
    this.bookingDate,
    this.bookingTime,
    this.bookingLocation,
    this.bookingStatus,
    this.bookingPrice,
  });

  final double screenHeight;
  final double screenWidth;
  final String? bookingName;
  final String? bookingDate;
  final String? bookingTime;
  final String? bookingLocation;
  final String? bookingStatus;
  final String? bookingPrice;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: screenHeight * 0.02),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      height: screenHeight * 0.25,
      width: double.infinity,
      child: Column(
        children: [
          Expanded(
            flex: 2,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.only(
                  left: screenWidth * 0.02,
                  right: screenWidth * 0.02,
                  top: screenWidth * 0.02,
                ),
                child: Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Container(
                        padding: EdgeInsets.only(
                          left: screenWidth * 0.02,
                          top: screenWidth * 0.02,
                        ),
                        color: Colors.white,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              "Jhon’s Birthday",
                              style: getTextStyle(
                                fontSize:
                                    screenWidth * 0.04, // 4% of screen width
                                fontWeight: FontWeight.w600,
                                color: AppColors.textColor,
                              ),
                            ),
                            Row(
                              children: [
                                Text(
                                  "Venue: ",
                                  style: getTextStyle(
                                    fontSize: screenWidth * 0.04,
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xff767676),
                                  ),
                                ),
                                Text(
                                  "ABC Place, New York",
                                  style: getTextStyle(
                                    fontSize: screenWidth * 0.04,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  "Total Cost:",
                                  style: getTextStyle(
                                    fontSize: screenWidth * 0.04,
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xff767676),
                                  ),
                                ),
                                Text(
                                  " \$500",
                                  style: getTextStyle(
                                    fontSize: screenWidth * 0.04,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        color: Colors.white,
                        padding: EdgeInsets.only(top: screenWidth * 0.02),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Thursday",
                              style: getTextStyle(
                                fontSize: screenWidth * 0.04,
                                fontWeight: FontWeight.w400,
                                color: Color(0xff767676),
                              ),
                            ),
                            Text(
                              "12th Oct 2023",
                              style: getTextStyle(
                                fontSize: screenWidth * 0.04,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.only(
                left: screenWidth * 0.02,
                right: screenWidth * 0.02,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(12),
                  bottomRight: Radius.circular(12),
                ),
              ),
              padding: EdgeInsets.only(left: screenWidth * 0.02),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(
                        "Booking Status: ",
                        style: getTextStyle(
                          fontSize: screenWidth * 0.03,
                          fontWeight: FontWeight.w400,
                          color: AppColors.subTextColor,
                        ),
                      ),
                      Text(
                        "Confirmed",
                        style: getTextStyle(
                          fontSize: screenWidth * 0.03,
                          fontWeight: FontWeight.w500,
                          color: AppColors.statusColor,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        "Booking Details",
                        style: getTextStyle(
                          fontSize: screenWidth * 0.03,
                          fontWeight: FontWeight.w500,
                          color: AppColors.buttonColor2,
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: Image.asset(
                          "assets/icons/trending_flat.png",
                          width: screenWidth * 0.05,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
