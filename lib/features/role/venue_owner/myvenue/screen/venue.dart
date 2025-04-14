import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/utils/constants/image_path.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../core/utils/constants/colors.dart';
import '../../../../../core/utils/constants/icon_path.dart';
import '../widget/SearchBarWidget.dart';
import '../widget/venueplaceholder.dart';
import 'venueDetailsScreen.dart';

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
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final double screenHeight = constraints.maxHeight;
            final double screenWidth = constraints.maxWidth;

            return SingleChildScrollView(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 20,
                        backgroundColor: const Color(0xFFD9D9D9),
                        child: Image.asset(IconPath.arrowLeftAlt),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Center(
                          child: Text(
                            'My Venues',
                            style: getTextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xff333333),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  SearchBarWidget(controller: searchController),
                  const SizedBox(height: 20),

                  // Venue List
                  venueList.isEmpty
                      ? const VenuePlaceholderWidget()
                      : ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: venueList.length,
                    itemBuilder: (context, index) {
                      final venue = venueList[index];

                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
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
                                          borderRadius: BorderRadius.circular(16),
                                          gradient: LinearGradient(
                                            begin: Alignment.bottomCenter,
                                            end: Alignment.topCenter,
                                            colors: [
                                              Colors.black.withOpacity(0.6),
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
                                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(8),
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
                                Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        venue['title']!,
                                        style: getTextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          color: const Color(0xff333333),
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Row(
                                        children: [
                                          const Icon(
                                            Icons.location_on_outlined,
                                            size: 14,
                                            color: Color(0xff8A8A8A),
                                          ),
                                          const SizedBox(width: 4),
                                          Text(
                                            venue["address"]!,
                                            style: getTextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 12,
                                              color: const Color(0xff8A8A8A),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 10),
                                      Row(
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                            decoration: BoxDecoration(
                                              color: const Color(0xff676767).withOpacity(.67),
                                              borderRadius: BorderRadius.circular(8),
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
                                                transition: Transition.rightToLeft,
                                              );
                                            },
                                            child: Container(
                                              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 14),
                                              decoration: BoxDecoration(
                                                color: const Color(0xffD4AF37),
                                                borderRadius: BorderRadius.circular(12),
                                              ),
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
                                        ],
                                      )
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

                  const SizedBox(height: 30),
                  // Add Venue Button
                  Center(
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 16),
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
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
