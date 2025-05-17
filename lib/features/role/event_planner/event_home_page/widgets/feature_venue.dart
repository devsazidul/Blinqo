import 'package:blinqo/core/common/styles/global_text_style.dart'
    show getTextStyle;
import 'package:blinqo/core/utils/constants/colors.dart' show AppColors;
import 'package:blinqo/core/utils/constants/icon_path.dart';
import 'package:blinqo/features/role/event_planner/event_home_page/controllers/upcoming_events_controller.dart';
import 'package:blinqo/features/role/event_planner/profile/controller/pick_color_controller.dart';
import 'package:blinqo/features/role/event_planner/profile/controller/profile_controller.dart';
import 'package:blinqo/features/role/event_planner/venue_details/screen/ep_venue_details.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FeatureVenues extends StatelessWidget {
  final int index;
  final String hallName;
  final String location;
  final int guestCapacity;
  final String imagePath;
  final double rating;
  final bool hasButton;

  FeatureVenues({
    super.key,
    this.hasButton = true,
    required this.index,
    required this.hallName,
    required this.location,
    required this.guestCapacity,
    required this.imagePath,
    required this.rating,
  });
  final UpcomingEventsController controller = Get.put(
    UpcomingEventsController(),
  );

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double cardWidth = screenWidth * 0.7;
    double buttonFontSize = screenWidth <= 360 ? 14 : 16;
    final PickColorController femaleColorController = Get.put(
      PickColorController(),
    );
    final bool isFemale = femaleColorController.isFemale.value;
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
            _venueImageSection(themeMode),
            SizedBox(height: 12),
            FittedBox(
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.to(EpVenueDetails());
                    },
                    child: Text(
                      hallName, // Dynamically pass hall name
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
                      ? Image.asset(
                        IconPath.verifiedlogo,
                        height: 16,
                        width: 16,
                      )
                      : SizedBox.shrink(),
                ],
              ),
            ),
            SizedBox(height: 4),
            _venueLocationRow(location),
            // Dynamically pass location
            SizedBox(height: 4),
            GestureDetector(
              onTap: () {
                controller.toggleContainerVisibility();
              },
              child: Text(
                'Add to Compare',
                style: getTextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color:
                      themeMode == ThemeMode.dark
                          ? AppColors.secondary
                          : isFemale
                          ? femaleColorController.selectedColor
                          : AppColors.iconColor,
                ),
              ),
            ),
            hasButton
                ? _venueBottomRow(
                  buttonFontSize,
                  themeMode,
                  isFemale,
                  femaleColorController,
                )
                : Container(),
          ],
        ),
      );
    });
  }

  Widget _venueImageSection(ThemeMode themeMode) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child:
              imagePath.startsWith('http') || imagePath.startsWith('https')
                  ? Image.network(
                    imagePath,
                    width: 237,
                    height: 187,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Image.asset(
                        'assets/images/placeholder.png',
                        width: 237,
                        height: 187,
                        fit: BoxFit.cover,
                      );
                    },
                  )
                  : Image.asset(
                    imagePath,
                    width: 237,
                    height: 187,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Image.asset(
                        'assets/images/placeholder.png',
                        width: 237,
                        height: 187,
                        fit: BoxFit.cover,
                      );
                    },
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
                  rating.toString(), // Dynamically pass rating
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
      ],
    );
  }

  Widget _venueLocationRow(String location) {
    return Row(
      children: [
        Icon(Icons.location_on_rounded, color: Color(0xff8A8A8A), size: 16),
        SizedBox(width: 4),
        Text(
          location, // Dynamically pass location
          style: getTextStyle(color: Color(0xff8A8A8A), fontSize: 12),
        ),
      ],
    );
  }

  Widget _venueBottomRow(
    double buttonFontSize,
    ThemeMode themeMode,
    bool isFemale,
    PickColorController femaleColorController,
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
              '$guestCapacity Guests', // Dynamically pass guest capacity
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
                themeMode == ThemeMode.dark
                    ? AppColors.buttonColor
                    : isFemale
                    ? femaleColorController.selectedColor
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
