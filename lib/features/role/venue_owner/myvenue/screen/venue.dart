import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/utils/constants/image_path.dart';
import 'package:blinqo/features/role/venue_owner/myvenue/screen/venue_details_screen.dart' show VenueDetailsScreen;
import 'package:blinqo/features/role/venue_owner/overview/screen/add_new_venue.dart';
import 'package:blinqo/features/role/venue_owner/profile_page/controller/venue_owner_profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../core/utils/constants/colors.dart';
import '../../../../../core/utils/constants/icon_path.dart';
import '../widget/SearchBarWidget.dart';
import '../widget/venueplaceholder.dart';

class Venue extends StatelessWidget {
  Venue({super.key});

  final TextEditingController searchController = TextEditingController();

  final List<Map<String, String>> venueList = [
    {
      "title": "The Grand Hall",
      "address": "New York",
      "guest": "300 Guests",
      "rating": "4.5",
      "image": ImagePath.myvenue2,
    },
    {
      "title": "The Crystal Room",
      "address": "Los Angeles",
      "guest": "250 Guests",
      "rating": "4.7",
      "image": ImagePath.myvenue1,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final bool isDarkMode =
        Get.put(VenueOwnerProfileController()).isDarkMode.value;

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

              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // CircleAvatar(
                  //   radius: 20,
                  //   backgroundColor:
                  //       isDarkMode
                  //           ? Color(0xFFD9D9D9).withAlpha(40)
                  //           : Color(0xFFD9D9D9),
                  //   child: Image.asset(
                  //     IconPath.arrowLeftAlt,
                  //     width: 16,
                  //     height: 12,
                  //     color: isDarkMode ? Colors.white : AppColors.textColor,
                  //   ),
                  // ),
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

              venueList.isEmpty
                  ? const VenuePlaceholderWidget()
                  : ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: venueList.length,
                    itemBuilder: (context, index) {
                      final venue = venueList[index];

                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 6),
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color:
                                isDarkMode ? Color(0xff132383D) : Colors.white,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Image with overlay
                                Stack(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(16),
                                      child: Image.asset(
                                        venue["image"]!,
                                        width: double.infinity,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    Positioned.fill(
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                            16,
                                          ),
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
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 10,
                                          vertical: 3,
                                        ),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(
                                            8,
                                          ),
                                        ),
                                        child: Row(
                                          children: [
                                            Text(
                                              venue["rating"]!,
                                              style: getTextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w600,
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
                                      child: CircleAvatar(
                                        radius: 14,
                                        backgroundColor: Colors.white,
                                        child: const Icon(
                                          Icons.favorite_border,
                                          size: 14,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 12),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                          height: 14,
                                        ),
                                        const SizedBox(width: 4),
                                        Text(
                                          venue["address"]!,
                                          style: getTextStyle(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 12,
                                            color:
                                                isDarkMode
                                                    ? Color(0xff8A8A8A)
                                                    : Color(0xff8A8A8A),
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
                                          ), // এটা নতুন যোগ করেছি
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 22,
                                            vertical: 4,
                                          ),
                                          decoration: BoxDecoration(
                                            color: const Color(
                                              0xff676767,
                                            ).withAlpha(170),
                                            borderRadius: BorderRadius.circular(
                                              8,
                                            ),
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
                                          onTap: () {
                                            Get.to(
                                              () => VenueDetailsScreen(
                                                title: venue['title']!,
                                                address: venue['address']!,
                                                guest: venue['guest']!,
                                                rating: venue['rating']!,
                                                image: venue['image']!,
                                              ),
                                              transition:
                                                  Transition.rightToLeft,
                                            );
                                          },
                                          child: Container(
                                            height: screenWidth * 0.12,
                                            width: screenHeight * 0.25,
                                            decoration: BoxDecoration(
                                              color: const Color(0xffD4AF37),
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                            ),
                                            child: Center(
                                              child: Text(
                                                "View Details",
                                                style: getTextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500,
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
              const SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 6),
                child: Center(
                  child: InkWell(
                    onTap: () {
                      Get.to(
                        () => AddNewVenue(image: ImagePath.venuesHall),
                      );
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
            ],
          ),
        ),
      ),
    );
  }
}
