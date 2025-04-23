import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:blinqo/features/role/event_planner/event_home_page/controllers/search_details_controller/search_details_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

class RatingsReviews extends StatelessWidget {
  const RatingsReviews({super.key, required this.searchDetailsController});

  final SearchDetailsController searchDetailsController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 30),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 4, vertical: 4),
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(6),
            ),

            child: Row(
              children: [
                Icon(Icons.star, color: AppColors.reviesStarColor, size: 12),
                SizedBox(width: 6),
                Text(
                  '4.5',
                  style: getTextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w300,
                    color: AppColors.subTextColor2,
                  ),
                ),
              ],
            ),
          ),
          Obx(
            () => Slider(
              min: 0,
              max: 100,
              thumbColor: AppColors.thumbColor,
              activeColor: AppColors.buttonColor2,
              value: searchDetailsController.sliderValue.value,
              divisions: 100,
              onChanged: (double value) {
                searchDetailsController.updateSliderValue(value);
              },
            ),
          ),
        ],
      ),
    );
  }
}
