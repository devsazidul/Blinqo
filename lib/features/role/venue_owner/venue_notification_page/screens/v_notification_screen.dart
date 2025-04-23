import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:blinqo/core/utils/constants/icon_path.dart';
import 'package:blinqo/features/role/venue_owner/profile_page/controller/venue_owner_profile_controller.dart';
import 'package:blinqo/features/role/venue_owner/venue_notification_page/data.dart';
import 'package:blinqo/features/role/venue_owner/venue_notification_page/widgets/notification_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VNotificationScreen extends StatelessWidget {
  const VNotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode =
        Get.put(VenueOwnerProfileController()).isDarkMode.value;
    return Scaffold(
      backgroundColor:
          isDarkMode ? Color(0xff151515) : AppColors.backgroundColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        forceMaterialTransparency: true,
        leading: Padding(
          padding: EdgeInsets.only(left: 20),
          child: CircleAvatar(
            radius: 20,
            backgroundColor: isDarkMode ? Color(0x1AFFFFFF) : Color(0x1A333333),
            child: IconButton(
              icon: Image.asset(
                IconPath.arrowleft,
                width: 16,
                color: isDarkMode ? Color(0xffEBEBEB) : null,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        ),
        title: Text(
          'Notifications',
          style: getTextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: isDarkMode ? Color(0xffEBEBEB) : Color(0xFF333333),
          ),
        ),
        backgroundColor: AppColors.backgroundColor,
        centerTitle: true,
      ),
      body: SafeArea(
        child: ListView.separated(
          itemCount: notificationData.length,
          itemBuilder: (context, index) {
            final data = notificationData[index];
            return VNotificationCard(
              isRead: data['isRead'],
              title: data['title'],
              time: data['time'],
              image: data['image'],
            );
          },
          separatorBuilder:
              (BuildContext context, int index) => const SizedBox(height: 8,),
        ),
      ),
    );
  }
}
