import 'package:blinqo/core/common/styles/global_text_style.dart'
    show getTextStyle;
import 'package:blinqo/core/utils/constants/colors.dart' show AppColors;
import 'package:blinqo/core/utils/constants/icon_path.dart';
import 'package:blinqo/features/role/event_planner/ep_home/controller/ep_venue_compare_controller.dart';
import 'package:blinqo/features/role/event_planner/ep_home/model/ep_venues_response_model.dart'
    show FeaturedVenue;
import 'package:blinqo/features/role/event_planner/ep_home/wigate/animated_venue_compare_dialog.dart';
import 'package:blinqo/features/role/event_planner/profile/controller/pick_color_controller.dart';
import 'package:blinqo/features/role/event_planner/profile/controller/profile_controller.dart';
import 'package:blinqo/features/role/event_planner/venue_details/screen/ep_venue_details.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// A widget that displays a featured venue card with details and actions.
class FeatureVenues extends StatelessWidget {
  // Constants
  static const double _cardPadding = 12.0;
  static const double _spacingSmall = 4.0;
  static const double _spacingMedium = 12.0;
  static const double _imageWidth = 237.0;
  static const double _imageHeight = 187.0;
  static const double _iconSize = 16.0;
  static const double _ratingIconSize = 12.0;
  static const double _borderRadius = 12.0;
  static const double _ratingBorderRadius = 8.0;

  // Properties
  final int index;
  final FeaturedVenue? venue;

  const FeatureVenues({super.key, required this.index, required this.venue});

  @override
  Widget build(BuildContext context) {
    // Controllers
    final PickColorController pickColorController = Get.put(
      PickColorController(),
    );
    final ProfileController profileController = Get.find<ProfileController>();
    final EpVenueCompareController venueCompareController =
        Get.find<EpVenueCompareController>();

    final screenWidth = MediaQuery.of(context).size.width;
    final cardWidth = screenWidth * 0.7;
    final buttonFontSize = screenWidth <= 360 ? 14.0 : 16.0;
    final isFemale = pickColorController.isFemale.value;

    return Obx(() {
      final themeMode =
          profileController.isDarkMode.value ? ThemeMode.dark : ThemeMode.light;

      return Container(
        width: cardWidth,
        padding: EdgeInsets.all(_cardPadding),
        decoration: BoxDecoration(
          color: _getCardBackgroundColor(themeMode),
          borderRadius: BorderRadius.circular(_borderRadius),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildVenueImage(themeMode),
            SizedBox(height: _spacingMedium),
            _buildVenueHeader(buttonFontSize, themeMode),
            SizedBox(height: _spacingSmall),
            _buildLocationRow(),
            SizedBox(height: _spacingSmall),
            _buildCompareButton(
              themeMode,
              isFemale,
              pickColorController,
              venueCompareController,
            ),
            // if (hasButton)
            _buildBottomRow(
              buttonFontSize,
              themeMode,
              isFemale,
              pickColorController,
            ),
          ],
        ),
      );
    });
  }

  Color _getCardBackgroundColor(ThemeMode themeMode) {
    return themeMode == ThemeMode.dark ? Color(0xff32383D) : AppColors.primary;
  }

  Widget _buildVenueImage(ThemeMode themeMode) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(_borderRadius),
          child: _buildVenueImageContent(),
        ),
        _buildRatingBadge(themeMode),
      ],
    );
  }

  Widget _buildVenueImageContent() {
    // final isNetworkImage =
    //     venue.venueImage?.path.startsWith('http') || venue.venueImage?.path.startsWith('https');

    // return isNetworkImage
    //     ?
    return Image.network(
      venue?.venueImage?.path ?? '',
      width: _imageWidth,
      height: _imageHeight,
      fit: BoxFit.cover,
      errorBuilder: _buildErrorImage,
    );
  }

  Widget _buildErrorImage(
    BuildContext context,
    Object error,
    StackTrace? stackTrace,
  ) {
    return Image.network(
      'https://images.unsplash.com/photo-1511795409834-ef04bbd61622?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1000&q=80',
      width: _imageWidth,
      height: _imageHeight,
      fit: BoxFit.cover,
    );
  }

  Widget _buildRatingBadge(ThemeMode themeMode) {
    return Positioned(
      top: 8,
      left: 8,
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: _spacingSmall,
          horizontal: _spacingSmall,
        ),
        decoration: BoxDecoration(
          color:
              themeMode == ThemeMode.dark
                  ? Color(0xffB0C0D0)
                  : AppColors.primary,
          borderRadius: BorderRadius.circular(_ratingBorderRadius),
        ),
        child: Row(
          children: [
            Text(
              // TODO: get rating from venue
              '4.5',
              style: getTextStyle(
                fontSize: _ratingIconSize,
                fontWeight: FontWeight.w600,
                color: Color(0xff32383D),
              ),
            ),
            SizedBox(width: _spacingSmall),
            Icon(
              Icons.star,
              size: _ratingIconSize,
              color:
                  themeMode == ThemeMode.dark
                      ? AppColors.primary
                      : Colors.black,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildVenueHeader(double fontSize, ThemeMode themeMode) {
    return FittedBox(
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Get.to(EpVenueDetails()),
            child: Text(
              venue?.name ?? '',
              style: getTextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.w600,
                color:
                    themeMode == ThemeMode.dark
                        ? AppColors.borderColor2
                        : AppColors.textColor,
              ),
            ),
          ),
          SizedBox(width: _spacingSmall),
          if (venue?.verified ?? false)
            Image.asset(
              IconPath.verifiedlogo,
              height: _iconSize,
              width: _iconSize,
            ),
        ],
      ),
    );
  }

  Widget _buildLocationRow() {
    return Row(
      children: [
        Icon(
          Icons.location_on_rounded,
          color: Color(0xff8A8A8A),
          size: _iconSize,
        ),
        SizedBox(width: _spacingSmall),
        Text(
          venue?.city ?? '',
          style: getTextStyle(color: Color(0xff8A8A8A), fontSize: 12),
        ),
      ],
    );
  }

  Widget _buildCompareButton(
    ThemeMode themeMode,
    bool isFemale,
    PickColorController colorController,
    EpVenueCompareController venueCompareController,
  ) {
    return GestureDetector(
      onTap: () {
        venueCompareController.addVenueToCompare(venue ?? FeaturedVenue());
        Get.dialog(
          AnimatedVenueCompareDialog(),
          barrierDismissible: false,
          useSafeArea: false,
        );
      },
      child: Text(
        'Add to Compare',
        style: getTextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w700,
          color: _getCompareButtonColor(themeMode, isFemale, colorController),
        ),
      ),
    );
  }

  Color _getCompareButtonColor(
    ThemeMode themeMode,
    bool isFemale,
    PickColorController colorController,
  ) {
    if (themeMode == ThemeMode.dark) return AppColors.secondary;
    return isFemale ? colorController.selectedColor : AppColors.iconColor;
  }

  Widget _buildBottomRow(
    double fontSize,
    ThemeMode themeMode,
    bool isFemale,
    PickColorController colorController,
  ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildGuestCapacityBadge(),
        SizedBox(width: 22),
        _buildViewDetailsButton(fontSize, themeMode, isFemale, colorController),
      ],
    );
  }

  Widget _buildGuestCapacityBadge() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade400,
        borderRadius: BorderRadius.circular(_ratingBorderRadius),
      ),
      padding: EdgeInsets.all(_spacingSmall),
      child: Text(
        '${venue?.capacity} Guests',
        style: getTextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: AppColors.primary,
        ),
      ),
    );
  }

  Widget _buildViewDetailsButton(
    double fontSize,
    ThemeMode themeMode,
    bool isFemale,
    PickColorController colorController,
  ) {
    return ElevatedButton(
      onPressed: () => Get.to(EpVenueDetails()),
      style: ElevatedButton.styleFrom(
        backgroundColor: _getButtonBackgroundColor(
          themeMode,
          isFemale,
          colorController,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(_borderRadius),
        ),
        padding: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
      ),
      child: Text(
        'View Details',
        style: getTextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.w500,
          color: AppColors.primary,
        ),
      ),
    );
  }

  Color _getButtonBackgroundColor(
    ThemeMode themeMode,
    bool isFemale,
    PickColorController colorController,
  ) {
    if (themeMode == ThemeMode.dark) return AppColors.buttonColor;
    return isFemale ? colorController.selectedColor : AppColors.buttonColor2;
  }
}
