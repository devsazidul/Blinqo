import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:blinqo/features/role/venue_owner/overview/controller/overview_controller.dart';
import 'package:blinqo/features/role/venue_owner/profile_page/controller/venue_owner_profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Bookviewerreview extends StatelessWidget {
  Bookviewerreview({super.key});

  final OverviewController controller = Get.find<OverviewController>();
  final bool isDarkMode = Get.put(VenueOwnerProfileController()).isDarkMode.value;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: isDarkMode ? Color(0xff151515) : AppColors.backgroundColor,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10),
                Row(
                  children: [
                    InkWell(
                      onTap: () {
                        Get.back(); // অথবা Navigator.pop(context);
                      },
                      child: Icon(
                        Icons.arrow_back,
                        color: isDarkMode ? Colors.white : Colors.black,
                      ),
                    ),
                    SizedBox(width: 10),
                    Text(
                      'All Reviews',
                      style: getTextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: isDarkMode ? Colors.white : Colors.black,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                ...List.generate(
                  controller.seereview.length,
                  (index) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            ClipOval(
                              child: Image.asset(
                                controller.seereview[index]["image"]!,
                                fit: BoxFit.cover,
                                height: 40,
                                width: 40,
                              ),
                            ),
                            SizedBox(width: 8),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  controller.seereview[index]["title"]!,
                                  style: getTextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: isDarkMode ? Color(0xffEBEBEB) : Color(0xff333333),
                                  ),
                                ),
                                Row(
                                  children: List.generate(
                                    5,
                                    (_) => Icon(
                                      Icons.star,
                                      color: Color(0xffF0C020),
                                      size: 15,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Spacer(),
                            Text(
                              controller.seereview[index]["time"]!,
                              style: getTextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: Color(0xffC0C0C0),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 15),
                        Text(
                          controller.seereview[index]["desc"]!,
                          style: getTextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: isDarkMode ? Color(0xffA1A1A1) : Color(0xff5C5C5C),
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
    );
  }
}
