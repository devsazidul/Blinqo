import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:blinqo/features/role/venue_owner/venue_booking_page/controllers/booking_controller.dart';
import 'package:flutter/material.dart';



class PriceDialog extends StatelessWidget {

  final PriceController controller;
  const PriceDialog({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      backgroundColor: Colors.white,
      content: TextField(
        onChanged: (value) => controller.price.value = value,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          hintText: 'Enter price',
          hintStyle: getTextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w400,
            color: AppColors.hintTextColor,
          ),
          label: Text(
            'Set A Price',
            style: getTextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: Colors.grey,
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
