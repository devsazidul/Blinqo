import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:blinqo/core/utils/constants/icon_path.dart';
import 'package:blinqo/features/role/event_planner/event_home_page/screens/ep_view_details_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EpCustomServiceProdiverCard extends StatelessWidget {
  const EpCustomServiceProdiverCard({super.key, required this.provider});

  final Map<String, dynamic> provider; // Change Object to dynamic

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.primary,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      elevation: 1,
      child: Padding(
        padding: EdgeInsets.all(8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                CircleAvatar(
                  radius: 18,
                  backgroundColor: AppColors.primary,
                  child: Image.asset(provider['image'] as String),
                ),
              ],
            ),
            SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        provider['name'] as String,
                        style: getTextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: AppColors.textColor,
                        ),
                      ),
                      SizedBox(width: 8),
                      if (provider['verified'] == true)
                        Image.asset(
                          IconPath.eventserviceverificaitonlogo,
                          width: 16,
                          height: 16,
                        ),
                    ],
                  ),
                  SizedBox(height: 6),
                  Row(
                    children: [
                      Image.asset(
                        IconPath.projectrequestlocation,
                        width: 16,
                        height: 16,
                      ),
                      SizedBox(width: 4),
                      Text(
                        provider['location'] as String,
                        style: getTextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: AppColors.locationIconColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Text(
                    provider['price'] as String,
                    style: getTextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: AppColors.buttonColor2,
                    ),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      width: 1,
                      color: AppColors.subTextColor2,
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '${provider['rating']}',
                        style: getTextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: AppColors.buttonColor2,
                        ),
                      ),
                      SizedBox(width: 6.5),
                      Image.asset(
                        IconPath.ratinglogo,
                        width: 10,
                        height: 10,
                        fit: BoxFit.cover,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 30),
                GestureDetector(
                  onTap: () {
                    Get.to(() => EpViewDetailsPage(), arguments: provider);
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'View Details',
                        style: getTextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: AppColors.buttonColor,
                        ),
                      ),
                      SizedBox(width: 6.5),
                      SizedBox(
                        width: 14,
                        height: 14,
                        child: Image.asset(
                          IconPath.arrowright,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
