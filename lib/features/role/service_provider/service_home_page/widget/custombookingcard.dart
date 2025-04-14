import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:flutter/material.dart';

class CustomBookingCard extends StatelessWidget {
  final String title;
  final String description;
  final String day;
  final String date;

  // Constructor to accept data dynamically
  const CustomBookingCard({
    required this.title,
    required this.description,
    required this.day,
    required this.date,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20),
      decoration: BoxDecoration(
        color: Color(0xffE6EBF0),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      title,
                      style: getTextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppColors.iconColor,
                      ),
                    ),
                  ),
                  Text(
                    description,
                    style: getTextStyle(
                      fontSize: 10,
                      color: AppColors.textColor,
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  Text(
                    day,
                    style: getTextStyle(
                      fontSize: 14,
                      color: AppColors.textColor,
                    ),
                  ),
                  Text(
                    date,
                    style: getTextStyle(
                      fontSize: 14,
                      color: AppColors.buttonColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Today's Task",
                style: getTextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w400,
                  color: AppColors.textColor,
                ),
              ),
              Row(
                children: [
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10.0,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(
                          color: AppColors.buttonColor2,
                          width: 1,
                        ),
                      ),
                      child: Text(
                        "Reminder Later",
                        style: getTextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w400,
                          color: AppColors.buttonColor2,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 8.0),
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10.0,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.buttonColor2,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        "Done",
                        style: getTextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w400,
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
