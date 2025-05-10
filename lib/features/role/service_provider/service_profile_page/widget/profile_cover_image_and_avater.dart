import 'package:blinqo/core/utils/constants/icon_path.dart';
import 'package:blinqo/features/profile/widget/show_profile_popup_menu.dart';
import 'package:blinqo/features/role/service_provider/common/controller/auth_controller.dart';
import 'package:blinqo/features/role/service_provider/service_profile_page/controller/service_user_profile_controler.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class ProfileCoverImageAndAvatar extends StatelessWidget {
  const ProfileCoverImageAndAvatar({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(height: 270, width: double.infinity),

        /// Cover image
        Image.network(
          SpAuthController.profileInfoModel?.coverPhoto?.path ??
              "assets/images/profile_cover_image.jpeg",
          height: 220,
          width: double.infinity,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return Image.asset(
              "assets/images/profile_cover_image.jpeg",
              height: 220,
              width: double.infinity,
              fit: BoxFit.cover,
            );
          },
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
                  showPopupMenu(
                    context,
                    Get.find<SpProfileController>().isDarkMode.value,
                  );
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
              Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.bottomRight,
                children: [
                  CircleAvatar(
                    radius: 45,
                    child: ClipOval(
                      child: Image.network(
                        SpAuthController.profileInfoModel?.image?.path ??
                            IconPath.sphprofile,
                        fit: BoxFit.cover,
                        width: 90,
                        height: 90,
                      ),
                    ),
                    // child: Image.asset(IconPath.profile01, fit: BoxFit.cover),
                  ),
                  Positioned(
                    right: 10,
                    bottom: 0,
                    child: Image.asset(
                      IconPath.verifiedlogo,
                      width: 24,
                      height: 24,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
