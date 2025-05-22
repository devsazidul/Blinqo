import 'package:blinqo/core/utils/constants/icon_path.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EpSpProfileCoverImageAndAvatar extends StatelessWidget {
  const EpSpProfileCoverImageAndAvatar({
    super.key,
    this.profileImage,
    this.coverImage,
  });

  final String? profileImage;
  final String? coverImage;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(height: 270, width: double.infinity),
        // Cover image
        CachedNetworkImage(
          imageUrl:
              coverImage ??
              "https://media.istockphoto.com/id/1409329028/vector/no-picture-available-placeholder-thumbnail-icon-illustration-design.jpg?s=612x612&w=0&k=20&c=_zOuJu755g2eEUioiOUdz_mHKJQJn-tDgIAhQzyeKUQ=",
          fit: BoxFit.cover,
          height: 220,
          width: double.infinity,
          errorWidget: (context, error, stackTrace) {
            return Image.asset(
              "assets/images/profile_cover_image.jpeg",
              height: 220,
              width: double.infinity,
              fit: BoxFit.cover,
            );
          },
        ),

        // profileImage.isEmpty
        //     ? Image.asset(
        //       "assets/images/profile_cover_image.jpeg",
        //       height: 220,
        //       width: double.infinity,
        //       fit: BoxFit.cover,
        //     )
        //     : CachedNetworkImage(
        //       height: 220,
        //       width: double.infinity,
        //       fit: BoxFit.cover,
        //       imageUrl: coverImage ?? "",
        //     ),
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
              Container(
                padding: const EdgeInsets.all(3),
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage: CachedNetworkImageProvider(
                    profileImage ?? "",
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
