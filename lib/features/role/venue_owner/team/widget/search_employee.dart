import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SearchEmployee extends StatelessWidget {
  final TextEditingController controller;

  const SearchEmployee({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    

    return  Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: const Color(0xff0D0A2C).withValues(alpha: 0.03), // হালকা কালো ছায়া
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
        borderRadius: BorderRadius.circular(8), // shadow border এর সাথে মেলে
      ),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: 'Search employee....',
          hintStyle: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: Color(0xffABB7C2),
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16),
          suffixIcon: IconButton(
            icon: const Icon(Icons.mic_none, color: Color(0xff003366), size: 19),
            onPressed: () {},
          ),
          filled: true,
          fillColor: const Color(0xffFFFFFF),
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