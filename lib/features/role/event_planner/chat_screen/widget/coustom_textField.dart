// ignore_for_file: file_names

import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:blinqo/features/profile/controller/pick_color_controller.dart';
import 'package:blinqo/features/role/event_planner/chat_screen/controller/ep_chat_controller.dart';
import 'package:blinqo/features/role/event_planner/chat_screen/widget/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget coustomTextField(
  EpChatController controller,
  bool isDarkMode,
  BuildContext context,
  final String chatId,
  final bool isFemale,
  PickColorController femaleColorController,
) {
  return SizedBox(
    child: Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.textFrieldDarkColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: Row(
                    children: [
                      // IconButton(
                      //   icon: Icon(Icons.emoji_emotions_outlined),
                      //   color: AppColors.buttonColor,
                      //   onPressed: () {
                      //     Get.to(GroupProfile(chatId: chatId));
                      //   },
                      // ),
                      Expanded(
                        child: TextField(
                          onTap: () {},
                          controller: controller.messageController,
                          decoration: InputDecoration(
                            hintText: 'Type Message',
                            hintStyle: getTextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                              color: AppColors.hintTextColor,
                            ),
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            contentPadding: const EdgeInsets.symmetric(
                              vertical: 10,
                            ),
                            suffixIcon: IconButton(
                              icon: const Icon(Icons.add_link_sharp),
                              color: AppColors.buttonColor,
                              onPressed:
                                  () => Get.bottomSheet(
                                    ImagesPicker(
                                      chatId: chatId,
                                      epChatController: controller,
                                    ),
                                  ),
                            ),
                          ),
                          style: getTextStyle(color: AppColors.hintTextColor),
                          maxLines: 1,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
            Obx(() {
              final hasText = controller.isTyping.value;
              return GestureDetector(
                onTap: () {
                  if (hasText) {
                    controller.sendMessage(
                      chatId,
                      controller.messageController.text.trim(),
                    );
                    controller.messageController.clear();
                  } else {
                    Get.snackbar(
                      'Empty!',
                      'empty message',
                      snackPosition: SnackPosition.BOTTOM,
                    );
                  }
                },
                child: Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: AppColors.iconColor,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.send,
                    color: AppColors.buttonColor,
                    size: 20,
                  ),
                ),
              );
            }),
          ],
        ),
      ],
    ),
  );
}
