import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:flutter/material.dart';
import 'package:blinqo/features/role/venue_owner/profile_page/Model/amenity_model.dart';
import 'package:blinqo/features/role/venue_owner/profile_page/controller/venu_setup_controller.dart';

class EventAmenityButton extends StatelessWidget {
  final EventAmenity amenity;
  final bool isSelected;
  final VenueSetupController controller;

  const EventAmenityButton({
    super.key,
    required this.amenity,
    required this.isSelected,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: () {
        if (isSelected) {
          controller.removeAmenity(amenity);
        } else {
          controller.selectAmenity(amenity);
        }
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Color(0x0F000000),
              blurRadius: 10,
              offset: Offset(0, 3),
              spreadRadius: 0,
            ),
          ],
          borderRadius: BorderRadius.circular(34),
          color: isSelected ? Color(0xffFBF7EB) : Color(0xffFFFFFF),
        ),
        child: Text(
          amenity.name,
          style: getTextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: Color(0xff333333),
          ),
        ),
      ),
    );
  }
}
