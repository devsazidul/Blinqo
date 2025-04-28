import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:blinqo/core/utils/constants/icon_path.dart';
import 'package:blinqo/core/utils/constants/image_path.dart';
import 'package:blinqo/features/profile/controller/profile_controller.dart';
import 'package:blinqo/features/role/event_planner/event_compare/screen/add_compare.dart';
import 'package:blinqo/features/role/event_planner/event_home_page/controllers/search_details_controller/search_details_controller.dart';
import 'package:blinqo/features/role/event_planner/event_home_page/screens/search_details_screens/widget/search_bar.dart';
import 'package:blinqo/features/role/event_planner/venue_details/screen/ep_venue_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class FilterViewScreen extends StatelessWidget {
  final ProfileController themeController = Get.put(ProfileController());
  final SearchDetailsController searchDetailsController = Get.put(
    SearchDetailsController(),
  );

  FilterViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = themeController.isDarkMode.value;
    return Scaffold(
      backgroundColor:
          isDarkMode
              ? AppColors.darkBackgroundColor
              : AppColors.backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SearchBer(),
              SizedBox(height: 20),
              Expanded(
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: ScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 16,
                    childAspectRatio: 0.7,
                  ),
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    int itemId = index;
                    return InkWell(
                      onTap: () {
                        Get.to(EpVenueDetails());
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color:
                              isDarkMode
                                  ? AppColors.cardDarkColor
                                  : AppColors.primary,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color:
                                isDarkMode
                                    ? AppColors.cardDarkColor
                                    : AppColors.borderColor2,
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 12,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                flex: 5,
                                child: Stack(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: AssetImage(ImagePath.filter),
                                          fit: BoxFit.cover,
                                        ),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                    Positioned(
                                      top: 6,
                                      left: 6,
                                      child: Container(
                                        height: 18,
                                        width: 45,
                                        decoration: BoxDecoration(
                                          color:
                                              isDarkMode
                                                  ? AppColors.cardsubtextColor
                                                  : AppColors.primary,
                                          borderRadius: BorderRadius.circular(
                                            8,
                                          ),
                                        ),
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 4,
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                '4.5',
                                                style: getTextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                              Icon(
                                                Icons.star,
                                                size: 16,
                                                color:
                                                    isDarkMode
                                                        ? AppColors.borderColor2
                                                        : AppColors.textColor,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      top: 6,
                                      right: 5,
                                      child: Container(
                                        height: 20,
                                        width: 20,
                                        decoration: BoxDecoration(
                                          color:
                                              isDarkMode
                                                  ? AppColors.cardsubtextColor
                                                  : AppColors.primary,
                                          borderRadius: BorderRadius.circular(
                                            10,
                                          ),
                                        ),
                                        child: Obx(
                                          () => IconButton(
                                            padding: EdgeInsets.all(0),
                                            onPressed: () {
                                              searchDetailsController
                                                  .toggleFavorite(itemId);
                                            },
                                            icon: Icon(
                                              searchDetailsController
                                                      .isFavorite(itemId)
                                                  ? Icons.favorite
                                                  : Icons
                                                      .favorite_border_rounded,
                                              size: 12,
                                              color:
                                                  searchDetailsController
                                                          .isFavorite(itemId)
                                                      ? AppColors.textColor
                                                      : AppColors.textColor,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 12),
                              Expanded(
                                flex: 3,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                              'The Grand Hall',
                                              style: getTextStyle(
                                                fontSize: 16.sp,
                                                fontWeight: FontWeight.w600,
                                                color:
                                                    isDarkMode
                                                        ? AppColors.borderColor2
                                                        : AppColors.textColor,
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                          SizedBox(width: 8),
                                          index == 0 || index == 1
                                              ? Image.asset(
                                                IconPath.vector2,
                                                width: 16,
                                              )
                                              : SizedBox(),
                                        ],
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.location_on_outlined,
                                          size: 17,
                                          color: AppColors.locationIconColor,
                                        ),
                                        SizedBox(width: 4),
                                        Text(
                                          'New Yourk',
                                          style: getTextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400,
                                            color: AppColors.locationIconColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 10),
                                    GestureDetector(
                                      onTap: () {
                                        Get.to(AddCompare());
                                      },
                                      child: Text(
                                        'Add to Compare',
                                        style: getTextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w700,
                                          color:
                                              isDarkMode
                                                  ? AppColors.buttonColor
                                                  : AppColors.buttonColor2,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
