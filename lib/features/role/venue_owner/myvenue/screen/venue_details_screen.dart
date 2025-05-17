import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:blinqo/core/utils/constants/icon_path.dart';
import 'package:blinqo/core/utils/constants/image_path.dart';
import 'package:blinqo/features/role/venue_owner/myvenue/controller/venue_details_controller.dart';
import 'package:blinqo/features/role/venue_owner/myvenue/widget/booking_request.dart';
import 'package:blinqo/features/role/venue_owner/myvenue/widget/custom_amenity.dart';
import 'package:blinqo/features/role/venue_owner/myvenue/widget/custom_calendar.dart';
import 'package:blinqo/features/role/venue_owner/myvenue/widget/custom_shape.dart';
import 'package:blinqo/features/role/venue_owner/myvenue/widget/review_card.dart';
import 'package:blinqo/features/role/venue_owner/myvenue/widget/status_label.dart';
import 'package:blinqo/features/role/venue_owner/overview/widgets/revenue_card.dart';
import 'package:blinqo/features/role/venue_owner/profile_page/controller/venue_owner_profile_controller.dart';
import 'package:blinqo/features/role/venue_owner/profile_page/screen/venue_setup_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

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
    // ignore: unused_local_variable
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
        final venueDetails = venueDetailsController.response.value;
        if (venueDetails == null) {
          return const Center(child: CircularProgressIndicator());
        }
        final venueData = venueDetails.data?.venue;
        // ignore: unused_local_variable
        final venueId = venueDetails.data?.venue?.id;
        final venueMetrics = venueDetails.data?.venueMetrics;
        final bookedDates = venueDetails.data?.bookedDate ?? [];
        final bookingRequests = venueDetails.data?.bookingRequest ?? [];
        final reviews = venueData?.reviews ?? [];
        final rating = venueDetails.data?.ratting ?? 0.0;

        if (venueData == null) {
          return const Center(child: Text('No venue data available'));
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
                    child: CachedNetworkImage(
                      imageUrl:
                          venueData.venueImage?.path ?? ImagePath.venueview,
                      width: double.infinity,
                      height: screenHeight * 0.35,
                      fit: BoxFit.cover,
                      errorWidget:
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
                          begin: Alignment(0.50, -0.00),
                          end: Alignment(0.50, 1.00),
                          colors: [
                            Colors.black.withValues(alpha: 0),
                            const Color(0xFF161616),
                          ],
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Stack(
                          children: [
                            Positioned(
                              left: screenWidth * 0.05,
                              top: screenHeight * 0.05,
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
                            Positioned(
                              left: screenWidth * 0.28,
                              top: screenHeight * 0.06,
                              child: const Text(
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
                        Expanded(
                          child: Text(
                            venueData.name ?? 'Unknown Venue',
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.roboto(
                              fontSize: 24,
                              fontWeight: FontWeight.w600,
                              color:
                                  isDarkMode
                                      ? const Color(0xffEBEBEB)
                                      : const Color(0xff333333),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        if (venueData.verified == true)
                          Image.asset(IconPath.verify, height: 16, width: 16),
                        const SizedBox(width: 8),
                        InkWell(
                          onTap: () {
                            Get.to(
                              () => VenueSetupScreen(
                                venueStatus: 'Update Venue',
                                isEdit: true,
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
                          rating.toStringAsFixed(1),
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
                          "(${reviews.length} reviews)",
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
                       Image.asset(IconPath.locationOn, height: 16, width: 16),
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
                      spacing: 7,
                      runSpacing: 7,
                      children:
                          venueData.amenities.isNotEmpty
                              ? venueData.amenities.map((amenity) {
                                return CustomAmenityBox(
                                  icon: Icons.check_circle_outline,
                                  label: amenity.name ?? 'Unknown',
                                );
                              }).toList()
                              : [
                                CustomAmenityBox(
                                  icon: Icons.wifi,
                                  label: 'No Amenities',
                                ),
                              ],
                    ),
                    const SizedBox(height: 40),
                    RevenueCard(
                      totalRevenue: venueMetrics?.totalRevenue ?? 0,
                      currentMonthRevenue:
                          venueMetrics?.currentMonthRevenue ?? 0,
                      growthRate: venueMetrics?.growthRate ?? 0,
                      pendingBookings: venueMetrics?.pendingBookings ?? 0,
                    ),
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
                        bookedDates: bookedDates,
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

                    // Date Price Card
                    // const SizedBox(height: 24),
                    // DatePriceCard(
                    //   selectedDatesNotifier: selectedDatesNotifier,
                    //   priceController: priceController,
                    //   screenHeight: screenHeight,
                    //   screenWidth: screenWidth,
                    //   price: venueData.price ?? 0,
                    // ),
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
                      child: CachedNetworkImage(
                        imageUrl:
                            venueData.arrangementsImage?.path ??
                            ImagePath.venueview,
                        fit: BoxFit.cover,
                        errorWidget:
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
                      spacing: 7,
                      runSpacing: 7,
                      children:
                          venueData.decoration?.tableShapes.isNotEmpty ?? false
                              ? venueData.decoration!.tableShapes.map((shape) {
                                return CustomShapeTag(label: shape);
                              }).toList()
                              : [CustomShapeTag(label: "None")],
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
                      spacing: 7,
                      runSpacing: 7,
                      children:
                          venueData.decoration?.seatingStyles.isNotEmpty ??
                                  false
                              ? venueData.decoration!.seatingStyles.map((
                                style,
                              ) {
                                return CustomShapeTag(label: style);
                              }).toList()
                              : [CustomShapeTag(label: "None")],
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
                      spacing: 7,
                      runSpacing: 7,
                      children:
                          venueData.decoration?.lighting.isNotEmpty ?? false
                              ? venueData.decoration!.lighting.map((lighting) {
                                return CustomShapeTag(label: lighting);
                              }).toList()
                              : [CustomShapeTag(label: "None")],
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
                      spacing: 7,
                      runSpacing: 7,
                      children:
                          venueData.decoration?.flowerColors.isNotEmpty ?? false
                              ? venueData.decoration!.flowerColors.map((color) {
                                return CustomShapeTag(label: color);
                              }).toList()
                              : [CustomShapeTag(label: "None")],
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
                      spacing: 7,
                      runSpacing: 7,
                      children:
                          venueData.decoration?.flowerTypes.isNotEmpty ?? false
                              ? venueData.decoration!.flowerTypes.map((type) {
                                return CustomShapeTag(label: type);
                              }).toList()
                              : [CustomShapeTag(label: "None")],
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
                      spacing: 7,
                      runSpacing: 7,
                      children:
                          venueData.decoration?.fragrances.isNotEmpty ?? false
                              ? venueData.decoration!.fragrances.map((
                                fragrance,
                              ) {
                                return CustomShapeTag(label: fragrance);
                              }).toList()
                              : [CustomShapeTag(label: "None")],
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
                            // Get.to(() => AllBookingRequests());
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
                    bookingRequests.isNotEmpty
                        ? ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount:
                              bookingRequests.length > 3
                                  ? 3
                                  : bookingRequests.length,
                          itemBuilder: (context, index) {
                            final request = bookingRequests[index];
                            return BookingRequest(
                              eventName: request.eventName ?? 'Unknown Event',
                              selectedDate: request.selectedDate,
                              guestNumber: request.guestNumber ?? 0,
                              bookingStatus: request.bookingStatus ?? 'Pending',
                              
                              venueName: request.plannerName ?? 'Unknown Venue',
                            );
                          },
                        )
                        : const Text('No booking requests available'),
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
                            // Get.to(() => const AllReviewsScreen());
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
                    reviews.isNotEmpty
                        ? ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: reviews.length > 2 ? 2 : reviews.length,
                          itemBuilder: (context, index) {
                            final review = reviews[index];
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: ReviewCard(
                                image:
                                    review.profile?.image?.path ??
                                    ImagePath.reviewer1,
                                title: review.profile?.name ?? 'Anonymous',
                                time:
                                    review.createdAt != null
                                        ? '${review.createdAt!.day} ${getMonthName(review.createdAt!.month)} ${review.createdAt!.year}'
                                        : 'Unknown',
                                desc: review.comment ?? 'No comment',
                                rating: (review.rating ?? 0).toInt(),
                              ),
                            );
                          },
                        )
                        : const Text('No reviews available'),
                    const SizedBox(height: 40),
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
