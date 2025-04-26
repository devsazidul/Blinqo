import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:blinqo/features/role/venue_owner/profile_page/controller/amenities_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddAmenitiesDialog extends StatelessWidget {
  final AmenitiesController controller;
  const AddAmenitiesDialog({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final TextEditingController amenityController = TextEditingController();

    return  AlertDialog(
      backgroundColor: Colors.white,
      content: TextField(
        // onChanged: (value) => controller.price.value = value,
        controller: amenityController,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          hintText: 'Add new amenity',
          hintStyle: getTextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w400,
            color: AppColors.hintTextColor,
          ),
          label: Text(
            'Add New Amenity',
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
        Row(
          children: [
            SizedBox(width: 20),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Color(0x1A003366),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: Center(
                      child: Text(
                        'cancel',
                        style: getTextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: AppColors.buttonColor2,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(width: 8),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  controller.addCustomAmenity(amenityController.text);
                  amenityController.clear();
                  Get.back();
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.iconColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: Center(
                      child: Text(
                        'Submit',
                        style: getTextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(width: 20),
          ],
        ),
      ],
    );
  }
}
