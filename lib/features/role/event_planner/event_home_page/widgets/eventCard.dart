import 'package:blinqo/core/common/styles/global_text_style.dart'
    show getTextStyle;
import 'package:blinqo/core/utils/constants/colors.dart' show AppColors;
import 'package:blinqo/core/utils/constants/image_path.dart' show ImagePath;
import 'package:flutter/material.dart';

class EventCard extends StatelessWidget {
  const EventCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.buttonColor2,
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.all(12),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRect(
                child: Image.asset(
                  ImagePath.eventCard,
                  fit: BoxFit.cover,
                  height: 60,
                  width: 80,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'The Spring Fair',
                      style: getTextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      'Lavender Fields Venue',
                      style: getTextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 12,
                        color: AppColors.smallText,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 16,
                      runSpacing: 8,
                      children: [
                        _iconWithText(Icons.calendar_month, '15 March,2025'),
                        _iconWithText(Icons.location_on_outlined, 'New York'),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 18),
              GestureDetector(
                onTap: () {},
                child: Container(
                  height: 28,
                  width: 28,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(23),
                    color: const Color(0xFFB0C0D0),
                  ),
                  child: Transform.rotate(
                    angle: -0.60,
                    child: Icon(
                      Icons.arrow_forward,
                      color: AppColors.iconColor,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildTimeBox(context, '2', 'Days'),
              const SizedBox(width: 12),
              _buildTimeBox(context, '10', 'Hours'),
              const SizedBox(width: 12),
              _buildTimeBox(context, '32', 'Min'),
              const SizedBox(width: 12),
              _buildTimeBox(context, '45', 'Sec'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _iconWithText(IconData icon, String text) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 16, color: AppColors.smallText),
        const SizedBox(width: 4),
        Text(
          text,
          style: getTextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 12,
            color: AppColors.smallText,
          ),
        ),
      ],
    );
  }

  Widget _buildTimeBox(BuildContext context, String value, String label) {
    return Container(
      height: 48,
      width: 48,
      decoration: BoxDecoration(
        color: const Color(0xffFBF7EB),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            value,
            style: getTextStyle(
              fontSize: 20,
              color: AppColors.buttonColor,
              fontWeight: FontWeight.w600,
              lineHeight: 1,
            ),
          ),
          Text(
            label,
            style: getTextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w400,
              color: AppColors.buttonColor,
              lineHeight: 1,
            ),
          ),
        ],
      ),
    );
  }
}
