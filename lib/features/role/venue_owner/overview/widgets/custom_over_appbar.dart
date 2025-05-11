import 'package:blinqo/features/role/venue_owner/payment_page/screens/v_get_verified_screen.dart';
import 'package:blinqo/features/role/venue_owner/profile_page/controller/venue_owner_profile_controller.dart';
import 'package:blinqo/features/role/venue_owner/profile_page/screen/venue_owner_profile_page.dart';
import 'package:blinqo/features/role/venue_owner/venue_notification_page/screens/v_notification_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileRow extends StatelessWidget implements PreferredSizeWidget {
  final String imagePath;
  final String name;
  final String role;

  const ProfileRow({
    super.key,
    required this.imagePath,
    required this.name,
    required this.role,
  });

  TextStyle getTextStyle({
    required double fontSize,
    required FontWeight fontWeight,
    required Color color,
  }) {
    return TextStyle(fontSize: fontSize, fontWeight: fontWeight, color: color);
  }

  @override
  Widget build(BuildContext context) {
    VenueOwnerProfileController controller = Get.put(VenueOwnerProfileController());
    final bool isDarkMode = Get.put(VenueOwnerProfileController()).isDarkMode.value;
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
        child: Row(
          children: [
            GestureDetector(
              onTap: () {
                controller.getProfileInformation();
                controller.getUserInfo();
                Get.to(VenueOwnerProfilePage());
              },
              child: Row(
                children: [
                  ClipOval(
                    child: CachedNetworkImage(
                     imageUrl:  imagePath,
                      width: 40,
                      height: 40,
                      fit: BoxFit.cover,
                      errorWidget:  (_, __, ___) => CircleAvatar(
                        backgroundColor: Color(0xffD9D9D9),
                        child: Icon(Icons.person, size: 20, color: Color(0xffA1A1A1)),
                      ),
                    ),
                  ),
                  SizedBox(width: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: getTextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color:isDarkMode ? Color(0xffEBEBEB) : Color(0xff333333),
                        ),
                      ),
                      Text(
                        role,
                        style: getTextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color:isDarkMode ? Color(0xffA1A1A1) : Color(0xffA1A1A1),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Spacer(),
            GestureDetector(
              onTap: () {
                Get.to(VGetVerifiedScreen());
              },
              child: Container(
                height: 42,
                width: 82,
                decoration: BoxDecoration(
                  color: Color(0xffD4AF37),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Center(
                  child: Text(
                    "Go Pro",
                    style: getTextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(width: 10),
            InkWell(onTap: () {
              Get.to(VNotificationScreen());
            }, child: Icon(Icons.notifications, size: 30,color: isDarkMode ? Color(0xffD4AF37) : null)),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(60);
}
