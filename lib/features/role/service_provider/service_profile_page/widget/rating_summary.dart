import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/features/role/service_provider/service_profile_page/controller/review_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RatingSummary extends StatelessWidget {
  const RatingSummary({
    super.key,
    required this.controller,
  });

  final ReviewController controller;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "${controller.averageRating}",
            style: getTextStyle(fontSize: 20, fontWeight: FontWeight.w600),
          ),
          SizedBox(width: 4),
          Text(
            "(${controller.reviewCount})",
            style: getTextStyle(
              fontSize: 14,
              color: Color(0xffA1A1A1),
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
