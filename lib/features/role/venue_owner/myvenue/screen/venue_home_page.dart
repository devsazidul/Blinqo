import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/utils/constants/image_path.dart';
import 'package:blinqo/features/role/venue_owner/myvenue/controller/all_venue_details_controller.dart';
import 'package:blinqo/features/role/venue_owner/myvenue/controller/venue_details_controller.dart';

import 'package:blinqo/features/role/venue_owner/myvenue/screen/edit_venue.dart';
import 'package:blinqo/features/role/venue_owner/myvenue/screen/venue_details_screen.dart';
import 'package:blinqo/features/role/venue_owner/profile_page/controller/venue_owner_profile_controller.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../core/utils/constants/colors.dart';
import '../../../../../core/utils/constants/icon_path.dart';
import '../widget/SearchBarWidget.dart';
import '../widget/venueplaceholder.dart';

class VenueHomePage extends StatelessWidget {
  VenueHomePage({super.key});

  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    final bool isDarkMode =
        Get.put(VenueOwnerProfileController()).isDarkMode.value;
    final AllVenuesDetailsController venueController = Get.put(
      AllVenuesDetailsController(),
    );
    VenueDetailsController venueDetailsController = Get.put(
      VenueDetailsController(),
    );


    // Bind search bar input to filterVenues
    searchController.addListener(() {
      venueController.filterVenues(searchController.text);
    });

    return Scaffold(
      backgroundColor:
          isDarkMode ? Color(0xff151515) : AppColors.backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(width: 85),
                  Text(
                    'My Venues',
                    style: getTextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      color: isDarkMode ? Color(0xffEBEBEB) : Color(0xff333333),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              SearchBarWidget(textcontroller: searchController),
              const SizedBox(height: 12),
              Obx(
                () =>
                    venueController.response.value == null
                        ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const SizedBox(height: 16),
                              VenuePlaceholderWidget(),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      isDarkMode
                                          ? Color(
                                            0xff003366,
                                          ).withValues(alpha: 0.6)
                                          : const Color(
                                            0xff003366,
                                          ).withValues(alpha: 0.5),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 20,
                                    vertical: 10,
                                  ),
                                ),
                                onPressed: () {
                                  venueController.getAllVenues();
                                },
                                child: const Text(
                                  'Retry',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                        : venueController.filteredVenues.isEmpty
                        ? const VenuePlaceholderWidget()
                        : ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: venueController.filteredVenues.length,
                          itemBuilder: (context, index) {
                            final venue = venueController.filteredVenues[index];

                            // Get the original VenueData for navigation
                            // final venueData =
                            //     venueController.response.value!.data[index];

                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 6),
                              child: Container(
                                decoration: BoxDecoration(
                                  color:
                                      isDarkMode
                                          ? Color(0xff32383D)
                                          : Colors.white,
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Stack(
                                        children: [
                                          ClipRRect(
                                            borderRadius: BorderRadius.circular(
                                              16,
                                            ),
                                            child: CachedNetworkImage(
                                              imageUrl: venue["image"]!,
                                              width: double.infinity,
                                              height: screenHeight * 0.2,
                                              fit: BoxFit.cover,
                                              errorWidget:
                                                  (
                                                    context,
                                                    error,
                                                    stackTrace,
                                                  ) => Image.asset(
                                                    venue["image"]!,
                                                    width: double.infinity,
                                                    height: screenHeight * 0.2,
                                                    fit: BoxFit.cover,
                                                  ),
                                            ),
                                          ),
                                          Positioned.fill(
                                            child: Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(16),
                                                gradient: LinearGradient(
                                                  begin: Alignment.bottomCenter,
                                                  end: Alignment.topCenter,
                                                  colors: [
                                                    Colors.black.withAlpha(60),
                                                    Colors.transparent,
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            top: 12,
                                            left: 12,
                                            child: Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                    horizontal: 10,
                                                    vertical: 3,
                                                  ),
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                              child: Row(
                                                children: [
                                                  Text(
                                                    venue["rating"]!,
                                                    style: getTextStyle(
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                  const SizedBox(width: 4),
                                                  const Icon(
                                                    Icons.star,
                                                    size: 12,
                                                    color: Color(0xffD4AF37),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            top: 12,
                                            right: 12,
                                            child: Obx(() {
                                              bool isFavorite =
                                                  venueController
                                                      .favoriteList[index];
                                              return CircleAvatar(
                                                radius: 14,
                                                backgroundColor: Colors.white,
                                                child: GestureDetector(
                                                  onTap: () {
                                                    venueController
                                                        .toggleFavorite(index);
                                                  },
                                                  child: Icon(
                                                    isFavorite
                                                        ? Icons.favorite
                                                        : Icons.favorite_border,
                                                    size: 14,
                                                    color:
                                                        isFavorite
                                                            ? Colors.red
                                                            : Colors.black,
                                                  ),
                                                ),
                                              );
                                            }),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 12),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            venue['title']!,
                                            style: getTextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                              color:
                                                  isDarkMode
                                                      ? Color(0xffEBEBEB)
                                                      : Color(0xff333333),
                                            ),
                                          ),
                                          const SizedBox(height: 3),
                                          Row(
                                            children: [
                                              Image.asset(
                                                IconPath.locationOn,
                                                color: Color(0xff8A8A8A),
                                                height: 14,
                                              ),
                                              const SizedBox(width: 4),
                                              Text(
                                                venue["address"]!,
                                                style: getTextStyle(
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 12,
                                                  color: Color(0xff8A8A8A),
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 1),
                                          Row(
                                            children: [
                                              Container(
                                                margin: const EdgeInsets.only(
                                                  top: 15,
                                                ),
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                      horizontal: 22,
                                                      vertical: 4,
                                                    ),
                                                decoration: BoxDecoration(
                                                  color: const Color(
                                                    0xff676767,
                                                  ).withAlpha(170),
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                ),
                                                child: Text(
                                                  venue["guest"]!,
                                                  style: getTextStyle(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w600,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                              const Spacer(),
                                              InkWell(
                                                onTap: () async {
                                                  await venueDetailsController.getVenueDetails(venue['id']??'');

                                                  Get.to(
                                                    () => VenueDetailsScreen(),
                                                    transition:
                                                        Transition.rightToLeft,
                                                  );
                                                },
                                                child: Container(
                                                  height: screenWidth * 0.12,
                                                  width: screenHeight * 0.25,
                                                  decoration: BoxDecoration(
                                                    color: const Color(
                                                      0xffD4AF37,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          12,
                                                        ),
                                                  ),
                                                  child: Center(
                                                    child: Text(
                                                      "View Details",
                                                      style: getTextStyle(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
              ),
              const SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 6),
                child: Center(
                  child: InkWell(
                    onTap: () {
                      Get.to(() => EditVenue(image: ImagePath.venuesHall));
                    },
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: const Color(0xff003366),
                      ),
                      child: Center(
                        child: Text(
                          'Add Venue +',
                          style: getTextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: const Color(0xffF4F4F4),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 28),
            ],
          ),
        ),
      ),
    );
  }
}
