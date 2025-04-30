import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/features/role/venue_owner/profile_page/controller/venue_owner_profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class SearchEmployee extends StatelessWidget {
  final TextEditingController controller;
  final Function(String)? onChanged;

  const SearchEmployee({super.key, required this.controller, this.onChanged});

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode =
        Get.put(VenueOwnerProfileController()).isDarkMode.value;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8), // shadow border এর সাথে মেলে
      ),
      child: TextField(
        controller: controller,
        onChanged: onChanged, // ✅ This is now wired
        style: getTextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: isDarkMode?Color(0xffEFEFEFf):Colors.black,
        ),
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
  }
}
