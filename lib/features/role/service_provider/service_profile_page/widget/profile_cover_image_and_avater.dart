import 'package:blinqo/core/utils/constants/icon_path.dart';
import 'package:blinqo/features/profile/widget/show_profile_popup_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ProfileCoverImageAndAvater extends StatelessWidget {
  const ProfileCoverImageAndAvater({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(height: 270, width: double.infinity),

        /// Cover image
        Image.asset(
          "assets/images/profile_cover_image.jpeg",
          height: 220,
          width: double.infinity,
          fit: BoxFit.cover,
        ),

        /// Three-dot menu and back button
        Positioned(
          top: 50,
          left: 0,
          right: 0,
          child: Row(
            children: [
              GestureDetector(
                onTap: () {},
                child: Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: CircleAvatar(
                    backgroundColor: Colors.white.withAlpha(100),
                    child: SvgPicture.asset(IconPath.arrowLeftAltSvg),
                  ),
                ),
              ),
              Spacer(),
              GestureDetector(
                onTap: () {
                  showPopupMenu(context);
                },
                child: Padding(
                  padding: const EdgeInsets.only(right: 20.0),
                  child: CircleAvatar(
                    backgroundColor: Colors.white.withAlpha(100),
                    child: Icon(Icons.more_vert, color: Colors.white),
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
