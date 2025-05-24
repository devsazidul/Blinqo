import 'package:blinqo/core/common/widgets/custom_appbar_widget.dart';
import 'package:blinqo/features/role/event_planner/ep_common/widgets/ep_bottom_nav_bar_widget.dart';
import 'package:blinqo/features/role/event_planner/ep_home/controller/ep_venue_compare_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddCompare extends StatelessWidget {
  const AddCompare({super.key});

  @override
  Widget build(BuildContext context) {
    final venueCompareController = Get.find<EpVenueCompareController>();
    final venues = venueCompareController.venues;

    // List of field names and extractors
    final fields = <Map<String, dynamic>>[
      {"label": "Image", "extractor": (venue) => venue.venueImage?.path ?? ""},
      {"label": "Location", "extractor": (venue) => venue.city ?? ""},
      {
        "label": "Capacity",
        "extractor": (venue) => venue.capacity?.toString() ?? "",
      },
      {
        "label": "Pricing & Packages",
        "extractor": (venue) => venue.price?.toString() ?? "",
      },
      {
        "label": "Catering Options",
        "extractor": (venue) => venue.cateringDescription ?? "No",
      },
      {
        "label": "Parking Space",
        "extractor": (venue) => venue.parkingDescription ?? "No",
      },
      {
        "label": "Availability",
        "extractor": (venue) => venue.availabilityDescription ?? "No",
      },
      {
        "label": "Extra Services",
        "extractor": (venue) => venue.extraServiceDescription ?? "No",
      },
      // Add more fields as needed
    ];

    return Scaffold(
      appBar: CustomAppBarWidget(title: 'Compare'),
      bottomNavigationBar: EpBottomNavBarWidget(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Table(
              border: TableBorder.all(color: const Color(0xffABB7C2)),
              columnWidths: {
                0: FixedColumnWidth(153),
                ...Map.fromEntries(
                  List.generate(
                    venues.length,
                    (index) => MapEntry(index + 1, FixedColumnWidth(153)),
                  ),
                ),
                // The rest will be flexible or you can fix as needed
              },
              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
              children: [
                // Header row
                TableRow(
                  decoration: BoxDecoration(color: Colors.white),
                  children: [
                    _tableHeaderCell('Venue'),
                    ...venues.map(
                      (venue) => _tableHeaderCell(venue.name ?? ''),
                    ),
                  ],
                ),
                // Image row

                // Data rows
                ...fields.map((field) {
                  return TableRow(
                    children: [
                      _tableAttributeCell(field["label"] as String),
                      ...venues.map(
                        (venue) =>
                            field["label"] == "Image"
                                ? _tableImageCell(field["extractor"]!(venue))
                                : _tableValueCell(field["extractor"]!(venue)),
                      ),
                    ],
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _tableHeaderCell(String text) => Container(
    alignment: Alignment.center,
    padding: const EdgeInsets.all(8.0),
    child: Text(
      text,
      style: const TextStyle(
        fontWeight: FontWeight.bold,
        color: Color(0xff003366),
      ),
      softWrap: true,
      overflow: TextOverflow.visible,
      maxLines: null,
      textAlign: TextAlign.center,
    ),
  );

  Widget _tableAttributeCell(String text) => Container(
    alignment: Alignment.centerLeft,
    padding: const EdgeInsets.all(8.0),
    // color: const Color(0xfff5f7fa),
    child: Text(
      text,
      style: const TextStyle(
        fontWeight: FontWeight.w600,
        color: Color(0xff003366),
      ),
      softWrap: true,
      overflow: TextOverflow.visible,
      maxLines: null,
    ),
  );

  Widget _tableValueCell(String text) => Container(
    alignment: Alignment.centerLeft,
    padding: const EdgeInsets.all(8.0),
    child: Text(
      text,
      style: const TextStyle(fontWeight: FontWeight.normal),
      softWrap: true,
      overflow: TextOverflow.visible,
      maxLines: null,
    ),
  );

  Widget _tableImageCell(String imageUrl) => Container(
    alignment: Alignment.center,
    padding: const EdgeInsets.all(8.0),
    child:
        imageUrl.isNotEmpty
            ? Image.network(
              imageUrl,
              height: 100,
              width: 150,
              fit: BoxFit.cover,
              errorBuilder:
                  (context, error, stackTrace) => const Icon(Icons.error),
            )
            : const SizedBox(),
  );
}
