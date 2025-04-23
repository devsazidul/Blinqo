import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:blinqo/features/role/venue_owner/profile_page/controller/venue_owner_profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VNotificationCard extends StatelessWidget {
  final bool isRead;
  final String title;
  final String time;
  final String image;

  const VNotificationCard({
    super.key,
    required this.isRead,
    required this.title,
    required this.time,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode =
        Get.put(VenueOwnerProfileController()).isDarkMode.value;
    return Container(
      decoration: BoxDecoration(
        color:
            isRead && isDarkMode
                ? Color(0xff32383D)
                : isRead
                ? AppColors.backgroundColor
                : Color(0xffDEEAFF),
      ),
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Row(
          children: [
            ClipOval(
              child: Image.network(
                image,
                height: 44,
                width: 44,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16,color: isRead && isDarkMode ? Color(0xffEBEBEB) : Color(0xff333333)),
                  ),
                  SizedBox(height: 4),
                  Text(
                    time,
                    style: TextStyle(
                      color: Color(0xff8D8D8D),
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
