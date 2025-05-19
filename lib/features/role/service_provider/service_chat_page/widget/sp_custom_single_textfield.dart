import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:blinqo/core/utils/constants/icon_path.dart';
import 'package:blinqo/features/role/service_provider/service_chat_page/controller/sp_single_page_chat_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

class CustomSingleTextfield extends StatelessWidget {
  const CustomSingleTextfield({
    super.key,
    required this.focusNode,
    required this.controller,
  });

  final FocusNode focusNode;
  final SpSinglePageChatController controller;

  @override
  Widget build(BuildContext context) {
    return TextField(
      focusNode: focusNode,
      controller: controller.messageController,
      onChanged: (text) {
        controller.onMessageChanged(text);
        if (controller.isEmojiVisible.value) {
          controller.isEmojiVisible.value = false;
        }
      },

      style: getTextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: AppColors.primary,
      ),
      decoration: InputDecoration(
        hintText: "Type Message",
        hintStyle: getTextStyle(
          color: AppColors.primary.withValues(alpha: 0.4),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
        fillColor: AppColors.textFieldDarkColor,
        filled: true,
        suffixIcon: Obx(
          () => GestureDetector(
            onTap: () {
              if (controller.selectedImage.value != null) {
                controller.sendImage();
              } else if (controller.messageText.value.isNotEmpty) {
                controller.sendMessage();
              } else {
                controller.pickImage();
              }
            },
            child: CircleAvatar(
              backgroundColor: Colors.transparent,
              radius: 12,
              child: Image.asset(
                controller.selectedImage.value != null ||
                        controller.messageText.value.isNotEmpty
                    ? IconPath.spchatsend
                    : IconPath.chatattachfile,
                width: 18,
                height: 18,
              ),
            ),
          ),
        ),

        prefixIcon: GestureDetector(
          onTap: () {
            if (controller.isEmojiVisible.value) {
              focusNode.requestFocus();
            } else {
              FocusScope.of(context).unfocus();
            }
            controller.isEmojiVisible.value = !controller.isEmojiVisible.value;
          },
          child: CircleAvatar(
            backgroundColor: Colors.transparent,
            radius: 12,
            child: Image.asset(IconPath.chatemoji, width: 24, height: 24),
          ),
        ),
      ),
    );
  }
}
