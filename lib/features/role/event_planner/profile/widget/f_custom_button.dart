import 'package:blinqo/features/role/event_planner/profile/controller/pick_color_controller.dart';
import 'package:blinqo/features/role/event_planner/profile/controller/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FCustomButton extends StatelessWidget {
  const FCustomButton({
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
    final profileController = Get.find<ProfileController>();
    return GetBuilder<PickColorController>(
      builder: (controller) {
        bool isFemale = controller.isFemale.value;
        return ElevatedButton(
          style: ElevatedButton.styleFrom(
            elevation: 0,
            backgroundColor:
                backgroundColor ??
                (profileController.isDarkMode.value == true
                    ? Color(0xff003366)
                    : isFemale
                    ? controller.selectedColor
                    : backgroundColor ?? Color(0xff003366)),

            foregroundColor: foregroundColor ?? Colors.white,

            minimumSize: Size(double.infinity, 48),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(radius),
            ),
          ),
          onPressed: onPressed ?? () {},
          child: child,
        );
      },
    );
  }
}
