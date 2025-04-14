import 'package:blinqo/core/utils/constants/app_sizes.dart';
import 'package:flutter/material.dart';
import 'package:blinqo/core/common/styles/global_text_style.dart';

class SearchBarWidget extends StatelessWidget {
  final TextEditingController controller;

  const SearchBarWidget({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(

      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xffFFFFFF),
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: const Color(0xff0D0A2C).withOpacity(.2  ),

            blurRadius: 10,
          ),
        ],


      ),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: 'Search Your Venues',
          hintStyle: getTextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 14,
            color: const Color(0xffABB7C2),
          ),

          contentPadding: const EdgeInsets.symmetric(horizontal: 16),
          suffixIcon: IconButton(
            icon: const Icon(Icons.mic, color: Color(0xff003366),size: 19,),
            onPressed: () {

            },
          ),
        ),
      ),
    );
  }
}
