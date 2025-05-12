import 'package:blinqo/core/utils/constants/icon_path.dart';
import 'package:blinqo/features/role/service_provider/common/controller/auth_controller.dart';
import 'package:blinqo/features/role/service_provider/common/widgets/sp_show_profile_popup_menu.dart';
import 'package:blinqo/features/role/service_provider/sp_profile/controller/service_user_profile_controler.dart';
import 'package:flutter/material.dart';
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
              "https://media.istockphoto.com/id/1409329028/vector/no-picture-available-placeholder-thumbnail-icon-illustration-design.jpg?s=612x612&w=0&k=20&c=_zOuJu755g2eEUioiOUdz_mHKJQJn-tDgIAhQzyeKUQ=",
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
              // Padding(
              //   padding: const EdgeInsets.only(left: 20.0),
              //   child: CircleAvatar(
              //     backgroundColor: Colors.white.withAlpha(100),
              //     child: SvgPicture.asset(IconPath.arrowLeftAltSvg),
              //   ),
              // ),
              Spacer(),
              GestureDetector(
                onTap: () {
                  spShowPopupMenu(
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
                            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSaUTp3j_LpF5r5_gNdvW0g7p057ExdcHWbUQ&s",
                        fit: BoxFit.cover,
                        width: 90,
                        height: 90,
                      ),
                    ),
                    // child: Image.asset(IconPath.profile01, fit: BoxFit.cover),
                  ),
                  if (SpAuthController.profileInfoModel?.isPro == true)
                    Positioned(
                      right: 11,
                      bottom: 1,
                      child: Container(
                        width: 20,
                        height: 20,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  if (SpAuthController.profileInfoModel?.isPro == true)
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
