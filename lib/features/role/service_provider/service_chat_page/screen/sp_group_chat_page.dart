import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/features/role/service_provider/service_chat_page/controller/sp_single_page_chat_controller.dart';
import 'package:blinqo/features/role/service_provider/service_chat_page/screen/sp_full_image_view.dart';
import 'package:blinqo/features/role/service_provider/service_chat_page/widget/sp_custom_single_textfield.dart';

class SpGroupChatPage extends StatelessWidget {
  final Map<String, dynamic> groupChat;

  SpGroupChatPage({super.key, required this.groupChat});

  final controller = Get.put(SpSinglePageChatController());
  final focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        controller.isEmojiVisible.value = false;
      }
    });

    return Obx(() {
      return Scaffold(
        backgroundColor: AppColors.chatBackground,
        appBar: AppBar(
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(groupChat["groupName"] ?? "Group Chat"),
              SizedBox(height: 4),
              Text(
                "Participants: ${groupChat["participants"]?.join(", ") ?? ''}",
                style: TextStyle(fontSize: 12),
              ),
            ],
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  controller: scrollController,
                  itemCount: controller.chatMessages.length,
                  itemBuilder: (context, index) {
                    final message = controller.chatMessages[index];
                    return Align(
                      alignment:
                          message.isUser
                              ? Alignment.centerRight
                              : Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 10,
                        ),
                        child: Column(
                          crossAxisAlignment:
                              message.isUser
                                  ? CrossAxisAlignment.end
                                  : CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment:
                                  message.isUser
                                      ? MainAxisAlignment.end
                                      : MainAxisAlignment.start,
                              children: [
                                if (!message.isUser)
                                  CircleAvatar(
                                    radius: 16,
                                    backgroundImage: AssetImage(
                                      groupChat["image"] ?? '',
                                    ),
                                  ),
                                SizedBox(width: 10),
                                IntrinsicWidth(
                                  child: Container(
                                    padding: const EdgeInsets.all(10),
                                    constraints: BoxConstraints(
                                      maxWidth: Get.width * 0.6,
                                    ),
                                    decoration: BoxDecoration(
                                      color:
                                          message.imageUrl.isNotEmpty
                                              ? Colors.transparent
                                              : AppColors.buttonColor2,
                                      borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(15),
                                        bottomRight: Radius.circular(15),
                                        topLeft:
                                            message.isUser
                                                ? Radius.circular(15)
                                                : Radius.zero,
                                        topRight:
                                            message.isUser
                                                ? Radius.zero
                                                : Radius.circular(15),
                                      ),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          message.isUser
                                              ? CrossAxisAlignment.end
                                              : CrossAxisAlignment.start,
                                      children: [
                                        if (message.imageUrl.isNotEmpty)
                                          GestureDetector(
                                            onTap: () {
                                              Get.to(
                                                () => FullImageView(
                                                  imagePath: message.imageUrl,
                                                ),
                                              );
                                            },
                                            child: Hero(
                                              tag: message.imageUrl,
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                                child: Image.file(
                                                  File(message.imageUrl),
                                                  width: 250,
                                                  height: 250,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                          ),
                                        if (message.message.isNotEmpty)
                                          Text(
                                            message.message,
                                            style: getTextStyle(
                                              color: AppColors.primary,
                                              fontSize: 16,
                                            ),
                                          ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Text(
                                              message.time,
                                              style: TextStyle(
                                                color: AppColors.primary,
                                                fontSize: 12,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),

              // Selected image preview
              Obx(() {
                if (controller.selectedImage.value != null) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Stack(
                      alignment: Alignment.topRight,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.file(
                            File(controller.selectedImage.value!.path),
                            width: 120,
                            height: 120,
                            fit: BoxFit.cover,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            controller.selectedImage.value = null;
                          },
                          child: CircleAvatar(
                            radius: 14,
                            backgroundColor: Colors.redAccent,
                            child: Icon(
                              Icons.close,
                              color: Colors.white,
                              size: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }
                return SizedBox.shrink();
              }),

              // Input field
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: Row(
                  children: [
                    Expanded(
                      child: CustomSingleTextfield(
                        focusNode: focusNode,
                        controller: controller,
                      ),
                    ),
                  ],
                ),
              ),

              // Emoji picker
              Obx(() {
                if (controller.isEmojiVisible.value) {
                  return EmojiPicker(
                    onEmojiSelected: (category, emoji) {
                      controller.messageController.text += emoji.emoji;
                      controller.messageText.value =
                          controller.messageController.text;
                    },
                  );
                }
                return SizedBox.shrink();
              }),
            ],
          ),
        ),
      );
    });
  }
}
