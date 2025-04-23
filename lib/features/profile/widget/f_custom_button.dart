import 'package:blinqo/features/profile/controller/pick_color_controller.dart';
import 'package:blinqo/features/profile/controller/profile_controller.dart';
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
    final profileController = Get.put(ProfileController());
    return GetBuilder<PickColorController>(
      builder: (controller) {
        return ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor:
                profileController.isDarkMode == false
                    ? backgroundColor ?? controller.selectedColor
                    : Color(0xff003366),
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
