import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:blinqo/core/utils/constants/image_path.dart';
import 'package:blinqo/features/role/venue_owner/myvenue/controller/venue_details_controller.dart';
import 'package:blinqo/features/role/venue_owner/myvenue/screen/booking_requests.dart';
import 'package:blinqo/features/role/venue_owner/myvenue/screen/edit_venue.dart';
import 'package:blinqo/features/role/venue_owner/myvenue/widget/booking_request.dart';
import 'package:blinqo/features/role/venue_owner/overview/screen/all_reviews.dart';
import 'package:blinqo/features/role/venue_owner/overview/widgets/revenue_card.dart';
import 'package:blinqo/features/role/venue_owner/profile_page/controller/venue_owner_profile_controller.dart';
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
  const VenueDetailsScreen({super.key});

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
      'December',
    ];
    return months[month - 1];
  }

  @override
  Widget build(BuildContext context) {
    final VenueDetailsController venueDetailsController = Get.put(
      VenueDetailsController(),
    );
    final bool isDarkMode =
        Get.put(VenueOwnerProfileController()).isDarkMode.value;
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
    TextEditingController priceController = TextEditingController();
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
      backgroundColor:
          isDarkMode ? const Color(0xff151515) : AppColors.backgroundColor,
      body: Obx(() {
        final venueData = venueDetailsController.response.value;
        if (venueData == null) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [const SizedBox(height: 16)],
            ),
          );
        }

        return SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          const Color(0xff000000).withValues(alpha: 0.6),
                          const Color(0xff161616),
                        ],
                      ),
                    ),
                    child: Image.network(
                      venueData.venueImage?.path ?? ImagePath.venueview,
                      width: double.infinity,
                      height: screenHeight * 0.4,
                      fit: BoxFit.cover,
                      errorBuilder:
                          (context, error, stackTrace) => Image.asset(
                            ImagePath.venueview,
                            width: double.infinity,
                            height: screenHeight * 0.4,
                            fit: BoxFit.cover,
                          ),
                    ),
                  ),
                  Positioned.fill(
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: [
                            const Color(0xff161616),
                            const Color(0xff000000).withOpacity(.1),
                          ],
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Stack(
                          children: [
                            Positioned(
                              left: 20,
                              top: 40,
                              child: GestureDetector(
                                onTap: () {
                                  Get.back();
                                },
                                child: CircleAvatar(
                                  radius: 20,
                                  backgroundColor:
                                      isDarkMode
                                          ? const Color(
                                            0xFFD9D9D9,
                                          ).withValues(alpha: .1)
                                          : const Color(
                                            0xFFD9D9D9,
                                          ).withValues(alpha: .1),
                                  child: Image.asset(
                                    IconPath.arrowLeftAlt,
                                    width: 16,
                                    height: 16,
                                    color: isDarkMode ? Colors.white : null,
                                  ),
                                ),
                              ),
                            ),
                            const Positioned(
                              left: 110,
                              top: 48,
                              child: Text(
                                "Venue Details",
                                style: TextStyle(
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
                    Row(
                      children: [
                        Text(
                          venueData.name ?? 'Unknown Venue',
                          style: GoogleFonts.roboto(
                            fontSize: 24,
                            fontWeight: FontWeight.w600,
                            color:
                                isDarkMode
                                    ? const Color(0xffEBEBEB)
                                    : const Color(0xff333333),
                          ),
                        ),
                        const SizedBox(width: 8),
                        // Image.asset(
                        //   venueData.verified == true
                        //       ? IconPath.verify
                        //       : , // Assumes unverified icon exists
                        //   height: 16,
                        //   width: 16,
                        // ),
                        const Spacer(),
                        InkWell(
                          onTap: () {
                            Get.to(
                              () => EditVenue(
                                image:
                                    venueData.venueImage?.path ??
                                    ImagePath.venueview,
                              ),
                            );
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
                        Text(
                          '4.5', // Placeholder, as rating isn't in VenueData
                          style: getTextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color:
                                isDarkMode
                                    ? const Color(0xffEBEBEB)
                                    : const Color(0xff333333),
                          ),
                        ),
                        const SizedBox(width: 5),
                        Text(
                          "(345 reviews)",
                          style: getTextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color:
                                isDarkMode
                                    ? const Color(0xffABB7C2)
                                    : const Color(0xffABB7C2),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        const Icon(
                          Icons.location_on_outlined,
                          size: 20,
                          color: Color(0xff003366),
                        ),
                        const SizedBox(width: 5),
                        Expanded(
                          child: Text(
                            '${venueData.city ?? ''}, ${venueData.area ?? ''}',
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                              color:
                                  isDarkMode
                                      ? const Color(0xffEBEBEB)
                                      : const Color(0xff333333),
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const Spacer(),
                        Text(
                          '${venueData.capacity ?? 0} Guests',
                          style: getTextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color:
                                isDarkMode
                                    ? const Color(0xffEBEBEB)
                                    : const Color(0xff333333),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Amenities',
                      style: getTextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                        color:
                            isDarkMode
                                ? const Color(0xffEBEBEB)
                                : const Color(0xff333333),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Wrap(
                      spacing: 7, // Horizontal spacing between items
                      runSpacing: 7, // Vertical spacing between lines
                      children:
                          venueData.amenities?.asMap().entries.map((entry) {
                            final amenity = entry.value;
                            return CustomAmenityBox(
                              icon: Icons.check_circle_outline,
                              label: amenity.name ?? 'Unknown',
                            );
                          }).toList() ??
                          [
                            CustomAmenityBox(
                              icon: Icons.wifi,
                              label: 'No Amenities',
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
                          color:
                              isDarkMode
                                  ? const Color(0xffEBEBEB)
                                  : const Color(0xff333333),
                        ),
                      ),
                    ),
                    const SizedBox(height: 14),
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color:
                            isDarkMode ? const Color(0xff32383D) : Colors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: CustomCalendar(
                        selectedDatesNotifier: selectedDatesNotifier,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        StatusLabel(
                          color:
                              isDarkMode
                                  ? const Color(0xff0066CC)
                                  : const Color(0xff0066CC),
                          label: 'Booked',
                        ),
                        const SizedBox(height: 8),
                        StatusLabel(
                          color:
                              isDarkMode
                                  ? const Color(0xff34C759)
                                  : const Color(0xff19480B),
                          label: 'Selected',
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    DatePriceCard(
                      selectedDatesNotifier: selectedDatesNotifier,
                      priceController: priceController,
                      screenHeight: screenHeight,
                      screenWidth: screenWidth,
                    ),
                    const SizedBox(height: 40),
                    Text(
                      "Decoration",
                      style: getTextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color:
                            isDarkMode
                                ? const Color(0xffEBEBEB)
                                : const Color(0xff333333),
                      ),
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      height: screenHeight * 0.249,
                      width: double.infinity,
                      child: Image.network(
                        venueData.arrangementsImage?.path ??
                            ImagePath.venueview,
                        fit: BoxFit.cover,
                        errorBuilder:
                            (context, error, stackTrace) => Image.asset(
                              ImagePath.venueview,
                              fit: BoxFit.cover,
                            ),
                      ),
                    ),
                    const SizedBox(height: 40),
                    Text(
                      'Table Shape',
                      style: getTextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color:
                            isDarkMode
                                ? const Color(0xffEBEBEB)
                                : const Color(0xff333333),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Wrap(
                      spacing: 7, // Horizontal spacing between items
                      runSpacing: 7, // Vertical spacing between lines
                      children:
                          venueData.decoration?.tableShapes.asMap().entries.map(
                            (entry) {
                              final shape = entry.value;
                              return CustomShapeTag(label: shape);
                            },
                          ).toList() ??
                          [CustomShapeTag(label: "None")],
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Seating Style',
                      style: getTextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color:
                            isDarkMode
                                ? const Color(0xffEBEBEB)
                                : const Color(0xff333333),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Wrap(
                      spacing: 7, // Horizontal spacing between items
                      runSpacing: 7, // Vertical spacing between lines
                      children:
                          venueData.decoration?.seatingStyles
                              .asMap()
                              .entries
                              .map((entry) {
                                final style = entry.value;
                                return CustomShapeTag(label: style);
                              })
                              .toList() ??
                          [CustomShapeTag(label: "None")],
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Lighting Style',
                      style: getTextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color:
                            isDarkMode
                                ? const Color(0xffEBEBEB)
                                : const Color(0xff333333),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Wrap(
                      spacing: 7, // Horizontal spacing between items
                      runSpacing: 7, // Vertical spacing between lines
                      children:
                          venueData.decoration?.lighting.asMap().entries.map((
                            entry,
                          ) {
                            final lighting = entry.value;
                            return CustomShapeTag(label: lighting);
                          }).toList() ??
                          [CustomShapeTag(label: "None")],
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Flower Color',
                      style: getTextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color:
                            isDarkMode
                                ? const Color(0xffEBEBEB)
                                : const Color(0xff333333),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Wrap(
                      spacing: 7, // Horizontal spacing between items
                      runSpacing: 7, // Vertical spacing between lines
                      children:
                          venueData.decoration?.flowerColors
                              .asMap()
                              .entries
                              .map((entry) {
                                final color = entry.value;
                                return CustomShapeTag(label: color);
                              })
                              .toList() ??
                          [CustomShapeTag(label: "None")],
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Flower Type',
                      style: getTextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color:
                            isDarkMode
                                ? const Color(0xffEBEBEB)
                                : const Color(0xff333333),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Wrap(
                      spacing: 7, // Horizontal spacing between items
                      runSpacing: 7, // Vertical spacing between lines
                      children:
                          venueData.decoration?.flowerTypes.asMap().entries.map(
                            (entry) {
                              final type = entry.value;
                              return CustomShapeTag(label: type);
                            },
                          ).toList() ??
                          [CustomShapeTag(label: "None")],
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Fragrance',
                      style: getTextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color:
                            isDarkMode
                                ? const Color(0xffEBEBEB)
                                : const Color(0xff333333),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Wrap(
                      spacing: 7, // Horizontal spacing between items
                      runSpacing: 7, // Vertical spacing between lines
                      children:
                          venueData.decoration?.fragrances.asMap().entries.map((
                            entry,
                          ) {
                            final fragrance = entry.value;
                            return CustomShapeTag(label: fragrance);
                          }).toList() ??
                          [CustomShapeTag(label: "None")],
                    ),
                    const SizedBox(height: 30),
                    Text(
                      'Booking Requests',
                      style: getTextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color:
                            isDarkMode
                                ? const Color(0xffEBEBEB)
                                : const Color(0xff333333),
                      ),
                    ),
                    Row(
                      children: [
                        const Spacer(),
                        InkWell(
                          onTap: () {
                            Get.to(() => AllBookingRequests());
                          },
                          child: Text(
                            'Explore All',
                            style: getTextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              color:
                                  isDarkMode
                                      ? const Color(0xffEBEBEB)
                                      : const Color(0xff444444),
                            ),
                          ),
                        ),
                        const Icon(Icons.arrow_right_alt),
                      ],
                    ),
                    BookingRequest(),
                    const SizedBox(height: 8),
                    Text(
                      'Recent Reviews',
                      style: getTextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color:
                            isDarkMode
                                ? const Color(0xffEBEBEB)
                                : const Color(0xff333333),
                      ),
                    ),
                    Row(
                      children: [
                        const Spacer(),
                        InkWell(
                          onTap: () {
                            Get.to(() => const AllReviewsScreen());
                          },
                          child: Text(
                            'Explore All',
                            style: getTextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              color:
                                  isDarkMode
                                      ? const Color(0xffEBEBEB)
                                      : const Color(0xff444444),
                            ),
                          ),
                        ),
                        Icon(
                          Icons.arrow_right_alt,
                          size: 16,
                          color:
                              isDarkMode
                                  ? const Color(0xffEBEBEB)
                                  : const Color(0xff444444),
                        ),
                      ],
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: seereview.length,
                      itemBuilder: (context, index) {
                        final review = seereview[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
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
        );
      }),
    );
  }
}
