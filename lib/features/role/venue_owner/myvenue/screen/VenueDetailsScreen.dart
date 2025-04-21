import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:blinqo/core/utils/constants/image_path.dart';
import 'package:blinqo/features/role/venue_owner/myvenue/screen/edit_venue.dart';
import 'package:blinqo/features/role/venue_owner/overview/widgets/NewWidget.dart';
import 'package:blinqo/features/role/venue_owner/overview/widgets/revenue_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../core/utils/constants/icon_path.dart';
import '../widget/custom_amenity.dart';
import '../widget/custom_calendar.dart';
import '../widget/custom_shape.dart';
import '../widget/date_pricecard.dart';
import '../widget/review_card.dart';
import '../widget/status_label.dart';

final ValueNotifier<List<DateTime>> selectedDatesNotifier =
    ValueNotifier<List<DateTime>>([
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day),
    ]);

class VenueDetailsScreen extends StatelessWidget {
  final String title;
  final String address;
  final String guest;
  final String rating;
  final String image;
  const VenueDetailsScreen({
    super.key,
    required this.title,
    required this.address,
    required this.guest,
    required this.rating,
    required this.image,
  });
  String getMonthName(int month) {
    const months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',//month name
    ];
    return months[month - 1];
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, String>> seereview = [
      {
        "title": "Floyd Miles",
        "time": "Today",
        "image": ImagePath.reviewer1,
        "desc":
            "Lorem ipsum dolor sit amet consectetur. Interdum ac hac nec etiam. Augue etiam ornare eu velit ultrices pharetra. Velit fringilla tellus justo sed et praesent quam praesent in. Scelerisque venenatis leo nunc convallis vel amet faucibus mattis parturient.",
      },
      {
        "title": "Renee Ellis",
        "time": "2 days ago",
        "image": ImagePath.reviewer3,
        "desc":
            "Aenean consectetur diam vel urna interdum, in pharetra sapien posuere. Curabitur varius eros sit amet nisi faucibus, eu posuere eros maximus. Vivamus nec lacus ut nisl dignissim convallis.",
      },
    ];
    TextEditingController priceCOntroller = TextEditingController();
    final Size screenSize = MediaQuery.of(context).size;
    final double screenHeight = screenSize.height;
    final double screenWidth = screenSize.width;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (selectedDatesNotifier.value.isEmpty) {
        final today = DateTime.now();
        selectedDatesNotifier.value = [
          DateTime(today.year, today.month, today.day),
        ];
      }
    });
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Opacity(
                  opacity: 0.8,
                  child: Image.asset(
                    image,
                    width: double.infinity,
                    height: screenHeight * 0.4,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [
                          Color(0xff161616),
                          // ignore: deprecated_member_use
                          Color(0xff000000).withOpacity(.1),
                        ],
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Stack(
                        children: [
                          Positioned(
                            left: 24,
                            top: 40,
                            child: CircleAvatar(
                              radius: 20,
                              backgroundColor: const Color(0xFFD9D9D9),
                              child: Image.asset(IconPath.arrowLeftAlt),
                            ),
                          ),
                          Positioned(
                            left: 135,
                            top: 48,
                            child: Text(
                              "View Details",
                              style: getTextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                color: Color(0xffFFFFFF),
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 26,
                            right: 26,
                            child: Image.asset(
                              IconPath.rotatevenue,
                              width: 26,
                              height: 17,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            title,
                            style: GoogleFonts.roboto(
                              fontSize: 24,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xff333333),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Image.asset(IconPath.verify, height: 16, width: 16),
                          const Spacer(),
                          InkWell(
                            onTap: () {
                              Get.to(() => EditVenue(image: image));
                            },
                            child: Container(
                              height: screenHeight * 0.040,
                              width: screenWidth * 0.18,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6),
                                color: const Color(0xffD4AF37),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const SizedBox(width: 10),
                                  Text(
                                    'Edit',
                                    style: getTextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: const Color(0xffFFFFFF),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  const Icon(
                                    Icons.edit_outlined,
                                    color: Colors.white,
                                    size: 15,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const Icon(
                            Icons.star,
                            size: 20,
                            color: Color(0xffF0C020),
                          ),
                          const SizedBox(width: 1.5),
                          Text(rating),
                          const SizedBox(width: 5),
                          Text(
                            "(345 reviews)",
                            style: getTextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: const Color(0xffABB7C2),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          const Icon(Icons.location_on_outlined, size: 20),
                          const SizedBox(width: 5),
                          Text(
                            address,
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                          Spacer(),
                          Text(
                            guest,
                            style: getTextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xff333333),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Amenities',
                    style: getTextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 20,
                      color: const Color(0xff333333),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      CustomAmenityBox(
                        icon: Icons.wifi,
                        label: 'Wifi',
                        heights: screenHeight * 0.04,
                        widths: screenWidth * 0.18,
                      ),
                      SizedBox(width: 7),
                      CustomAmenityBox(
                        icon: Icons.wifi,
                        label: 'Parking',
                        heights: screenHeight * 0.04,
                        widths: screenWidth * 0.26,
                      ),
                      SizedBox(width: 7),
                      CustomAmenityBox(
                        icon: Icons.wifi,
                        label: 'AC',
                        heights: screenHeight * 0.04,
                        widths: screenWidth * 0.19,
                      ),
                      SizedBox(width: 7),
                      CustomAmenityBox(
                        icon: Icons.wifi,
                        label: 'Pool',
                        heights: screenHeight * 0.04,
                        widths: screenWidth * 0.20,
                      ),
                    ],
                  ),
                  const SizedBox(height: 40),
                  RevenueCard(),
                  const SizedBox(height: 40),
                  Center(
                    child: Text(
                      'Availability',
                      style: getTextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 20,
                        color: const Color(0xff333333),
                      ),
                    ),
                  ),
                  SizedBox(height: 16),

                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: CustomCalendar(
                      selectedDatesNotifier: selectedDatesNotifier,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      StatusLabel(color: Color(0xff0066CC), label: 'Booked'),
                      SizedBox(height: 8),
                      StatusLabel(color: Color(0xff19480B), label: 'Selected'),
                    ],
                  ),
                  const SizedBox(height: 24),

                  DatePriceCard(
                    selectedDatesNotifier: selectedDatesNotifier,
                    priceController: priceCOntroller,
                    screenHeight: screenHeight,
                    screenWidth: screenWidth,
                  ),
                  SizedBox(height: 40),
                  Text(
                    "Decoration",
                    style: getTextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: Color(0xff333333),
                    ),
                  ),
                  SizedBox(height: 16),
                  SizedBox(
                    height: screenHeight * 0.249,
                    width: double.infinity,
                    child: Image.asset(ImagePath.venueview, fit: BoxFit.cover),
                  ),
                  SizedBox(height: 40),
                  Text(
                    'Table Shape',
                    style: getTextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Color(0xff333333),
                    ),
                  ),
                  SizedBox(height: 16),
                  Row(
                    children: [
                      CustomShapeTag(
                        label: "Round",
                        height: screenHeight * 0.04,
                        width: screenWidth * 0.15,
                      ),
                      CustomShapeTag(
                        label: "Oval",
                        height: screenHeight * 0.04,
                        width: screenWidth * 0.15,
                      ),
                      CustomShapeTag(
                        label: "Hexagonal",
                        height: screenHeight * 0.04,
                        width: screenWidth * 0.22,
                      ),
                      CustomShapeTag(
                        label: "Square",
                        height: screenHeight * 0.04,
                        width: screenWidth * 0.20,
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Seating Style',
                    style: getTextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Color(0xff333333),
                    ),
                  ),
                  SizedBox(height: 16),
                  Row(
                    children: [
                      CustomShapeTag(
                        label: "Round",
                        height: screenHeight * 0.04,
                        width: screenWidth * 0.15,
                      ),
                      CustomShapeTag(
                        label: "Oval",
                        height: screenHeight * 0.04,
                        width: screenWidth * 0.15,
                      ),
                      CustomShapeTag(
                        label: "Hexagonal",
                        height: screenHeight * 0.04,
                        width: screenWidth * 0.22,
                      ),
                      CustomShapeTag(
                        label: "Square",
                        height: screenHeight * 0.04,
                        width: screenWidth * 0.20,
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Lighting Style',
                    style: getTextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Color(0xff333333),
                    ),
                  ),
                  SizedBox(height: 16),
                  Row(
                    children: [
                      CustomShapeTag(
                        label: "Round",
                        height: screenHeight * 0.04,
                        width: screenWidth * 0.15,
                      ),
                      CustomShapeTag(
                        label: "Oval",
                        height: screenHeight * 0.04,
                        width: screenWidth * 0.15,
                      ),
                      CustomShapeTag(
                        label: "Hexagonal",
                        height: screenHeight * 0.04,
                        width: screenWidth * 0.22,
                      ),
                      CustomShapeTag(
                        label: "Square",
                        height: screenHeight * 0.04,
                        width: screenWidth * 0.20,
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Flower Color',
                    style: getTextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Color(0xff333333),
                    ),
                  ),
                  SizedBox(height: 16),
                  Row(
                    children: [
                      CustomShapeTag(
                        label: "Round",
                        height: screenHeight * 0.04,
                        width: screenWidth * 0.15,
                      ),
                      CustomShapeTag(
                        label: "Oval",
                        height: screenHeight * 0.04,
                        width: screenWidth * 0.15,
                      ),
                      CustomShapeTag(
                        label: "Hexagonal",
                        height: screenHeight * 0.04,
                        width: screenWidth * 0.22,
                      ),
                      CustomShapeTag(
                        label: "Square",
                        height: screenHeight * 0.04,
                        width: screenWidth * 0.20,
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Flower Type',
                    style: getTextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Color(0xff333333),
                    ),
                  ),
                  SizedBox(height: 16),
                  Row(
                    children: [
                      CustomShapeTag(
                        label: "Round",
                        height: screenHeight * 0.04,
                        width: screenWidth * 0.15,
                      ),
                      CustomShapeTag(
                        label: "Oval",
                        height: screenHeight * 0.04,
                        width: screenWidth * 0.15,
                      ),
                      CustomShapeTag(
                        label: "Hexagonal",
                        height: screenHeight * 0.04,
                        width: screenWidth * 0.22,
                      ),
                      CustomShapeTag(
                        label: "Square",
                        height: screenHeight * 0.04,
                        width: screenWidth * 0.20,
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Text(
                    '  Fragrance',
                    style: getTextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Color(0xff333333),
                    ),
                  ),
                  SizedBox(height: 16),
                  Row(
                    children: [
                      CustomShapeTag(
                        label: "Round",
                        height: screenHeight * 0.04,
                        width: screenWidth * 0.15,
                      ),
                      CustomShapeTag(
                        label: "Oval",
                        height: screenHeight * 0.04,
                        width: screenWidth * 0.15,
                      ),
                      CustomShapeTag(
                        label: "Hexagonal",
                        height: screenHeight * 0.04,
                        width: screenWidth * 0.22,
                      ),
                      CustomShapeTag(
                        label: "Square",
                        height: screenHeight * 0.04,
                        width: screenWidth * 0.20,
                      ),
                    ],
                  ),
                  SizedBox(height: 40),
                  Text(
                    'Booking Requests',
                    style: getTextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: Color(0xff333333),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Spacer(),
                        InkWell(
                          onTap: () {},
                          child: Text(
                            'Explore All',
                            style: getTextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              color: Color(0xff444444),
                            ),
                          ),
                        ),
                        Icon(Icons.arrow_right_alt),
                      ],
                    ),
                  ),
                  NewWidget(),
                  SizedBox(height: 30),
                  Text(
                    'Recent Views',
                    style: getTextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: Color(0xff333333),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: Row(
                      children: [
                        Spacer(),
                        InkWell(
                          onTap: () {},
                          child: Text(
                            'Explore All',
                            style: getTextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 14,///hghghg
                              color: Color(0xff444444),
                            ),
                          ),
                        ),
                        Icon(Icons.arrow_right_alt),
                      ],
                    ),
                  ),

                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: seereview.length,
                    itemBuilder: (context, index) {
                      final review = seereview[index];
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ReviewCard(
                          image: review["image"]!,
                          title: review["title"]!,
                          time: review["time"]!,
                          desc: review["desc"]!,
                          rating: 5,
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
