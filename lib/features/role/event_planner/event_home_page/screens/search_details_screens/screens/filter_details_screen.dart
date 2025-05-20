import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/common/widgets/custom_appbar_widget.dart';
import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:blinqo/core/utils/constants/icon_path.dart';
import 'package:blinqo/features/role/event_planner/event_home_page/controllers/search_details_controller/search_details_controller.dart';
import 'package:blinqo/features/role/event_planner/event_home_page/screens/search_details_screens/widget/filter_booking_type.dart';
import 'package:blinqo/features/role/event_planner/event_home_page/screens/search_details_screens/widget/filter_capacity.dart';
import 'package:blinqo/features/role/event_planner/event_home_page/screens/search_details_screens/widget/filter_data_availability.dart';
import 'package:blinqo/features/role/event_planner/event_home_page/screens/search_details_screens/widget/filter_location.dart';
import 'package:blinqo/features/role/event_planner/event_home_page/screens/search_details_screens/widget/filter_ratings_reviews.dart';
import 'package:blinqo/features/role/event_planner/event_home_page/screens/search_details_screens/widget/filter_toggle_button.dart';
import 'package:blinqo/features/role/event_planner/event_home_page/screens/search_details_screens/widget/filter_vanue_type.dart';
import 'package:blinqo/features/role/event_planner/profile/controller/pick_color_controller.dart';
import 'package:blinqo/features/role/event_planner/profile/controller/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FilterDetailsScreen extends StatelessWidget {
  final ProfileController themeController = Get.put(ProfileController());
  final SearchDetailsController searchDetailsController = Get.put(
    SearchDetailsController(),
  );
  final PickColorController femaleColorController = Get.put(
    PickColorController(),
  );

  FilterDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = themeController.isDarkMode.value;
    final bool isFemale = femaleColorController.isFemale.value;

    return Scaffold(
      backgroundColor:
          isDarkMode
              ? AppColors.darkBackgroundColor
              : AppColors.backgroundColor,
      // appBar: _buildAppBar(context, isDarkMode),
      appBar: CustomAppBarWidget(title: "Filter"),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 28),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              _buildFilterSection(
                icon: Icons.location_on,
                title: 'Location',
                isDarkMode: isDarkMode,
                isFemale: isFemale,
                child: Location(
                  searchDetailsController: searchDetailsController,
                ),
              ),
              const SizedBox(height: 42),
              _buildFilterSection(
                icon: Icons.calendar_month,
                title: 'Date & Availability',
                isDarkMode: isDarkMode,
                isFemale: isFemale,
                child: DataAvailability(),
              ),
              const SizedBox(height: 40),
              _buildFilterSection(
                icon: Icons.reduce_capacity,
                title: 'Capacity',
                isDarkMode: isDarkMode,
                isFemale: isFemale,
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    Capacity(searchDetailsController: searchDetailsController),
                    const SizedBox(height: 20),
                    const SizedBox(height: 24),
                    VanueType(searchDetailsController: searchDetailsController),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              _buildFilterSection(
                icon: IconPath.shoppingmode,
                isImageIcon: true,
                title: 'Booking Type',
                isDarkMode: isDarkMode,
                isFemale: isFemale,
                child: BookingType(
                  searchDetailsController: searchDetailsController,
                ),
              ),
              const SizedBox(height: 20),
              _buildFilterSection(
                icon: IconPath.cardsstar,
                isImageIcon: true,
                title: 'Ratings & Reviews',
                isDarkMode: isDarkMode,
                isFemale: isFemale,
                child: RatingsReviews(
                  searchDetailsController: searchDetailsController,
                ),
              ),
              _buildVerifiedSection(isDarkMode, isFemale),
              ToggleButton(),
              const SizedBox(height: 58),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFilterSection({
    required dynamic icon,
    required String title,
    required bool isDarkMode,
    required bool isFemale,
    required Widget child,
    bool isImageIcon = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            isImageIcon
                ? Image.asset(
                  icon,
                  width: 20,
                  color:
                      isDarkMode
                          ? AppColors.buttonColor
                          : isFemale
                          ? femaleColorController.selectedColor
                          : AppColors.buttonColor2,
                )
                : Icon(
                  icon,
                  color:
                      isDarkMode
                          ? AppColors.buttonColor
                          : isFemale
                          ? femaleColorController.selectedColor
                          : AppColors.buttonColor2,
                ),
            const SizedBox(width: 8),
            Text(
              title,
              style: getTextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color:
                    isDarkMode ? AppColors.borderColor2 : AppColors.textColor,
              ),
            ),
          ],
        ),
        child,
      ],
    );
  }

  Widget _buildVerifiedSection(bool isDarkMode, bool isFemale) {
    return Obx(
      () => Row(
        children: [
          InkWell(
            onTap: () => searchDetailsController.toggleTab(0),
            child: Container(
              width: 14,
              height: 14,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color:
                      searchDetailsController.selectedTab.value == 0
                          ? (isDarkMode
                              ? AppColors.buttonColor
                              : isFemale
                              ? femaleColorController.selectedColor
                              : AppColors.buttonColor2)
                          : Colors.grey,
                  width: 2,
                ),
              ),
              child:
                  searchDetailsController.selectedTab.value == 0
                      ? Center(
                        child: Container(
                          width: 12,
                          height: 12,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color:
                                isDarkMode
                                    ? AppColors.buttonColor
                                    : isFemale
                                    ? femaleColorController.selectedColor
                                    : AppColors.buttonColor2,
                          ),
                        ),
                      )
                      : null,
            ),
          ),
          const SizedBox(width: 8),
          Text(
            'Verified',
            style: getTextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: isDarkMode ? AppColors.borderColor2 : AppColors.textColor,
            ),
          ),
        ],
      ),
    );
  }
}
