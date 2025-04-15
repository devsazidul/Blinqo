import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:blinqo/features/role/venue_owner/venue_booking_page/controllers/booking_controller.dart';
import 'package:blinqo/features/role/venue_owner/venue_booking_page/widgets/booking_section.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'no_bookings_view.dart';


class VenueBookingPage extends StatelessWidget {
  static const String name = '/venue_booking_page';
  const VenueBookingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final BookingController controller = Get.put(BookingController());
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: _buildAppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildBody(controller, screenWidth),
          ],
        ),
      ),

    );
  }

  /// Builds the AppBar with the title and transparent background.
  AppBar _buildAppBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      forceMaterialTransparency: true,
      centerTitle: true,
      title: Text(
        'Booking',
        style: getTextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w600,
          color: const Color(0xFF333333),
        ),
      ),
      elevation: 0,
      backgroundColor: AppColors.backgroundColor,
    );
  }

  /// Builds the header with the "Booking List" title and "Sort by" dropdown.
  Widget _buildHeader(BookingController controller) {
    return Padding(
      padding: const EdgeInsets.only(top: 36),
      child: Row(
        children: [
          const Spacer(),
          Container(
            height: 40,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              color: AppColors.backgroundColor,
              border: Border.all(
                color: const Color(0xFF003366),
                width: 1,
              ),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Obx(() {
              final isEmpty = controller.sortBy.value.isEmpty;

              return DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  borderRadius: BorderRadius.circular(4),
                  value: isEmpty ? null : controller.sortBy.value,
                  isExpanded: false,
                  alignment: Alignment.centerLeft,
                  icon: const Icon(Icons.keyboard_arrow_down, color: Color(0xFF003366)),
                  hint: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.sort, color: Color(0xFF003366), size: 16),
                      const SizedBox(width: 4),
                      Text(
                        'Sort By',
                        style: getTextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: const Color(0xFF003366),
                        ),
                      ),
                    ],
                  ),
                  selectedItemBuilder: (context) {
                    return ['By Venue', 'By Date'].map((value) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 4),
                        child: Text(
                          value,
                          style: getTextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: const Color(0xFF003366),
                          ),
                        ),
                      );
                    }).toList();
                  },
                  items: ['By Venue', 'By Date'].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 4),
                        child: Text(
                          value,
                          style: getTextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: const Color(0xFF003366),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                  onChanged: (value) {
                    if (value != null) {
                      controller.setSortBy(value);
                    }
                  },
                  // Add this property to set the dropdown menu's background color
                  dropdownColor: Colors.white,
                ),
              );
            }),
          )
        ],
      ),
    );
  }


  Widget _buildBody(BookingController controller, double screenWidth) {
    return Obx(() {
      if (controller.bookings.isEmpty) {
        return NoBookingsView();
      } else {
        return Expanded(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if(controller.bookings.isNotEmpty)
                  _buildHeader(controller),
                const SizedBox(height: 24),
                BookingSection(
                  title: 'Booking Requests',
                  bookings: controller.getBookingsByStatus('Booking Requests'),
                  controller: controller,
                ),
                BookingSection(
                  title: 'In Progress',
                  bookings: controller.getBookingsByStatus('In Progress'),
                  controller: controller,
                ),
                BookingSection(
                  title: 'Completed',
                  bookings: controller.getBookingsByStatus('Completed'),
                  controller: controller,
                ),
                const SizedBox(height: 56),
              ],
            ),
          ),
        );
      }
    });
  }
}
