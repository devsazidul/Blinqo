import 'package:blinqo/core/utils/constants/icon_path.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EpSpProfileCoverImageAndAvatar extends StatelessWidget {
  const EpSpProfileCoverImageAndAvatar({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(height: 270, width: double.infinity),

        Image.asset(
          "assets/images/profile_cover_image.jpeg",
          height: 220,
          width: double.infinity,
          fit: BoxFit.cover,
        ),

        Positioned(
          top: 50,
          left: 0,
          right: 0,
          child: Row(
            children: [
              GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: CircleAvatar(
                    backgroundColor: Colors.white.withAlpha(100),
                    child: Image.asset(
                      IconPath.arrowLeftAlt,
                      width: 16,
                      height: 12,
                    ),
                  ),
                ),
              ),
              Spacer(),
              GestureDetector(
                onTap: () {
                  // showPopupMenu(context);
                },
                child: Padding(
                  padding: const EdgeInsets.only(right: 20.0),
                  child: CircleAvatar(
                    backgroundColor: Colors.white.withAlpha(100),
                    child: Image.asset(
                      IconPath.favorite,
                      fit: BoxFit.cover,
                      width: 24,
                      height: 24,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),

        /// Avatar image
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Column(
            children: [
              CircleAvatar(
                radius: 50,
                child: Image.asset(IconPath.profile01, fit: BoxFit.cover),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
