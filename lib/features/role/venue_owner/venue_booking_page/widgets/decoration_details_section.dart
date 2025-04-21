import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:blinqo/features/role/venue_owner/profile_page/controller/venue_owner_profile_controller.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class DecorationDetailsSection extends StatelessWidget {
  const DecorationDetailsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode =
        Get.put(VenueOwnerProfileController()).isDarkMode.value;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        decoration: BoxDecoration(
          color: isDarkMode ? Color(0xff32383D) : AppColors.primary,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Decoration',
                style: getTextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color:isDarkMode ? Color(0xffD4AF37) : AppColors.buttonColor2,
                ),
              ),
              SizedBox(height: 16),
              _buildDecorationDetailsRow('Table Shape', 'Round'),
              SizedBox(height: 16),
              _buildDecorationDetailsRow('Flower Color', 'Red'),
              SizedBox(height: 16),
              _buildDecorationDetailsRow('Seating Style', 'Banquet'),
              SizedBox(height: 16),
              _buildDecorationDetailsRow('Fragrance', 'Sweet'),
              SizedBox(height: 16),
              _buildDecorationDetailsRow('Lighting Styles', 'Warm Yellow'),
              SizedBox(height: 16),
              _buildDecorationDetailsRow('Tablecloth Colors', 'White'),
              SizedBox(height: 16),
              _buildDecorationDetailsRow('Stage Decor', 'LED Backdrops'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDecorationDetailsRow(String label, String value) {
    final bool isDarkMode =
        Get.put(VenueOwnerProfileController()).isDarkMode.value;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: getTextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color:isDarkMode ? Color(0xffEBEBEB) : Color(0xff767676),
          ),
        ),
        Text(
          value,
          style: getTextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color:isDarkMode ? Color(0xffD4AF37) : AppColors.buttonColor2,
          ),
        ),
      ],
    );
  }
}
