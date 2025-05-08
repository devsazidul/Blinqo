import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerOption extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const ImagePickerOption({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: AppColors.iconColor.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: AppColors.iconColor, size: 30),
          ),
          SizedBox(height: 8),
          Text(
            title,
            style: getTextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}

Future<ImageSource?> showPickrOption() async {
  return await Get.bottomSheet(
    Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Select Image',
              style: getTextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ImagePickerOption(
                  icon: Icons.camera_alt,
                  title: 'Camera',
                  onTap: () {
                    Get.back(result: ImageSource.camera);
                  },
                ),
                ImagePickerOption(
                  icon: Icons.photo_library,
                  title: 'Gallery',
                  onTap: () {
                    Get.back(result: ImageSource.gallery);
                  },
                ),
              ],
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    ),
  );
}
