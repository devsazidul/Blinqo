import 'package:blinqo/features/role/event_planner/invitation/controller/selected_color_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LabelText extends StatelessWidget {
  const LabelText({super.key, required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SelectedColorController());
    return Obx(() {
      return Text(
        text,
        style: Theme.of(context).textTheme.labelMedium?.copyWith(
          color: controller.selectedColor.value,
        ),
      );
    });
  }
}
