import 'dart:io' show File;

import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:blinqo/core/utils/constants/icon_path.dart';
import 'package:blinqo/features/role/service_provider/service_chat_page/controller/sp_single_page_chat_controller.dart';
import 'package:blinqo/features/role/service_provider/service_profile_page/controller/service_user_profile_controler.dart'
    show SpProfileController;
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class SpSinglePageChat extends StatelessWidget {
  final Map<String, dynamic> chat;

  SpSinglePageChat({Key? key, required this.chat}) : super(key: key);
  final darkcontroller = Get.put(SpProfileController());

  @override
  Widget build(BuildContext context) {
    bool isOnline = chat['isOnline'] == 'true';
    final controller = Get.put(SpSinglePageChatController());
    final FocusNode focusNode = FocusNode();
    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        controller.isEmojiVisible.value = false;
      }
    });

    return Obx(() {
      final themeMode =
          darkcontroller.isDarkMode.value ? ThemeMode.dark : ThemeMode.light;
      return Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor:
            themeMode == ThemeMode.dark
                ? AppColors.darkBackgroundColor
                : AppColors.chatBackground,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(62),
          child: Container(
            decoration: BoxDecoration(
              color:
                  themeMode == ThemeMode.dark
                      ? AppColors.textFrieldDarkColor
                      : AppColors.primary,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30.0),
                bottomRight: Radius.circular(30.0),
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30.0),
                bottomRight: Radius.circular(30.0),
              ),
              child: AppBar(
                forceMaterialTransparency: true,
                backgroundColor:
                    themeMode == ThemeMode.dark
                        ? AppColors.textFrieldDarkColor
                        : AppColors.primary,
                automaticallyImplyLeading: false,
                leading: GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: CircleAvatar(
                      radius: 20,
                      backgroundColor:
                          themeMode == ThemeMode.dark
                              ? AppColors.primary.withValues(alpha: 0.10)
                              : AppColors.textColor.withValues(alpha: 0.10),
                      child: Image.asset(
                        IconPath.arrowleft,
                        width: 16,
                        height: 12,
                        color:
                            themeMode == ThemeMode.dark
                                ? AppColors.primary
                                : AppColors.textColor,
                      ),
                    ),
                  ),
                ),
                title: Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: AssetImage(chat['image'] ?? ''),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            chat['name'] ?? '',
                            overflow: TextOverflow.ellipsis,
                            style: getTextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color:
                                  themeMode == ThemeMode.dark
                                      ? AppColors.primary
                                      : AppColors.textColor,
                            ),
                          ),
                          SizedBox(height: 6),
                          Text(
                            isOnline ? 'Online' : 'Offline',
                            style: TextStyle(
                              color:
                                  isOnline
                                      ? Color(0xff008D36)
                                      : Color(0xffF00000),
                              fontSize: 14,
                              fontWeight: FontWeight.w200,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                actions: [
                  PopupMenuTheme(
                    data: PopupMenuThemeData(
                      color:
                          themeMode == ThemeMode.dark
                              ? AppColors.textColor
                              : AppColors.popUpBackground,
                    ),
                    child: PopupMenuButton<String>(
                      onSelected: (value) {
                        debugPrint('Selected: $value');
                      },
                      itemBuilder:
                          (context) => [
                            PopupMenuItem<String>(
                              value: 'delete',
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Delete Conversation',
                                    style: getTextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                      color:
                                          themeMode == ThemeMode.dark
                                              ? AppColors.primary
                                              : AppColors.textColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            PopupMenuItem<String>(
                              value: 'mark_unread',
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Mark as Unread',
                                    style: getTextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                      color:
                                          themeMode == ThemeMode.dark
                                              ? AppColors.primary
                                              : AppColors.textColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            PopupMenuItem<String>(
                              value: 'block',
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Block',
                                    style: getTextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                      color:
                                          themeMode == ThemeMode.dark
                                              ? AppColors.primary
                                              : AppColors.textColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            PopupMenuItem<String>(
                              value: 'report',
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Report',
                                    style: getTextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                      color:
                                          themeMode == ThemeMode.dark
                                              ? AppColors.primary
                                              : AppColors.textColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: Column(
            children: [
              Expanded(
                child: Obx(
                  () => ListView.builder(
                    controller: scrollController,
                    shrinkWrap: true,
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
                                      backgroundImage: AssetImage(
                                        chat['image'] ?? '',
                                      ),
                                      radius: 16,
                                    ),
                                  SizedBox(width: 10),
                                  IntrinsicWidth(
                                    child: Container(
                                      padding: const EdgeInsets.all(10),
                                      constraints: BoxConstraints(
                                        maxWidth: 250,
                                      ),
                                      decoration: BoxDecoration(
                                        color:
                                            message.isUser
                                                ? AppColors.buttonColor2
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
                                            ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              child: Image.file(
                                                File(message.imageUrl),
                                                width: 250,
                                                height: 250,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          if (message.message.isNotEmpty)
                                            Text(
                                              message.message,
                                              style: getTextStyle(
                                                color: AppColors.primary,
                                                fontSize: 16,
                                              ),
                                              softWrap: true,
                                            ),

                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              Text(
                                                message.time,
                                                style: const TextStyle(
                                                  color: AppColors.primary,
                                                  fontSize: 12,
                                                ),
                                              ),
                                              SizedBox(width: 5),
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
              ),
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
                } else {
                  return SizedBox.shrink();
                }
              }),

              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
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
                          fillColor: AppColors.textFrieldDarkColor,
                          filled: true,
                          suffixIcon: Obx(
                            () => GestureDetector(
                              onTap: () {
                                if (controller.selectedImage.value != null) {
                                  controller.sendImage();
                                } else if (controller
                                    .messageText
                                    .value
                                    .isNotEmpty) {
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
                                          controller
                                              .messageText
                                              .value
                                              .isNotEmpty
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
                              controller.isEmojiVisible.value =
                                  !controller.isEmojiVisible.value;
                            },
                            child: CircleAvatar(
                              backgroundColor: Colors.transparent,
                              radius: 12,
                              child: Image.asset(
                                IconPath.chatemoji,
                                width: 24,
                                height: 24,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Obx(() {
                if (controller.isEmojiVisible.value) {
                  return EmojiPicker(
                    onEmojiSelected: (Category, emoji) {
                      controller.messageController.text += emoji.emoji;
                      controller.messageText.value =
                          controller.messageController.text;
                    },
                  );
                } else {
                  return SizedBox.shrink();
                }
              }),
            ],
          ),
        ),
      );
    });
  }
}
