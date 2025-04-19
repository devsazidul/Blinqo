import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:flutter/material.dart';

class DecorationDetailsSection extends StatelessWidget {
  const DecorationDetailsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.primary,
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
                  color: AppColors.buttonColor2,
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
              _buildDecorationDetailsRow(
                'Lighting Styles',
                'Warm Yellow',
              ),
              SizedBox(height: 16),
              _buildDecorationDetailsRow('Tablecloth Colors', 'White'),
              SizedBox(height: 16),
              _buildDecorationDetailsRow(
                'Stage Decor',
                'LED Backdrops',
              ),
            ],
          ),
        ),
      ),
    );
  }
  Widget _buildDecorationDetailsRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: getTextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: Color(0xff767676),
          ),
        ),
        Text(
          value,
          style: getTextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: AppColors.buttonColor2,
          ),
        ),
      ],
    );
  }

}
