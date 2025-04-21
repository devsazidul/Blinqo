import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:blinqo/features/role/venue_owner/profile_page/controller/venue_owner_profile_controller.dart';
import 'package:blinqo/features/role/venue_owner/venue_booking_page/controllers/booking_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PriceDialog extends StatelessWidget {

  final PriceController controller;
  const PriceDialog({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Get.put(VenueOwnerProfileController()).isDarkMode.value;
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      backgroundColor:isDarkMode ? Color(0xff151515) : Colors.white,
      content: TextField(
        onChanged: (value) => controller.price.value = value,
        keyboardType: TextInputType.number,
        style: getTextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w400,
          color:isDarkMode ? Color(0xffEBEBEB) : Color(0xff171725),
        ),
        decoration: InputDecoration(
          hintText: 'Enter price',
          hintStyle: getTextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w400,
            color:isDarkMode ? Color(0xffEBEBEB) : AppColors.hintTextColor,
          ),
          label: Text(
            'Set A Price',
            style: getTextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color:isDarkMode ? Color(0xffEBEBEB) : Colors.grey,
            ),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(width: 1),
          ),
        ),
      ),
      actions: [
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () => controller.submitPrice(controller.price.value),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.iconColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Text(
              'Submit',
              style: getTextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
