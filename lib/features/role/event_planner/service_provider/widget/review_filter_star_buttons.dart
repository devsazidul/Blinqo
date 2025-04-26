import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/features/role/event_planner/service_provider/controller/review_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EpSpReviewFilterStarButtons extends StatelessWidget {
  EpSpReviewFilterStarButtons({super.key});

  final EpSpReviewController controller = Get.put(EpSpReviewController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Row(
        spacing: 16,
        mainAxisAlignment: MainAxisAlignment.start,
        children: List.generate(5, (index) {
          int star = 5 - index;
          return GestureDetector(
            onTap: () {
              controller.setStarFilter(star);
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              decoration: BoxDecoration(
                color:
                    controller.selectedStarFilter.value == star
                        ? Colors.white
                        : Colors.transparent,
                borderRadius: BorderRadius.circular(4.0),
                border: Border.all(color: Color(0xffABB7C2)),
              ),
              child: Row(
                spacing: 4,
                children: [
                  Text(
                    "$star",
                    style: getTextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      color:
                          controller.selectedStarFilter.value == star
                              ? Colors.black
                              : Color(0xffABB7C2),
                    ),
                  ),
                  Icon(Icons.star, color: Colors.amber, size: 12),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
