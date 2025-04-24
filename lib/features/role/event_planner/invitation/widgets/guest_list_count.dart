import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/features/profile/controller/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GuestListCount extends StatelessWidget {
  const GuestListCount({
    super.key,
    required this.title,
    required this.count,
    required this.color,
  });

  final String title;
  final String count;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: Wrap(
        children: [
          Text(
            title,
            style: getTextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: color,
            ),
          ),
          Text(
            count,
            style: getTextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w600,
              color:
                  Get.find<ProfileController>().isDarkMode.value
                      ? Color(0xffD4AF37)
                      : Color(0xff003366),
            ),
          ),
        ],
      ),
    );
  }
}
