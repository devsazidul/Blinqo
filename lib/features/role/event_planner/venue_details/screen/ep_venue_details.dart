import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/common/widgets/custom_button.dart';
import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:blinqo/core/utils/constants/icon_path.dart';
import 'package:blinqo/features/profile/controller/profile_controller.dart';
import 'package:blinqo/features/role/event_planner/venue_details/controller/ep_venuw_details_controller.dart';
import 'package:blinqo/features/role/event_planner/venue_details/screen/ep_all_reviews.dart';
import 'package:blinqo/features/role/event_planner/venue_details/widget/ep_vanue_details_custom_text_widget.dart';
import 'package:blinqo/features/role/event_planner/venue_details/widget/ep_vanue_details_custom_widget.dart';
import 'package:blinqo/features/role/event_planner/venue_details/widget/ep_venue_details_custom_review_widget.dart';
import 'package:blinqo/features/role/event_planner/venue_details/widget/venue_image_header.dart';
import 'package:blinqo/features/role/service_provider/profile_setup_page/controller/profile_setup_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class EpVenueDetails extends StatelessWidget {
  EpVenueDetails({super.key});
  final EpVenuwDetailsController epVenuwDetailsController = Get.put(
    EpVenuwDetailsController(),
  );
  final ProfileSetupController profileController = Get.put(
    ProfileSetupController(),
  );
  final controller = Get.put(ProfileController());
  @override
  Widget build(BuildContext context) {
    bool isDarkMode = controller.isDarkMode.value;
    final Size screenSize = MediaQuery.of(context).size;
    final double screenWidth = screenSize.width;
    return Scaffold(
      backgroundColor:
          isDarkMode
              ? AppColors.darkBackgroundColor
              : AppColors.backgroundColor,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            VenueImageHeader(onBackTap: () => Get.back()),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 12),
                  Row(
                    children: [
                      Text(
                        'The Grand Hall',
                        style: getTextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                          color:
                              isDarkMode
                                  ? AppColors.primary
                                  : AppColors.textColor,
                        ),
                      ),
                      SizedBox(width: 8),
                      Image.asset(IconPath.verify, height: 16, width: 16),
                      SizedBox(width: screenWidth * 0.068),
                      Expanded(
                        child: Container(
                          width: double.infinity,
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color:
                                isDarkMode
                                    ? AppColors.buttonColor.withValues(
                                      alpha: .10,
                                    )
                                    : AppColors.buttonColor2.withValues(
                                      alpha: .10,
                                    ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Center(
                              child: Row(
                                children: [
                                  Text(
                                    '\$',
                                    style: getTextStyle(
                                      color:
                                          isDarkMode
                                              ? AppColors.buttonColor
                                              : AppColors.buttonColor2,

                                      fontSize: 20,
                                    ),
                                  ),
                                  SizedBox(width: 8),
                                  Text(
                                    'Set Price',
                                    style: getTextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color:
                                          isDarkMode
                                              ? AppColors.buttonColor
                                              : AppColors.buttonColor2,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12),
                  Row(
                    children: [
                      Icon(Icons.star, size: 15, color: Color(0xffF0C020)),
                      SizedBox(width: 8),
                      Text(
                        '5.0',
                        style: getTextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color:
                              isDarkMode
                                  ? AppColors.primary
                                  : AppColors.textColor,
                        ),
                      ),
                      SizedBox(width: 8),
                      Text(
                        '(345 reviews)',
                        style: getTextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: Color(0xffABB7C2),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      EpVenueDeatilsCustomWidget(
                        imagePath: IconPath.epguests,
                        guestText: '200 Guests',
                      ),
                      EpVenueDeatilsCustomWidget(
                        imagePath: IconPath.eproom,
                        guestText: 'Rooms',
                      ),
                      EpVenueDeatilsCustomWidget(
                        imagePath: IconPath.epoutdoor,
                        guestText: 'Outdoor',
                      ),
                    ],
                  ),
                  SizedBox(height: 15),
                  EpVanueDetailsCustomTextWidget(
                    text: 'Compare',
                    fontSize: 16,
                    color:
                        isDarkMode
                            ? AppColors.buttonColor
                            : AppColors.buttonColor2,
                    alignment: Alignment.centerRight,
                    fontWeight: FontWeight.w700,
                  ),
                  SizedBox(height: 15),
                  EpVanueDetailsCustomTextWidget(
                    text: 'Description',
                    fontSize: 20,
                    color: isDarkMode ? AppColors.primary : AppColors.textColor,
                    alignment: Alignment.centerLeft,
                    fontWeight: FontWeight.w700,
                  ),
                  SizedBox(height: 12),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      "Lorem ipsum dolor sit amet consectetur. Interdum ac hac nec etiam. Augue etiam ornare eu velit ultrices pharetra. Velit fringilla tellus justo sed et praesent quam praesent in. Scelerisque venenatis leo nunc convallis vel amet faucibus mattis parturient.",
                      style: getTextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color:
                            isDarkMode
                                ? AppColors.primary
                                : AppColors.subTextColor,
                      ),
                    ),
                  ),
                  SizedBox(height: 44),
                  EpVanueDetailsCustomTextWidget(
                    text: "Location",
                    fontSize: 20,
                    color: isDarkMode ? AppColors.primary : AppColors.textColor,
                    alignment: Alignment.centerLeft,
                    fontWeight: FontWeight.w500,
                  ),
                  SizedBox(height: 12),
                  Row(
                    children: [
                      Image.asset(
                        IconPath.projectrequestlocation,
                        width: 24,
                        height: 24,
                        color: AppColors.buttonColor2,
                      ),
                      SizedBox(width: 8),
                      Text(
                        "New York",
                        style: getTextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color:
                              isDarkMode
                                  ? AppColors.primary
                                  : AppColors.textColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    height: 200,
                    child: Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: GetBuilder<ProfileSetupController>(
                            builder: (_) {
                              return GoogleMap(
                                onMapCreated: profileController.onMapCreated,
                                initialCameraPosition: CameraPosition(
                                  target: profileController.center,
                                  zoom: 16.0,
                                ),
                                markers: profileController.mapMarkers,
                                myLocationButtonEnabled: false,
                                zoomControlsEnabled: false,
                              );
                            },
                          ),
                        ),
                        Positioned(
                          bottom: 10,
                          right: 10,
                          child: FloatingActionButton(
                            onPressed: () {
                              if (profileController.mapController != null) {
                                profileController.mapController!.animateCamera(
                                  CameraUpdate.newLatLng(
                                    profileController.center,
                                  ),
                                );
                              }
                            },
                            backgroundColor: Colors.white,
                            mini: true,
                            elevation: 4,
                            child: Image.asset(
                              IconPath.mylocation,
                              width: 24,
                              height: 24,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 38),
                  EpVanueDetailsCustomTextWidget(
                    text: "Reviews",
                    fontSize: 20,
                    color: isDarkMode ? AppColors.primary : AppColors.textColor,
                    alignment: Alignment.centerLeft,
                    fontWeight: FontWeight.w500,
                  ),
                  SizedBox(height: 20),
                  SizedBox(
                    height: 250,
                    child: ListView.builder(
                      itemCount: 2,
                      itemBuilder: (context, index) {
                        final review = epVenuwDetailsController.reviews[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: EpVenueDetailsCustomReviewsWidget(
                            userName: review["userName"]!,
                            userIcon: review["userIcon"]!,
                            reviewDate: review["reviewDate"]!,
                            reviewText: review["reviewText"]!,
                            rating: int.parse(review["rating"]!),
                          ),
                        );
                      },
                    ),
                  ),

                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Get.to(EpAllReviews());
                        },
                        child: Row(
                          children: [
                            Text(
                              "Explore All",
                              style: getTextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: AppColors.buttonColor,
                              ),
                            ),
                            SizedBox(width: 8),
                            Image.asset(
                              IconPath.exploreallright,
                              width: 13,
                              height: 6,
                              color: AppColors.buttonColor,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  CustomButton(title: "Book Now", onPress: () {}),
                  SizedBox(height: 40),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
