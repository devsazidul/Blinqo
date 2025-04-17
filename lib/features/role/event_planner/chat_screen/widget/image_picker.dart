import 'package:blinqo/features/role/event_planner/chat_screen/controller/ep_chat_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ImagesPicker extends StatelessWidget {
  final String chatId;
  final EpChatController epChatController;

  const ImagesPicker({
    super.key,
    required this.chatId,
    required this.epChatController,
  });

  Widget imagePickerOption({
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
              color: const Color(0xFF205295),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: const Color(0xFF205295), size: 30),
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Select Image',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                imagePickerOption(
                  icon: Icons.camera_alt,
                  title: 'Camera',
                  onTap: () {
                    Get.back();
                    epChatController.pickImage(chatId, ImageSource.camera);
                  },
                ),
                imagePickerOption(
                  icon: Icons.photo_library,
                  title: 'Gallery',
                  onTap: () {
                    Get.back();
                    epChatController.pickImage(chatId, ImageSource.gallery);
                  },
                ),
              ],
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
