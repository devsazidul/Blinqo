import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:blinqo/features/role/venue_owner/overview/controller/overview_controller.dart';
import 'package:blinqo/features/role/venue_owner/profile_page/controller/venue_owner_profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AllReviewsScreen extends StatelessWidget {
  const AllReviewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final OverviewController controller = Get.put(OverviewController());
    final bool isDarkMode = Get.put(VenueOwnerProfileController()).isDarkMode.value;

    return Scaffold(
      appBar: AppBar(
        title: Text('All Reviews'),
        backgroundColor: isDarkMode ? Color(0xff151515) : AppColors.backgroundColor,
      ),
      body: ListView.builder(
        itemCount: controller.seereview.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 20),
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
                          children: [
                            Icon(Icons.star, color: Color(0xffF0C020), size: 15),
                            Icon(Icons.star, color: Color(0xffF0C020), size: 15),
                            Icon(Icons.star, color: Color(0xffF0C020), size: 15),
                            Icon(Icons.star, color: Color(0xffF0C020), size: 15),
                            Icon(Icons.star, color: Color(0xffF0C020), size: 15),
                          ],
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
          );
        },
      ),
    );
  }
}
