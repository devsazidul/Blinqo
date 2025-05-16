import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:blinqo/core/utils/constants/icon_path.dart';
import 'package:blinqo/features/profile/controller/pick_color_controller.dart';
import 'package:blinqo/features/profile/controller/profile_controller.dart';
import 'package:blinqo/features/role/event_planner/event_home_page/models/service_user_data_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EpCustomServiceProdiverCard extends StatelessWidget {
  EpCustomServiceProdiverCard({super.key, required this.userModel});

  final Datum userModel;
  final controller = Get.put(ProfileController());
  final PickColorController femaleColorController = Get.put(
    PickColorController(),
  );

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = controller.isDarkMode.value;
    final bool isFemale = femaleColorController.isFemale.value;

    return Card(
      color: isDarkMode ? AppColors.textFrieldDarkColor : AppColors.primary,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      elevation: 1,
      child: Padding(
        padding: EdgeInsets.all(8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [

                // profile image
                CircleAvatar(
                  radius: 18,
                  backgroundColor:
                      isDarkMode
                          ? AppColors.textFrieldDarkColor
                          : AppColors.primary,
                  backgroundImage: NetworkImage(userModel.image.path),
                ),
              ],
            ),
            SizedBox(width: 12),

            // user details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        userModel.name,

                        style: getTextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          color:
                              isDarkMode
                                  ? AppColors.primary
                                  : AppColors.textColor,
                        ),
                      ),
                      SizedBox(width: 8),
                      if (userModel.user.isVerified)
                        Image.asset(
                          IconPath.eventserviceverificaitonlogo,
                          width: 14,
                          height: 14,
                        ),
                    ],
                  ),
                  SizedBox(height: 6),
                  Row(
                    children: [
                      Image.asset(
                        IconPath.projectrequestlocation,
                        width: 16,
                        height: 16,
                      ),
                      SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          userModel.location,
                          overflow: TextOverflow.ellipsis,
                          style: getTextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: AppColors.locationIconColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Text(
                    userModel.basePrice.toString(),
                    style: getTextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color:
                          isDarkMode
                              ? AppColors.primary
                              : isFemale
                              ? femaleColorController.selectedColor
                              : AppColors.buttonColor2,
                    ),
                  ),
                ],
              ),
            ),

            // rating and view details
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                  decoration: BoxDecoration(
                    color: isDarkMode ? AppColors.primary : Colors.transparent,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      width: 1,
                      color: AppColors.subTextColor2,
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '3.2',
                        style: getTextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: AppColors.buttonColor2,
                        ),
                      ),
                      SizedBox(width: 6.5),
                      Image.asset(
                        IconPath.ratinglogo,
                        width: 10,
                        height: 10,
                        fit: BoxFit.cover,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 30),
                GestureDetector(
                  onTap: () {
                    // Get.to(
                    //   () => EpServiceProviderProfile(),
                    //   arguments: provider,
                    // );
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'View Details',
                        style: getTextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: AppColors.buttonColor,
                        ),
                      ),
                      SizedBox(width: 6.5),
                      SizedBox(
                        width: 14,
                        height: 14,
                        child: Image.asset(
                          IconPath.arrowright,
                          fit: BoxFit.contain,
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
    );
  }
}
