import 'package:blinqo/core/common/styles/global_text_style.dart'
    show getTextStyle;
import 'package:blinqo/core/utils/constants/colors.dart' show AppColors;
import 'package:blinqo/core/utils/constants/image_path.dart' show ImagePath;
import 'package:flutter/material.dart';

class FeatureVenues extends StatelessWidget {
  final bool hasButton;
   const FeatureVenues({super.key, this.hasButton=true});

  @override
  Widget build(BuildContext context) {

    double screenWidth = MediaQuery.of(context).size.width;
    double cardWidth = screenWidth * 0.7;
    double buttonFontSize = screenWidth <= 360 ? 14 : 16;

    return Container(
      width: cardWidth,
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _venueImageSection(),
          SizedBox(height: 12),
          Text(
            'The Grand Hall',
            style: getTextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          SizedBox(height: 4),
          _venueLocationRow(),
          SizedBox(height: 4),
          Text(
            'Add to Compare',
            style: getTextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: AppColors.iconColor,
            ),
          ),
          hasButton ? _venueBottomRow(buttonFontSize) :SizedBox(),
        ],
      ),
    );
  }

  Widget _venueImageSection() {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.asset(
            ImagePath.venuesHall,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
        ),
        Positioned(
          top: 8,
          left: 8,
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 4, horizontal: 4),
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Text(
                  '4.5',
                  style: getTextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(width: 4),
                Icon(Icons.star, size: 12),
              ],
            ),
          ),
        ),
        Positioned(
          top: 8,
          right: 8,
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(25),
            ),
            child: Padding(
              padding: const EdgeInsets.all(4),
              child: Icon(Icons.favorite_border, size: 18),
            ),
          ),
        ),
        Positioned(
          bottom: 8,
          right: 8,
          child: Icon(Icons.threesixty, size: 24, color: Colors.white),
        ),
      ],
    );
  }

  Widget _venueLocationRow() {
    return Row(
      children: [
        Icon(Icons.location_on_rounded, color: Color(0xff8A8A8A), size: 16),
        SizedBox(width: 4),
        Text(
          'New York',
          style: getTextStyle(color: Color(0xff8A8A8A), fontSize: 12),
        ),
      ],
    );
  }

  Widget _venueBottomRow(double buttonFontSize) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.grey.shade400,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Padding(
            padding: const EdgeInsets.all(4),
            child: Text(
              '300 Guests',
              style: getTextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: AppColors.primary,
              ),
            ),
          ),
        ),
        SizedBox(width: 22),
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.buttonColor2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            padding: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
          ),
          child: Text(
            'View Details',
            style: getTextStyle(
              fontSize: buttonFontSize,
              fontWeight: FontWeight.w500,
              color: AppColors.primary,
            ),
          ),
        ),
      ],
    );
  }
}
