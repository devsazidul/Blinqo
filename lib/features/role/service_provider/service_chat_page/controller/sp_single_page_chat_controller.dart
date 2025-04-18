import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ChatMessage {
  final String message;
  final String time;
  final bool isUser;
  final String imageUrl;

  ChatMessage({
    required this.message,
    required this.time,
    required this.isUser,
    required this.imageUrl,
  });
}

class SpSinglePageChatController extends GetxController {
  var chatMessages =
      <ChatMessage>[
        ChatMessage(
          message: "Hi there!",
          time: "10:30 AM",
          isUser: false,
          imageUrl: "",
        ),
        ChatMessage(
          message: "Hello! How can I help you?",
          time: "10:31 AM",
          isUser: true,
          imageUrl: "",
        ),
        ChatMessage(
          message: "I have a question regarding your service.",
          time: "10:32 AM",
          isUser: false,
          imageUrl: "",
        ),
      ].obs;

  final messageController = TextEditingController();
  var messageText = ''.obs;

  final ImagePicker _picker = ImagePicker();

  void onMessageChanged(String value) {
    messageText.value = value;
  }

  void sendMessage() {
    final message = messageController.text.trim();
    if (message.isNotEmpty) {
      chatMessages.add(
        ChatMessage(
          message: message,
          time: TimeOfDay.now().format(Get.context!),
          isUser: true,
          imageUrl: "",
        ),
      );
      messageController.clear();
      messageText.value = '';
    }
  }
  // Inside SpSinglePageChatController

  var selectedImage = Rx<XFile?>(null);

  Future<void> pickImage() async {
    final pickedOption = await showDialog<String>(
      context: Get.context!,
      builder: (context) {
        return AlertDialog(
          title: Text(
            'Pick an image',
            style: getTextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w600,
              color: AppColors.buttonColor2,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop('gallery');
              },
              child: Row(
                children: [
                  Icon(Icons.photo, color: AppColors.buttonColor2),
                  SizedBox(width: 8),
                  Text(
                    'Gallery',
                    style: getTextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: AppColors.buttonColor2,
                    ),
                  ),
                ],
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop('camera');
              },
              child: Row(
                children: [
                  Icon(Icons.camera_alt, color: AppColors.buttonColor2),
                  SizedBox(width: 8),
                  Text(
                    'Camera',
                    style: getTextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: AppColors.buttonColor2,
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );

    if (pickedOption != null) {
      XFile? pickedFile;

      if (pickedOption == 'gallery') {
        pickedFile = await _picker.pickImage(source: ImageSource.gallery);
      } else if (pickedOption == 'camera') {
        pickedFile = await _picker.pickImage(source: ImageSource.camera);
      }

      if (pickedFile != null) {
        selectedImage.value = pickedFile;
      }
    }
  }

  void sendImage() {
    if (selectedImage.value != null) {
      chatMessages.add(
        ChatMessage(
          message: "",
          time: TimeOfDay.now().format(Get.context!),
          isUser: true,
          imageUrl: selectedImage.value!.path,
        ),
      );
      selectedImage.value = null;
    }
  }
}
