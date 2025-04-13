
import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/features/role/service_provider/service_profile_page/controller/review_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RattingDistributionWidget extends StatelessWidget {
  const RattingDistributionWidget({
    super.key,
    required this.controller,
  });

  final ReviewController controller;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        children: List.generate(5, (index) {
          int star = 5 - index;
          double percentage = controller.ratingDistribution[star] ?? 0;
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            child: Row(
              children: [
                Text(
                  "$star",
                  style: getTextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Icon(Icons.star, color: Colors.amber, size: 14),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: LinearProgressIndicator(
                    value: percentage / 100,
                    backgroundColor: Colors.grey[300],
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.amber),
                  ),
                ),
                SizedBox(width: 8),
                Text("${percentage.toStringAsFixed(0)}%"),
              ],
            ),
          );
        }),
      ),
    );
  }
}
