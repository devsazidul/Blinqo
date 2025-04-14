import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:blinqo/core/utils/constants/image_path.dart';
import 'package:blinqo/features/role/venue_owner/myvenue/screen/edit_venue.dart';
import 'package:blinqo/features/role/venue_owner/overview/widgets/NewWidget.dart';
import 'package:blinqo/features/role/venue_owner/overview/widgets/revenue_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
import 'package:get/get.dart';

import '../../../../../core/utils/constants/icon_path.dart';

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

  String _getMonthName(int month) {
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
    List<Map<String, String>> reviews = [
      {
        "title": "Corporate Event",
        "subtitle": "Conference Hall",
        "date": "15 March,2025",
        "time": "3.00 PM",
        "image": ImagePath.event,
        "status": "Confirmed",
      },
      {
        "title": "Team Building Retreat",
        "subtitle": "Lakeside Lodge",
        "date": "22 April,2025",
        "time": "10.00 AM",
        "image": ImagePath.event2,
        "status": "Pending",
      },
      {
        "title": "Product Launch",
        "subtitle": "Main Auditorium",
        "date": "30 May,2025",
        "time": "1:00 PM",
        "image": ImagePath.event3,
        "status": "Confirmed",
      },
    ];
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
                    child: Stack(
                      children: [
                        Positioned(
                          left: 24,
                          top: 24,
                          child: CircleAvatar(
                            radius: 20,
                            backgroundColor: const Color(0xFFD9D9D9),
                            child: Image.asset(IconPath.arrowLeftAlt),
                          ),
                        ),
                        Positioned(
                          left: 135,
                          top: 30,
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
              ],
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        title,
                        style: getTextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w400,
                          color: const Color(0xff333333),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Image.asset(IconPath.verify, height: 16, width: 16),
                      const Spacer(),
                      InkWell(
                        onTap: () {
                          Get.to(() => EditVenue(image: image));
                        },
                        child: Container(
                          height: 27,
                          width: 76,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            color: const Color(0xffD4AF37),
                          ),
                          child: Row(
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
                                Icons.edit,
                                color: Colors.white,
                                size: 15,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
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
                        style: getTextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                      const Spacer(),
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
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: screenHeight * 0.03,
                          width: screenWidth * 0.15,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            border: Border.all(
                              width: 1,
                              color: Color(0xffC0C0C0),
                            ),
                          ),
                          child: Row(
                            children: [
                              SizedBox(width: 5),
                              Icon(
                                Icons.wifi,
                                size: 14,
                                color: Color(0xffD4AF37),
                              ),
                              SizedBox(width: 8),
                              Text(
                                'Wifi',
                                style: getTextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xff333333),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: screenHeight * 0.03,
                          width: screenWidth * 0.22,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            border: Border.all(
                              width: 1,
                              color: Color(0xffC0C0C0),
                            ),
                          ),
                          child: Row(
                            children: [
                              SizedBox(width: 5),
                              Icon(
                                Icons.wifi,
                                size: 14,
                                color: Color(0xffD4AF37),
                              ),
                              SizedBox(width: 8),
                              Text(
                                'Parking',
                                style: getTextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xff333333),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: screenHeight * 0.03,
                          width: screenWidth * 0.15,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            border: Border.all(
                              width: 1,
                              color: Color(0xffC0C0C0),
                            ),
                          ),
                          child: Row(
                            children: [
                              SizedBox(width: 5),
                              Icon(
                                Icons.wifi,
                                size: 14,
                                color: Color(0xffD4AF37),
                              ),
                              SizedBox(width: 8),
                              Text(
                                'AC',
                                style: getTextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xff333333),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: screenHeight * 0.03,
                          width: screenWidth * 0.15,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            border: Border.all(
                              width: 1,
                              color: Color(0xffC0C0C0),
                            ),
                          ),
                          child: Row(
                            children: [
                              SizedBox(width: 5),
                              Icon(
                                Icons.wifi,
                                size: 14,
                                color: Color(0xffD4AF37),
                              ),
                              SizedBox(width: 8),
                              Text(
                                'Pool',
                                style: getTextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xff333333),
                                ),
                              ),
                            ],
                          ),
                        ),
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

                  SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.all(20),
                    height: screenHeight * 0.400,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ValueListenableBuilder<List<DateTime>>(
                      valueListenable: selectedDatesNotifier,
                      builder: (context, selectedDates, _) {
                        return Column(
                          children: [
                            CalendarCarousel(
                              onDayPressed: (date, events) {
                                if (selectedDates.isEmpty) {
                                  selectedDatesNotifier.value = [date];
                                } else if (selectedDates.contains(date)) {
                                  selectedDatesNotifier.value =
                                      selectedDates
                                          .where((d) => d != date)
                                          .toList();
                                } else {
                                  selectedDatesNotifier.value = List.from(
                                    selectedDates,
                                  )..add(date);
                                }
                              },
                              markedDatesMap: EventList(
                                events: {
                                  for (var date in selectedDates)
                                    date: [Event(date: date)],
                                },
                              ),
                              markedDateShowIcon: true,
                              markedDateIconBuilder: (event) {
                                if (selectedDates.indexOf(event.date) == 0) {
                                  return Container(
                                    decoration: const BoxDecoration(
                                      color: Color(0xff19480B),
                                      shape: BoxShape.circle,
                                    ),
                                    child: Center(
                                      child: Text(
                                        '${event.date.day}',
                                        style: const TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  );
                                } else {
                                  return Container(
                                    decoration: const BoxDecoration(
                                      color: Color(0xff0066CC),
                                      shape: BoxShape.circle,
                                    ),
                                    child: Center(
                                      child: Text(
                                        '${event.date.day}',
                                        style: const TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  );
                                }
                              },
                              todayBorderColor: Colors.transparent,
                              todayButtonColor: Colors.transparent,
                              selectedDayButtonColor: const Color(0xff0066CC),
                              selectedDayTextStyle: const TextStyle(
                                color: Colors.white,
                              ),
                              weekendTextStyle: getTextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: const Color(0xff9291A5),
                              ),
                              weekdayTextStyle: getTextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: const Color(0xff9291A5),
                              ),
                              thisMonthDayBorderColor: Colors.transparent,
                              daysHaveCircularBorder: false,
                              weekFormat: false,
                              height: 320,
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Container(
                        height: 16,
                        width: 16,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          color: const Color(0xff0066CC),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Booked',
                        style: getTextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Container(
                        height: 16,
                        width: 16,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          color: const Color(0xff19480B),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Selected',
                        style: getTextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Container(
                    height: screenHeight * 0.157,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: const Color(0xffFFFFFF),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                'Selected Date',
                                style: getTextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color: const Color(0xff333333),
                                ),
                              ),
                              const Spacer(),
                              ValueListenableBuilder<List<DateTime>>(
                                valueListenable: selectedDatesNotifier,
                                builder: (context, selectedDates, _) {
                                  if (selectedDates.isEmpty) {
                                    return Text(
                                      'No date selected',
                                      style: getTextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        color: const Color(0xff333333),
                                      ),
                                    );
                                  }

                                  final selected = selectedDates.first;
                                  final formatted =
                                      '${selected.day} ${_getMonthName(selected.month)} ${selected.year}';

                                  return Text(
                                    formatted,
                                    style: getTextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: const Color(0xff19480B),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                          SizedBox(height: 8),
                          Row(
                            children: [
                              Text(
                                'Price',
                                style: getTextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xff333333),
                                ),
                              ),
                              Spacer(),
                              Container(
                                height: screenHeight * 0.036,
                                width: screenWidth * 0.2,

                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    width: 1,
                                    color: Color(0xffABB7C2),
                                  ),
                                ),
                                child: TextField(
                                  controller: priceCOntroller,
                                  style: getTextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 14,
                                    color: Color(0xff19480B),
                                  ),

                                  decoration: InputDecoration(
                                    labelText: 'Price',
                                    labelStyle: getTextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: Color(0xff767676),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 18),
                          Center(
                            child: Container(
                              height: screenHeight * 0.048,
                              width: screenWidth * 0.50,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  width: 1,
                                  color: Color(0xff003366),
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  'Save Changes',
                                  style: getTextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                    color: Color(0xff003366),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
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
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: screenHeight * 0.03,
                          width: screenWidth * 0.15,
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                // ignore: deprecated_member_use
                                color: Color(0xff000000).withOpacity(.6),
                                blurRadius: 10,
                                offset: Offset(0, 3),
                              ),
                            ],
                            borderRadius: BorderRadius.circular(34),
                            color: Color(0xffFFFFFF),
                          ),
                          child: Center(
                            child: Text(
                              "Round",
                              style: getTextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: Color(0xff333333),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: screenHeight * 0.03,
                          width: screenWidth * 0.15,
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                // ignore: deprecated_member_use
                                color: Color(0xff000000).withOpacity(.6),
                                blurRadius: 10,
                                offset: Offset(0, 3),
                              ),
                            ],
                            borderRadius: BorderRadius.circular(34),
                            color: Color(0xffFFFFFF),
                          ),
                          child: Center(
                            child: Text(
                              "Oval",
                              style: getTextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: Color(0xff333333),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: screenHeight * 0.03,
                          width: screenWidth * 0.22,
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                // ignore: deprecated_member_use
                                color: Color(0xff000000).withOpacity(.6),
                                blurRadius: 10,
                                offset: Offset(0, 3),
                              ),
                            ],
                            borderRadius: BorderRadius.circular(34),
                            color: Color(0xffFFFFFF),
                          ),
                          child: Center(
                            child: Text(
                              "Hexagonal",
                              style: getTextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: Color(0xff333333),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: screenHeight * 0.03,
                          width: screenWidth * 0.20,
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                // ignore: deprecated_member_use
                                color: Color(0xff000000).withOpacity(.6),
                                blurRadius: 10,
                                offset: Offset(0, 3),
                              ),
                            ],
                            borderRadius: BorderRadius.circular(34),
                            color: Color(0xffFFFFFF),
                          ),
                          child: Center(
                            child: Text(
                              "Square",
                              style: getTextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: Color(0xff333333),
                              ),
                            ),
                          ),
                        ),
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
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: screenHeight * 0.03,
                          width: screenWidth * 0.15,
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                // ignore: deprecated_member_use
                                color: Color(0xff000000).withOpacity(.6),
                                blurRadius: 10,
                                offset: Offset(0, 3),
                              ),
                            ],
                            borderRadius: BorderRadius.circular(34),
                            color: Color(0xffFFFFFF),
                          ),
                          child: Center(
                            child: Text(
                              "Round",
                              style: getTextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: Color(0xff333333),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: screenHeight * 0.03,
                          width: screenWidth * 0.15,
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                // ignore: deprecated_member_use
                                color: Color(0xff000000).withOpacity(.6),
                                blurRadius: 10,
                                offset: Offset(0, 3),
                              ),
                            ],
                            borderRadius: BorderRadius.circular(34),
                            color: Color(0xffFFFFFF),
                          ),
                          child: Center(
                            child: Text(
                              "Oval",
                              style: getTextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: Color(0xff333333),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: screenHeight * 0.03,
                          width: screenWidth * 0.22,
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                // ignore: deprecated_member_use
                                color: Color(0xff000000).withOpacity(.6),
                                blurRadius: 10,
                                offset: Offset(0, 3),
                              ),
                            ],
                            borderRadius: BorderRadius.circular(34),
                            color: Color(0xffFFFFFF),
                          ),
                          child: Center(
                            child: Text(
                              "Hexagonal",
                              style: getTextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: Color(0xff333333),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: screenHeight * 0.03,
                          width: screenWidth * 0.20,
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                // ignore: deprecated_member_use
                                color: Color(0xff000000).withOpacity(.6),
                                blurRadius: 10,
                                offset: Offset(0, 3),
                              ),
                            ],
                            borderRadius: BorderRadius.circular(34),
                            color: Color(0xffFFFFFF),
                          ),
                          child: Center(
                            child: Text(
                              "Square",
                              style: getTextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: Color(0xff333333),
                              ),
                            ),
                          ),
                        ),
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
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: screenHeight * 0.03,
                          width: screenWidth * 0.15,
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                // ignore: deprecated_member_use
                                color: Color(0xff000000).withOpacity(.6),
                                blurRadius: 10,
                                offset: Offset(0, 3),
                              ),
                            ],
                            borderRadius: BorderRadius.circular(34),
                            color: Color(0xffFFFFFF),
                          ),
                          child: Center(
                            child: Text(
                              "Round",
                              style: getTextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: Color(0xff333333),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: screenHeight * 0.03,
                          width: screenWidth * 0.15,
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                // ignore: deprecated_member_use
                                color: Color(0xff000000).withOpacity(.6),
                                blurRadius: 10,
                                offset: Offset(0, 3),
                              ),
                            ],
                            borderRadius: BorderRadius.circular(34),
                            color: Color(0xffFFFFFF),
                          ),
                          child: Center(
                            child: Text(
                              "Oval",
                              style: getTextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: Color(0xff333333),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: screenHeight * 0.03,
                          width: screenWidth * 0.22,
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Color(0xff000000).withOpacity(.6),
                                blurRadius: 10,
                                offset: Offset(0, 3),
                              ),
                            ],
                            borderRadius: BorderRadius.circular(34),
                            color: Color(0xffFFFFFF),
                          ),
                          child: Center(
                            child: Text(
                              "Hexagonal",
                              style: getTextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: Color(0xff333333),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: screenHeight * 0.03,
                          width: screenWidth * 0.20,
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Color(0xff000000).withOpacity(.6),
                                blurRadius: 10,
                                offset: Offset(0, 3),
                              ),
                            ],
                            borderRadius: BorderRadius.circular(34),
                            color: Color(0xffFFFFFF),
                          ),
                          child: Center(
                            child: Text(
                              "Square",
                              style: getTextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: Color(0xff333333),
                              ),
                            ),
                          ),
                        ),
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
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: screenHeight * 0.03,
                          width: screenWidth * 0.15,
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Color(0xff000000).withOpacity(.6),
                                blurRadius: 10,
                                offset: Offset(0, 3),
                              ),
                            ],
                            borderRadius: BorderRadius.circular(34),
                            color: Color(0xffFFFFFF),
                          ),
                          child: Center(
                            child: Text(
                              "Round",
                              style: getTextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: Color(0xff333333),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: screenHeight * 0.03,
                          width: screenWidth * 0.15,
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Color(0xff000000).withOpacity(.6),
                                blurRadius: 10,
                                offset: Offset(0, 3),
                              ),
                            ],
                            borderRadius: BorderRadius.circular(34),
                            color: Color(0xffFFFFFF),
                          ),
                          child: Center(
                            child: Text(
                              "Oval",
                              style: getTextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: Color(0xff333333),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: screenHeight * 0.03,
                          width: screenWidth * 0.22,
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Color(0xff000000).withOpacity(.6),
                                blurRadius: 10,
                                offset: Offset(0, 3),
                              ),
                            ],
                            borderRadius: BorderRadius.circular(34),
                            color: Color(0xffFFFFFF),
                          ),
                          child: Center(
                            child: Text(
                              "Hexagonal",
                              style: getTextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: Color(0xff333333),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: screenHeight * 0.03,
                          width: screenWidth * 0.20,
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Color(0xff000000).withOpacity(.6),
                                blurRadius: 10,
                                offset: Offset(0, 3),
                              ),
                            ],
                            borderRadius: BorderRadius.circular(34),
                            color: Color(0xffFFFFFF),
                          ),
                          child: Center(
                            child: Text(
                              "Square",
                              style: getTextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: Color(0xff333333),
                              ),
                            ),
                          ),
                        ),
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
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: screenHeight * 0.03,
                          width: screenWidth * 0.15,
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Color(0xff000000).withOpacity(.6),
                                blurRadius: 10,
                                offset: Offset(0, 3),
                              ),
                            ],
                            borderRadius: BorderRadius.circular(34),
                            color: Color(0xffFFFFFF),
                          ),
                          child: Center(
                            child: Text(
                              "Round",
                              style: getTextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: Color(0xff333333),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: screenHeight * 0.03,
                          width: screenWidth * 0.15,
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Color(0xff000000).withOpacity(.6),
                                blurRadius: 10,
                                offset: Offset(0, 3),
                              ),
                            ],
                            borderRadius: BorderRadius.circular(34),
                            color: Color(0xffFFFFFF),
                          ),
                          child: Center(
                            child: Text(
                              "Oval",
                              style: getTextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: Color(0xff333333),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: screenHeight * 0.03,
                          width: screenWidth * 0.22,
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Color(0xff000000).withOpacity(.6),
                                blurRadius: 10,
                                offset: Offset(0, 3),
                              ),
                            ],
                            borderRadius: BorderRadius.circular(34),
                            color: Color(0xffFFFFFF),
                          ),
                          child: Center(
                            child: Text(
                              "Hexagonal",
                              style: getTextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: Color(0xff333333),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: screenHeight * 0.03,
                          width: screenWidth * 0.20,
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Color(0xff000000).withOpacity(.6),
                                blurRadius: 10,
                                offset: Offset(0, 3),
                              ),
                            ],
                            borderRadius: BorderRadius.circular(34),
                            color: Color(0xffFFFFFF),
                          ),
                          child: Center(
                            child: Text(
                              "Square",
                              style: getTextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: Color(0xff333333),
                              ),
                            ),
                          ),
                        ),
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

                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: screenHeight * 0.03,
                          width: screenWidth * 0.15,
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Color(0xff000000).withOpacity(.6),
                                blurRadius: 10,
                                offset: Offset(0, 3),
                              ),
                            ],
                            borderRadius: BorderRadius.circular(34),
                            color: Color(0xffFFFFFF),
                          ),
                          child: Center(
                            child: Text(
                              "Round",
                              style: getTextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: Color(0xff333333),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: screenHeight * 0.03,
                          width: screenWidth * 0.15,
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Color(0xff000000).withOpacity(.6),
                                blurRadius: 10,
                                offset: Offset(0, 3),
                              ),
                            ],
                            borderRadius: BorderRadius.circular(34),
                            color: Color(0xffFFFFFF),
                          ),
                          child: Center(
                            child: Text(
                              "Oval",
                              style: getTextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: Color(0xff333333),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: screenHeight * 0.03,
                          width: screenWidth * 0.22,
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Color(0xff000000).withOpacity(.6),
                                blurRadius: 10,
                                offset: Offset(0, 3),
                              ),
                            ],
                            borderRadius: BorderRadius.circular(34),
                            color: Color(0xffFFFFFF),
                          ),
                          child: Center(
                            child: Text(
                              "Hexagonal",
                              style: getTextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: Color(0xff333333),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: screenHeight * 0.03,
                          width: screenWidth * 0.20,
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Color(0xff000000).withOpacity(.6),
                                blurRadius: 10,
                                offset: Offset(0, 3),
                              ),
                            ],
                            borderRadius: BorderRadius.circular(34),
                            color: Color(0xffFFFFFF),
                          ),
                          child: Center(
                            child: Text(
                              "Square",
                              style: getTextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: Color(0xff333333),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 40),
                  Text(
                    'Upcoming Bookings',
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
                  NewWidget(reviews: reviews),
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
                  ListView.builder(
                    shrinkWrap: true, // VERY IMPORTANT
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: seereview.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.all(20),
                        child: SizedBox(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  ClipOval(
                                    child: Image.asset(
                                      seereview[index]["image"]!,
                                      fit: BoxFit.cover,
                                      height: 40,
                                      width: 40,
                                    ),
                                  ),
                                  SizedBox(width: 8),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        seereview[index]["title"]!,
                                        style: getTextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                          color: Color(0xff333333),
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Icon(
                                            Icons.star,
                                            color: Color(0xffF0C020),
                                            size: 15,
                                          ),
                                          Icon(
                                            Icons.star,
                                            color: Color(0xffF0C020),
                                            size: 15,
                                          ),
                                          Icon(
                                            Icons.star,
                                            color: Color(0xffF0C020),
                                            size: 15,
                                          ),
                                          Icon(
                                            Icons.star,
                                            color: Color(0xffF0C020),
                                            size: 15,
                                          ),
                                          Icon(
                                            Icons.star,
                                            color: Color(0xffF0C020),
                                            size: 15,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Spacer(),
                                  Text(
                                    seereview[index]["time"]!,
                                    style: getTextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: Color(0xffC0C0C0),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 15),

                              Text(
                                seereview[index]["desc"]!,
                                style: getTextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xff5C5C5C),
                                ),
                              ),
                            ],
                          ),
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
