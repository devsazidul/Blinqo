// ignore_for_file: file_names

import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/features/role/venue_owner/myvenue/controller/myview_controller.dart';
import 'package:blinqo/features/role/venue_owner/profile_page/controller/venue_owner_profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';

class SearchBarWidget extends StatelessWidget {
  final TextEditingController textcontroller;

  const SearchBarWidget({super.key, required this.textcontroller});

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode =
        Get.put(VenueOwnerProfileController()).isDarkMode.value;
    return GetBuilder<VenueOwnerProfileController>(
      builder: (controller) {
        return Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: const Color(0xff0D0A2C).withValues(alpha: 0.03),
                // হালকা কালো ছায়া
                blurRadius: 8,
                offset: const Offset(0, 3),
              ),
            ],
            borderRadius: BorderRadius.circular(
              8,
            ), // shadow border এর সাথে মেলে
          ),
          child: TextField(
            onChanged: (value) {
              Get.find<MyVenueController>().updateSearch(value);
            },
            style: getTextStyle(
              fontSize: 14,
              color: isDarkMode ? Color(0xffABB7C2) : Colors.black,
            ),
            controller: textcontroller,
            decoration: InputDecoration(
              hintText: 'Search your venues....',
              hintStyle: GoogleFonts.poppins(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: isDarkMode ? Color(0xffABB7C2) : Color(0xffABB7C2),
              ),

              filled: true,
              fillColor: isDarkMode ? Color(0xff32383D) : Color(0xffFFFFFF),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide.none,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        );
      },
    );
  }
}
