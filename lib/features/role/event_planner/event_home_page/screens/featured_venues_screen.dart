import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/common/widgets/custom_appbar_widget.dart';
import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:blinqo/core/utils/constants/icon_path.dart';
import 'package:blinqo/features/role/event_planner/ep_common/widgets/ep_bottom_nav_bar_widget.dart';
import 'package:blinqo/features/role/event_planner/event_home_page/controllers/upcoming_events_controller.dart';
import 'package:blinqo/features/role/event_planner/ep_home/controller/ep_get_all_venues_controller.dart';
import 'package:blinqo/features/role/event_planner/ep_home/controller/ep_venue_compare_controller.dart';
import 'package:blinqo/features/role/event_planner/ep_home/model/ep_venues_response_model.dart';
import 'package:blinqo/features/role/event_planner/ep_home/wigate/animated_venue_compare_dialog.dart';
import 'package:blinqo/features/role/event_planner/profile/controller/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// A screen that displays a grid of featured venues.
class FeaturedVenuesScreen extends StatelessWidget {
  const FeaturedVenuesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ProfileController profileController = Get.find<ProfileController>();
    final UpcomingEventsController controller = Get.put(
      UpcomingEventsController(),
    );

    return Obx(() {
      final themeMode =
          profileController.isDarkMode.value ? ThemeMode.dark : ThemeMode.light;

      return Scaffold(
        backgroundColor:
            themeMode == ThemeMode.dark
                ? Colors.black
                : AppColors.backgroundColor,
        appBar: CustomAppBarWidget(title: 'Featured Venues'),
        bottomNavigationBar: EpBottomNavBarWidget(),
        body: _buildVenuesGrid(context, controller, themeMode),
      );
    });
  }

  /// Builds the grid of venues.
  Widget _buildVenuesGrid(
    BuildContext context,
    UpcomingEventsController controller,
    ThemeMode themeMode,
  ) {
    return GetBuilder<EpGetAllVenuesController>(
      builder: (controller) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 169 / 227,
            ),
            itemCount: controller.homeResponseData?.featuredVenues?.length ?? 0,
            itemBuilder:
                (context, index) =>
                    _buildVenueCard(context, controller, index, themeMode),
          ),
        );
      },
    );
  }

  /// Builds a single venue card in the grid.
  Widget _buildVenueCard(
    BuildContext context,
    EpGetAllVenuesController controller,
    int index,
    ThemeMode themeMode,
  ) {
    return Card(
      color:
          themeMode == ThemeMode.dark
              ? const Color(0xff32383D)
              : const Color(0xffFFFFFF),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                _buildVenueImage(controller, index),
                _buildRatingBadge(themeMode),
                _buildFavoriteIcon(themeMode),
              ],
            ),
            const SizedBox(height: 12),
            _buildVenueName(controller, index, themeMode),
            _buildVenueLocation(controller, index, themeMode),
            Expanded(
              child: Align(
                alignment: Alignment.centerLeft,
                child: _buildCompareButton(
                  themeMode,
                  controller.homeResponseData?.featuredVenues?[index] ??
                      FeaturedVenue(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Builds the venue image with proper aspect ratio.
  Widget _buildVenueImage(EpGetAllVenuesController controller, int index) {
    return AspectRatio(
      aspectRatio: 145 / 123,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.network(
          controller
                  .homeResponseData
                  ?.featuredVenues?[index]
                  .venueImage
                  ?.path ??
              "",
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  /// Builds the rating badge.
  Widget _buildRatingBadge(ThemeMode themeMode) {
    return Positioned(
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
              "4.5",
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
    );
  }

  /// Build Favorite Icon
  Widget _buildFavoriteIcon(ThemeMode themeMode) {
    return Positioned(
      top: 8,
      right: 8,
      child: Container(
        width: 20,
        height: 20,
        // padding: EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          // border: Border.all(
          //   color: themeMode == ThemeMode.dark ? Colors.white : Colors.black,
          // ),
        ),
        child: Icon(
          Icons.favorite_border,
          size: 12,
          color: themeMode == ThemeMode.dark ? Colors.white : Colors.black,
        ),
      ),
    );
  }

  /// Builds the venue name row with verification badge.
  Widget _buildVenueName(
    EpGetAllVenuesController controller,
    int index,
    ThemeMode themeMode,
  ) {
    final name = controller.homeResponseData?.featuredVenues?[index].name ?? "";
    final isLongName = (name.length) > 16;

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        isLongName
            ? Expanded(
              child: Text(
                name,
                style: TextStyle(
                  overflow: TextOverflow.ellipsis,
                  fontFamily: 'Roboto',
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color:
                      themeMode == ThemeMode.dark ? Colors.white : Colors.black,
                ),
              ),
            )
            : Text(
              name,
              style: const TextStyle(
                fontFamily: 'Roboto',
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
        const SizedBox(width: 8),
        Image.asset(IconPath.verify, width: 16, height: 16),
      ],
    );
  }

  /// Builds the venue location row.
  Widget _buildVenueLocation(
    EpGetAllVenuesController controller,
    int index,
    ThemeMode themeMode,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(
          IconPath.locationOn,
          width: 10,
          height: 12,
          color:
              themeMode == ThemeMode.dark
                  ? Colors.white
                  : const Color(0xff8A8A8A),
        ),
        const SizedBox(width: 4),
        Text(
          controller.homeResponseData?.featuredVenues?[index].city ?? "",
          style: getTextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w400,
            color:
                themeMode == ThemeMode.dark
                    ? Colors.white
                    : const Color(0xff8A8A8A),
          ),
        ),
      ],
    );
  }

  /// Builds the "Add to Compare" button.
  Widget _buildCompareButton(ThemeMode themeMode, FeaturedVenue venue) {
    // double x = 1.0;
    // double y = -1.0 + (2.0 * 120.0 / 360);
    // Alignment targetAlignment = Alignment(x, y);
    return GestureDetector(
      // onTap: () {
      //   Get.dialog(
      //     Stack(
      //       children: [
      //         Positioned.fill(
      //           child: GestureDetector(
      //             onTap: () => Get.back(),
      //             child: Container(color: Colors.black54),
      //           ),
      //         ),
      //         Positioned(
      //           top: 120,
      //           right: 0,
      //           child: TweenAnimationBuilder<double>(
      //             duration: Duration(milliseconds: 300),
      //             tween: Tween(begin: 200.0, end: 0.0),
      //             builder: (context, value, child) {
      //               return Transform.translate(
      //                 offset: Offset(value, 0),
      //                 child: child,
      //               );
      //             },
      //             child: VenueComparePopup(),
      //           ),
      //         ),
      //       ],
      //     ),
      //     barrierDismissible: true,
      //   );
      // },
      onTap: () {
        Get.put(EpVenueCompareController()).addVenueToCompare(venue);
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
          color:
              themeMode == ThemeMode.dark
                  ? const Color(0xffD4AF37)
                  : const Color(0xff003366),
        ),
      ),
    );
  }
}
