import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/utils/constants/image_path.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../core/utils/constants/colors.dart';
import '../../../../../core/utils/constants/icon_path.dart';
import '../widget/SearchBarWidget.dart';
import '../widget/venueplaceholder.dart';
import 'VenueDetailsScreen.dart';

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
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 20,
                      backgroundColor: const Color(0xFFD9D9D9),
                      child: Image.asset(IconPath.arrowLeftAlt),
                    ),
                    SizedBox(width: 70),
                    Text(
                      'My Venues ',
                      style: getTextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                        color: Color(0xff333333),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 26),
                SearchBarWidget(controller: searchController),
                SizedBox(height: 25),
                venueList.isEmpty
                    ? VenuePlaceholderWidget()
                    : ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: venueList.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Container(
                            height:
                                MediaQuery.of(context).size.height *
                                (314 / MediaQuery.of(context).size.height),
                            width:
                                MediaQuery.of(context).size.width *
                                (353 / MediaQuery.of(context).size.width),
                            decoration: BoxDecoration(
                              color: Color(0xffFFFFFF),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    height:
                                        MediaQuery.of(context).size.height *
                                        (187 /
                                            MediaQuery.of(context).size.height),
                                    width: double.infinity,
                                    child: Stack(
                                      children: [
                                        /// **Background Image**
                                        Positioned.fill(
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.circular(
                                              12,
                                            ),
                                            child: Image.asset(
                                              venueList[index]["image"]!,
                                              fit:
                                                  BoxFit
                                                      .cover, // Ensure image covers the area properly
                                            ),
                                          ),
                                        ),

                                        /// **Gradient Overlay (Optional)**
                                        Positioned.fill(
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              gradient: LinearGradient(
                                                begin: Alignment.bottomCenter,
                                                end: Alignment.topCenter,
                                                colors: [
                                                  Colors.black.withOpacity(
                                                    0.6,
                                                  ), // Dark gradient at bottom
                                                  Colors
                                                      .transparent, // Fade to transparent
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          top: 12,
                                          left: 12,
                                          child: Container(
                                            height:
                                                MediaQuery.of(
                                                  context,
                                                ).size.height *
                                                (20 /
                                                    MediaQuery.of(
                                                      context,
                                                    ).size.height),
                                            width:
                                                MediaQuery.of(
                                                  context,
                                                ).size.width *
                                                (49 /
                                                    MediaQuery.of(
                                                      context,
                                                    ).size.width),
                                            decoration: BoxDecoration(
                                              color: Color(0xffFFFFFF),
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                SizedBox(width: 6),
                                                Text(
                                                  venueList[index]["rating"]!,
                                                  style: getTextStyle(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w600,
                                                    color: Color(0xff000000),
                                                  ),
                                                ),
                                                SizedBox(width: 3),
                                                Icon(
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
                                          child: Container(
                                            height:
                                                MediaQuery.of(
                                                  context,
                                                ).size.height *
                                                (24 /
                                                    MediaQuery.of(
                                                      context,
                                                    ).size.height),
                                            width:
                                                MediaQuery.of(
                                                  context,
                                                ).size.width *
                                                (24 /
                                                    MediaQuery.of(
                                                      context,
                                                    ).size.width),
                                            decoration: BoxDecoration(
                                              color: Color(0xffFFFFFF),
                                              shape: BoxShape.circle,
                                            ),
                                            child: Center(
                                              child: Icon(
                                                Icons.favorite_border,
                                                size: 12,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 12),
                                  Text(
                                    venueList[index]['title']!,
                                    style: getTextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xff333333),
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.location_on_outlined,
                                        weight: 12,
                                        color: Color(0xff8A8A8A),
                                      ),
                                      Text(
                                        venueList[index]["address"]!,
                                        style: getTextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 12,
                                          color: Color(0xff8A8A8A),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Spacer(),
                                  Row(
                                    children: [
                                      Container(
                                        height:
                                            MediaQuery.of(context).size.height *
                                            (22 /
                                                MediaQuery.of(
                                                  context,
                                                ).size.height),
                                        width:
                                            MediaQuery.of(context).size.height *
                                            (78 /
                                                MediaQuery.of(
                                                  context,
                                                ).size.height),
                                        decoration: BoxDecoration(
                                          color: Color(
                                            0xff676767,
                                          ).withOpacity(.67),
                                          borderRadius: BorderRadius.circular(
                                            8,
                                          ),
                                        ),
                                        child: Center(
                                          child: Text(
                                            venueList[index]["guest"]!,
                                            style: getTextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600,
                                              color: Color(0xffFFFFFF),
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 22),
                                      InkWell(
                                        onTap: () {
                                          Get.to(
                                            () => VenueDetailsScreen(
                                              title: venueList[index]['title']!,
                                              address:
                                                  venueList[index]['address']!,
                                              guest: venueList[index]['guest']!,
                                              rating:
                                                  venueList[index]['rating']!,
                                              image: venueList[index]['image']!,
                                            ),
                                            transition: Transition.rightToLeft,
                                          );
                                        },
                                        child: Container(
                                          height:
                                              MediaQuery.of(
                                                context,
                                              ).size.height *
                                              (42 /
                                                  MediaQuery.of(
                                                    context,
                                                  ).size.height),
                                          width:
                                              MediaQuery.of(
                                                context,
                                              ).size.width *
                                              (245 /
                                                  MediaQuery.of(
                                                    context,
                                                  ).size.width),
                                          decoration: BoxDecoration(
                                            color: Color(0xffD4AF37),
                                            borderRadius: BorderRadius.circular(
                                              12,
                                            ),
                                          ),
                                          child: Center(
                                            child: Text(
                                              "View Details",
                                              style: getTextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500,
                                                color: Color(0xffFFFFFF),
                                              ),
                                            ),
                                          ),
                                        ),
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
                SizedBox(height: 30),
                Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: Container(
                    height:
                        MediaQuery.of(context).size.height *
                        (48 / MediaQuery.of(context).size.height),
                    width:
                        MediaQuery.of(context).size.width *
                        (360 / MediaQuery.of(context).size.width),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Color(0xff003366),
                      border: Border.all(width: 1, color: Color(0xff003366)),
                    ),
                    child: Center(
                      child: Text(
                        ' Add Venue  +',
                        style: getTextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Color(0xffF4F4F4),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
