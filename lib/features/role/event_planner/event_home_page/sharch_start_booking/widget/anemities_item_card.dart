import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../home/controller/booking_controller.dart';
import 'amenities_card.dart';

class AmenitiesItemCard extends StatelessWidget {
  const AmenitiesItemCard({super.key, required this.bookingController});

  final BookingController bookingController;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 12),
        Text(
          "Amenities",
          style: getTextStyle(fontSize: 20.sp, fontWeight: FontWeight.w600),
        ),

        SizedBox(
          height: 36,

          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: bookingController.amenitiesList.length,
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) {
              final amenity = bookingController.amenitiesList[index];
              return AmenitiesCard(text: amenity.name, icon: amenity.icon);
            },
          ),
        ),
      ],
    );
  }
}
