import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:blinqo/features/role/event_planner/event_home_page/controllers/search_details_controller/search_details_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

class BookingType extends StatelessWidget {
  const BookingType({super.key, required this.searchDetailsController});

  final SearchDetailsController searchDetailsController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 16),
      child: Row(
        children: [
          Obx(
            () => Expanded(
              child: Radio(
                toggleable: true,
                activeColor: AppColors.textColor,
                value: 1,
                groupValue: searchDetailsController.selectedBookingValue.value,
                onChanged: (int? value) {
                  if (value != null) {
                    searchDetailsController.toggleBooking();
                  }
                },
              ),
            ),
          ),
          Text(
            'Instant booking',
            style: getTextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w300,
              color: AppColors.textColor,
            ),
          ),
          Obx(
            () => Expanded(
              child: Radio(
                toggleable: true,
                activeColor: AppColors.textColor,
                value: 0,
                groupValue: searchDetailsController.selectedBookingValue.value,
                onChanged: (int? value) {
                  if (value != null) {
                    searchDetailsController.toggleBooking();
                  }
                },
              ),
            ),
          ),
          Text(
            'request-based booking',
            style: getTextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w300,
              color: AppColors.textColor,
            ),
          ),
        ],
      ),
    );
  }
}
