import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:blinqo/core/utils/constants/image_path.dart';
import 'package:flutter/material.dart';

class UpComingEvents extends StatelessWidget {
  final bool isDark;
  final String title;
  final String venue;
  final String date;
  final String location;
  final String status;
  final int index;

  const UpComingEvents({
    super.key,
    required this.isDark,
    required this.title,
    required this.venue,
    required this.date,
    required this.location,
    required this.status,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: isDark ? AppColors.textFieldDarkColor : AppColors.primary,
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.all(12),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  ImagePath.eventCard,
                  fit: BoxFit.cover,
                  height: 40,
                  width: 40,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: getTextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color:
                            isDark
                                ? AppColors.primary
                                : AppColors.textFieldDarkColor,
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          venue,
                          style: getTextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                        SizedBox(width: 4),
                        index == 0
                            ? Icon(
                              Icons.verified,
                              color: Colors.blueAccent,
                              size: 16,
                            )
                            : SizedBox.shrink(),
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
                    color: const Color(0xffD9D9D9),
                  ),
                  child: Transform.rotate(
                    angle: -0.60,
                    child: Icon(
                      size: 20,
                      Icons.arrow_forward,
                      color: AppColors.iconColor,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(height: 8),
              Wrap(
                spacing: 16,
                runSpacing: 8,
                children: [
                  _iconWithText(Icons.calendar_month, date),
                  _iconWithText(Icons.location_on_outlined, location),
                ],
              ),
              Spacer(),
              _statusButton(status),
            ],
          ),
        ],
      ),
    );
  }

  Container _statusButton(String status) {
    Color buttonColor =
        status == 'Confirmed' ? Color(0x3337D459) : Color(0x33D4AF37);
    Color textColor =
        status == 'Confirmed' ? Color(0xFF37D441) : Color(0xFFD4AF37);
    return Container(
      decoration: BoxDecoration(
        color: buttonColor,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 6),
        child: Text(
          status,
          style: getTextStyle(fontSize: 12, color: textColor),
        ),
      ),
    );
  }

  Widget _iconWithText(IconData icon, String text) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 16, color: Color(0xFF8A8A8A)),
        const SizedBox(width: 4),
        Text(
          text,
          style: getTextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 12,
            color: Color(0xFF8A8A8A),
          ),
        ),
      ],
    );
  }
}
