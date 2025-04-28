import 'package:blinqo/core/common/styles/global_text_style.dart'
    show getTextStyle;
import 'package:blinqo/core/utils/constants/colors.dart' show AppColors;
import 'package:blinqo/core/utils/constants/icon_path.dart';
import 'package:blinqo/core/utils/constants/image_path.dart' show ImagePath;
import 'package:blinqo/features/profile/controller/profile_controller.dart';
import 'package:blinqo/features/role/event_planner/venue_details/screen/ep_venue_details.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../event_compare/screen/add_compare.dart';

class FeatureVenues extends StatelessWidget {
  final bool hasButton;
  final bool? isColorChinge;
  final int? index;

  final bool? isFavorited;

  final VoidCallback? onFavoriteToggle;
  const FeatureVenues({
    super.key,
    this.hasButton = true,
    this.isColorChinge = false,
    this.index,
    this.onFavoriteToggle,
    this.isFavorited,
  });

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double cardWidth = screenWidth * 0.7;
    double buttonFontSize = screenWidth <= 360 ? 14 : 16;

    final ProfileController spUserProfileControler =
        Get.find<ProfileController>();

    return Obx(() {
      final themeMode =
          spUserProfileControler.isDarkMode.value
              ? ThemeMode.dark
              : ThemeMode.light;
      return Container(
        width: cardWidth,
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color:
              themeMode == ThemeMode.dark
                  ? Color(0xff32383D)
                  : AppColors.primary,

          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _venueImageSection(themeMode, isFavorited),
            SizedBox(height: 12),
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Get.to(EpVenueDetails());
                  },
                  child: Text(
                    'The Grand Hall',
                    style: getTextStyle(
                      fontSize: buttonFontSize,
                      fontWeight: FontWeight.w600,
                      color:
                          themeMode == ThemeMode.dark
                              ? AppColors.borderColor2
                              : AppColors.textColor,
                    ),
                  ),
                ),
                SizedBox(width: 4.0),

                index == 0 || index == 1
                    ? Image.asset(IconPath.verifiedlogo, height: 16, width: 16)
                    : SizedBox.shrink(),
              ],
            ),
            SizedBox(height: 4),
            _venueLocationRow(),
            SizedBox(height: 4),
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
                      themeMode == ThemeMode.dark
                          ? AppColors.secondary
                          : AppColors.iconColor,
                ),
              ),
            ),
            hasButton
                ? _venueBottomRow(buttonFontSize, themeMode, isColorChinge)
                : SizedBox(),
          ],
        ),
      );
    });
  }

  Widget _venueImageSection(ThemeMode themeMode, final bool? isFavorited) {
    return Stack(
      children: [
        GestureDetector(
          onTap: () {},
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(
              ImagePath.venuesHall,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned(
          top: 8,
          left: 8,
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 4, horizontal: 4),
            decoration: BoxDecoration(
              color:
                  themeMode == ThemeMode.dark
                      ? Color(0xffB0C0D0)
                      : AppColors.primary,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Text(
                  '4.5',
                  style: getTextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Color(0xff32383D),
                  ),
                ),
                SizedBox(width: 4),
                Icon(
                  Icons.star,
                  size: 12,
                  color:
                      themeMode == ThemeMode.dark
                          ? AppColors.primary
                          : Colors.black,
                ),
              ],
            ),
          ),
        ),
        Positioned(
          top: 8,
          right: 8,
          child: GestureDetector(
            onTap: onFavoriteToggle,
            child: Container(
              decoration: BoxDecoration(
                color:
                    themeMode == ThemeMode.dark
                        ? Color(0xffB0C0D0)
                        : AppColors.primary,
                borderRadius: BorderRadius.circular(25),
              ),
              child: Padding(
                padding: EdgeInsets.all(4),
                child: Icon(Icons.favorite, size: 18),
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 8,
          right: 8,
          child: Icon(Icons.threesixty, size: 24, color: Colors.white),
        ),
      ],
    );
  }

  Widget _venueLocationRow() {
    return Row(
      children: [
        Icon(Icons.location_on_rounded, color: Color(0xff8A8A8A), size: 16),
        SizedBox(width: 4),
        Text(
          'New York',
          style: getTextStyle(color: Color(0xff8A8A8A), fontSize: 12),
        ),
      ],
    );
  }

  Widget _venueBottomRow(
    double buttonFontSize,
    ThemeMode themeMode,
    bool? isColorChinge,
  ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.grey.shade400,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Padding(
            padding: const EdgeInsets.all(4),
            child: Text(
              '300 Guests',
              style: getTextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: AppColors.primary,
              ),
            ),
          ),
        ),
        SizedBox(width: 22),
        ElevatedButton(
          onPressed: () {
            Get.to(EpVenueDetails());
          },
          style: ElevatedButton.styleFrom(
            backgroundColor:
                isColorChinge == true
                    ? themeMode == ThemeMode.dark
                        ? AppColors.buttonColor
                        : AppColors.buttonColor2
                    : AppColors.buttonColor2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            padding: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
          ),
          child: Text(
            'View Details',
            style: getTextStyle(
              fontSize: buttonFontSize,
              fontWeight: FontWeight.w500,
              color: AppColors.primary,
            ),
          ),
        ),
      ],
    );
  }
}
