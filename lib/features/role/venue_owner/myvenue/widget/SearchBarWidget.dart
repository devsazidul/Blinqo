import 'package:flutter/material.dart';
import 'package:blinqo/core/common/styles/global_text_style.dart';

class SearchBarWidget extends StatelessWidget {
  final TextEditingController controller;

  const SearchBarWidget({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xffFFFFFF),
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: const Color(0xff0D0A2C).withOpacity(.6),
            offset: const Offset(0, 3),
            blurRadius: 6,
          ),
        ],
        border: Border.all(color: const Color(0xffEBEBEB), width: 0.7),
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
