import 'package:blinqo/features/role/event_planner/invitation/controller/selected_color_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EpCustomButton extends StatelessWidget {
  const EpCustomButton({
    super.key,
    required this.child,
    this.onPressed,
    this.backgroundColor,
    this.foregroundColor,
    this.radius = 12,
  });

  final Widget child;
  final void Function()? onPressed;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final double radius;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SelectedColorController());
    return Obx(() {
      return ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor ?? controller.selectedColor.value,
          foregroundColor: foregroundColor ?? Colors.white,

          minimumSize: Size(double.infinity, 48),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius),
          ),
        ),
        onPressed: onPressed ?? () {},
        child: child,
      );
    });
  }
}
