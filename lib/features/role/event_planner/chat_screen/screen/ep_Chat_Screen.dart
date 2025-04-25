import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:blinqo/core/utils/constants/image_path.dart';
import 'package:blinqo/features/role/event_planner/chat_screen/controller/ep_chat_controller.dart';
import 'package:blinqo/features/role/event_planner/chat_screen/screen/chat_details.dart';
import 'package:blinqo/features/role/event_planner/chat_screen/widget/date_picker.dart';
import 'package:blinqo/features/role/service_provider/service_profile_page/controller/service_user_profile_controler.dart';
import 'package:blinqo/features/role/venue_owner/venue_chat_page/model/chat_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EpChatScreen extends StatelessWidget {
  final EpChatController epChatController = Get.put(EpChatController());
  final themeController = Get.put(SpProfileController());

  EpChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final themeMode =
          themeController.isDarkMode.value ? ThemeMode.dark : ThemeMode.light;
      return Scaffold(
        backgroundColor:
            themeMode == ThemeMode.dark
                ? AppColors.darkBackgroundColor
                : AppColors.backgroundColor,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          forceMaterialTransparency: true,
          centerTitle: true,
          title: Text(
            'Chat',
            style: getTextStyle(
              fontSize: 32,
              fontWeight: FontWeight.w600,
              color:
                  themeMode == ThemeMode.dark
                      ? AppColors.borderColor2
                      : AppColors.textColor,
            ),
          ),
          elevation: 0,
          backgroundColor:
              themeMode == ThemeMode.dark
                  ? AppColors.darkBackgroundColor
                  : AppColors.backgroundColor,
        ),

        body: Obx(() {
          final chats = epChatController.chats;

          if (chats.isEmpty) {
            return SafeArea(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      ImagePath.nocontentbackground,
                      height: 250,
                      width: 230,
                    ),
                    Text(
                      'No conversations yet',
                      style: getTextStyle(
                        fontSize: 16,
                        color: AppColors.textColor,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }

          return ListView.builder(
            itemCount: chats.length,
            itemBuilder: (context, index) {
              return ChatList(
                themeMode: themeMode,
                chat: chats[index],
                onTap: () {
                  epChatController.setActiveChat(chats[index].id);
                  Get.to(() => ChatDetails(chatId: chats[index].id));
                },
              );
            },
          );
        }),
      );
    });
  }
}

class ChatList extends StatelessWidget {
  final ChatPreview chat;
  final VoidCallback onTap;
  final ThemeMode? themeMode;

  const ChatList({
    super.key,
    required this.chat,
    required this.onTap,
    this.themeMode,
  });

  @override
  Widget build(BuildContext context) {
    final user = chat.user;
    final lastMessage = chat.lastMessage;
    String messagePreview;
    switch (lastMessage.type) {
      case MessageType.text:
        messagePreview =
            lastMessage.text.length > 30
                ? '${lastMessage.text.substring(0, 25)}...'
                : lastMessage.text;
        break;
      case MessageType.image:
        messagePreview = '📷 Image';
        break;
      case MessageType.audio:
        messagePreview = '';
        break;
    }

    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        child: Row(
          children: [
            Stack(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.grey[300],
                  radius: 25,
                  backgroundImage: NetworkImage(user.avatar),
                ),
              ],
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        user.name,
                        style: getTextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color:
                              themeMode == ThemeMode.dark
                                  ? AppColors.borderColor2
                                  : AppColors.textColor,
                        ),
                      ),
                      Text(
                        DatePicker.formatMessageTime(
                          lastMessage.timestamp.toInt(),
                        ),
                        style: getTextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: AppColors.subTextColor2,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 4),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          messagePreview,
                          style: getTextStyle(
                            fontSize: 14,
                            color:
                                chat.unreadCount > 0
                                    ? AppColors.subTextColor
                                    : AppColors.subTextColor,
                            fontWeight:
                                chat.unreadCount > 0
                                    ? FontWeight.w400
                                    : FontWeight.w400,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
