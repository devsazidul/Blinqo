import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:blinqo/core/utils/constants/icon_path.dart';
import 'package:blinqo/core/utils/constants/image_path.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ShearchStartBookingPage extends StatelessWidget {
  const ShearchStartBookingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            SizedBox(
              height: Get.height * 0.35,
              width: double.infinity,

              child: Image.asset(ImagePath.rectangle, fit: BoxFit.cover),
            ),
            Positioned(
              left: 10,
              top: 35,
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      CircleAvatar(
                        radius: 15,
                        backgroundColor: Color(0x33FFFFFF),
                        child: Image.asset(
                          IconPath.arrowLeftAlt,
                          width: 16,
                          height: 12,
                          color: AppColors.primary,
                        ),
                      ),
                      SizedBox(width: 80),
                      Text(
                        "Start Booking",
                        style: getTextStyle(
                          color: AppColors.primary,
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
