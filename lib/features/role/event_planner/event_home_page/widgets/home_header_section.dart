import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:blinqo/core/utils/constants/image_path.dart';
import 'package:blinqo/features/profile/controller/pick_color_controller.dart';
import 'package:blinqo/features/profile/controller/profile_controller.dart';
import 'package:blinqo/features/role/event_planner/event_home_page/screens/ep_paymant_screen/ep_payment_option.dart';
import 'package:blinqo/features/role/event_planner/notification/screens/notification_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class HomeHeaderSection extends StatelessWidget implements PreferredSizeWidget {
  final ThemeMode themeMode;
  final bool isFemale;
  final PickColorController femaleColorController;
  HomeHeaderSection({
    super.key,
    required this.themeMode,
    required this.isFemale,
    required this.femaleColorController,
  });

  ProfileController profileController = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: SafeArea(
        child: Row(
          children: [
            CircleAvatar(
              radius: 24,
              backgroundImage:
                  profileController
                              .userInfo
                              .value
                              ?.data
                              ?.profile
                              ?.image
                              ?.path
                              ?.isNotEmpty ==
                          true
                      ? NetworkImage(
                        profileController
                            .userInfo
                            .value!
                            .data!
                            .profile!
                            .image!
                            .path!,
                      )
                      : AssetImage(ImagePath.profile) as ImageProvider,
            ),

            SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    profileController.userInfo.value?.data?.name?.isNotEmpty ==
                            true
                        ? profileController.userInfo.value!.data!.name!
                        : 'Dianne Russell',
                    style: getTextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color:
                          themeMode == ThemeMode.dark
                              ? Color(0xffEBEBEB)
                              : AppColors.textColor,
                    ),
                  ),
                  SizedBox(height: 6),
                  Row(
                    children: [
                      Icon(
                        Icons.location_on_outlined,
                        size: 16,
                        color: Color(0xFFA1A1A1),
                      ),
                      // SizedBox(width: 2),
                      Expanded(
                        child: Wrap(
                          children: [
                            Text(
                              profileController
                                          .userInfo
                                          .value
                                          ?.data
                                          ?.profile
                                          ?.location
                                          ?.isNotEmpty ==
                                      true
                                  ? profileController
                                      .userInfo
                                      .value!
                                      .data!
                                      .profile!
                                      .location!
                                  : '45th Street, Los Angeles, USA',
                              // overflow: TextOverflow.,
                              style: getTextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 10,
                                color: Color(0xFFA1A1A1),
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
            SizedBox(width: 8),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.buttonColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
                padding: EdgeInsets.all(10),
              ),
              onPressed: () {},
              child: GestureDetector(
                onTap: () {
                  Get.to(EpPaymentOption());
                },
                child: Text(
                  'Go Pro',
                  style: getTextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            SizedBox(width: 8),
            GestureDetector(
              onTap: () {
                Get.to(() => NotificationScreen());
              },
              child: Icon(
                Icons.notifications,
                size: 24,
                color:
                    themeMode == ThemeMode.dark
                        ? AppColors.buttonColor
                        : isFemale
                        ? femaleColorController.selectedColor
                        : AppColors.iconColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(50);
}
