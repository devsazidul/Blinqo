
import 'package:blinqo/features/role/venue_owner/profile_page/controller/venue_owner_profile_controller.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../../../../core/common/styles/global_text_style.dart';
import 'package:get/get.dart';

class ReviewCard extends StatelessWidget {
  final String image;
  final String title;
  final String time;
  final String desc;
  final int rating; // assuming out of 5

  const ReviewCard({
    super.key,
    required this.image,
    required this.title,
    required this.time,
    required this.desc,
    this.rating = 5,
  });

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode =
        Get.put(VenueOwnerProfileController()).isDarkMode.value;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// Top Row: Avatar + Title + Stars + Time
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipOval(
              child: CachedNetworkImage(
                imageUrl: image,
                fit: BoxFit.cover,
                height: 40,
                width: 40,
                errorWidget: (context, url, error) {
                  return Icon(
                    Icons.person,
                    size: 40,
                    color: isDarkMode ? Color(0xffEBEBEB) : Color(0xff333333),
                  );
                },
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: getTextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: isDarkMode ? Color(0xffEBEBEB) : Color(0xff333333),
                    ),
                  ),
                  Row(
                    children: List.generate(
                      rating,
                      (index) => const Icon(
                        Icons.star,
                        color: Color(0xffF0C020),
                        size: 15,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Text(
              time,
              style: getTextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: const Color(0xffC0C0C0),
              ),
            ),
          ],
        ),

        const SizedBox(height: 17),

        /// Description
        Text(
          desc,
          style: getTextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: isDarkMode ? Color(0xffA1A1A1) : Color(0xff5C5C5C),
          ),
        ),
      ],
    );
  }
}
