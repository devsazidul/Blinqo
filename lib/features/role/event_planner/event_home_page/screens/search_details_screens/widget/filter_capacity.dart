import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:blinqo/core/utils/constants/icon_path.dart';
import 'package:blinqo/features/role/event_planner/event_home_page/controllers/search_details_controller/search_details_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

class Capacity extends StatelessWidget {
  const Capacity({super.key, required this.searchDetailsController});

  final SearchDetailsController searchDetailsController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Obx(
          () => Row(
            children: [
              Expanded(
                child: RangeSlider(
                  values: RangeValues(
                    searchDetailsController.capacityStart.value,
                    searchDetailsController.capacityEnd.value,
                  ),
                  min: 0,
                  max: 1000,
                  divisions: 1000,
                  labels: RangeLabels(
                    searchDetailsController.capacityStart.value.toStringAsFixed(
                      0,
                    ),
                    searchDetailsController.capacityEnd.value.toStringAsFixed(
                      0,
                    ),
                  ),

                  activeColor: AppColors.buttonColor2,
                  inactiveColor: AppColors.appBarIcolor,
                  onChanged: (RangeValues values) {
                    searchDetailsController.capacityStartValue(values.start);
                    searchDetailsController.capacityEndValue(values.end);
                  },
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 20),
        Row(
          children: [
            CircleAvatar(
              radius: 11,
              backgroundColor: Colors.white,
              child: Image.asset(IconPath.group),
            ),
            SizedBox(width: 8),
            Text(
              'Price Range',
              style: getTextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: AppColors.textColor,
              ),
            ),
          ],
        ),
        SizedBox(height: 20),

        Obx(
          () => Row(
            children: [
              SizedBox(height: 20),
              Expanded(
                child: RangeSlider(
                  values: RangeValues(
                    searchDetailsController.priceStart.value,
                    searchDetailsController.priceEnd.value,
                  ),
                  min: 0,
                  max: 12000,
                  divisions: 12000,
                  labels: RangeLabels(
                    searchDetailsController.priceStart.value.toStringAsFixed(0),
                    searchDetailsController.priceEnd.value.toStringAsFixed(0),
                  ),

                  activeColor: AppColors.buttonColor2,
                  inactiveColor: AppColors.appBarIcolor,
                  onChanged: (RangeValues values) {
                    searchDetailsController.priceRangeStart(values.start);
                    searchDetailsController.priceRangeEnd(values.end);
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
