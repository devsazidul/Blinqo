import 'package:blinqo/features/profile/controller/pick_color_controller.dart';
import 'package:blinqo/features/profile/controller/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FLabelText extends StatelessWidget {
  const FLabelText({super.key, required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    final profileController = Get.put(ProfileController());
    return GetBuilder<PickColorController>(
      builder: (controller) {
        return Text(
          text,
          style: Theme.of(context).textTheme.labelMedium?.copyWith(
            color:
                profileController.isDarkMode.value == false
                    ? controller.selectedColor
                    : Color(0xffD4AF37),
          ),
        );
      },
    );
  }
}
