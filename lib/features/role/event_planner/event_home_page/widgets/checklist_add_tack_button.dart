import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../core/common/styles/global_text_style.dart';
import '../../event_checkout_page/screens/create_checklist_screen.dart';

class ChecklistAddTackButton extends StatelessWidget {
  const ChecklistAddTackButton({super.key, required this.screenHeight});

  final double screenHeight;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: screenHeight * 0.17,
      padding: const EdgeInsets.only(left: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(height: 10),
          Align(
            alignment: Alignment.centerLeft,
            child: OutlinedButton(
              onPressed: () {
                Get.to(const CreateChecklistScreen());
              },
              style: OutlinedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
                padding: const EdgeInsets.symmetric(
                  vertical: 5,
                  horizontal: 12,
                ),
                fixedSize: const Size(125, 44),
                side: BorderSide(color: AppColors.iconColor, width: 1.5),
              ),
              child: Row(
                children: [
                  Text(
                    'Add Task',
                    style: getTextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: AppColors.iconColor,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Icon(
                    Icons.add_circle_outline_outlined,
                    size: 24,
                    color: AppColors.iconColor,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
