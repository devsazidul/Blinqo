import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:blinqo/core/utils/constants/colors.dart';

class ImagePickerWidget extends StatelessWidget {
  final VoidCallback onPickImageFromGallery;
  final VoidCallback onPickImageFromCamera;

  const ImagePickerWidget({
    super.key,
    required this.onPickImageFromGallery,
    required this.onPickImageFromCamera,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _showPickrOptions(context),
      child: Column(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: AppColors.iconColor.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.photo_camera,
              color: AppColors.iconColor,
              size: 30,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Pick Image',
            style: getTextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }

  Future<void> _showPickrOptions(BuildContext context) async {
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
                'Select Image Source',
                style: getTextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildImagePickerOption(
                    icon: Icons.camera_alt,
                    title: 'Camera',
                    onTap: onPickImageFromCamera,
                  ),
                  _buildImagePickerOption(
                    icon: Icons.photo_library,
                    title: 'Gallery',
                    onTap: onPickImageFromGallery,
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

  Widget _buildImagePickerOption({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
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
