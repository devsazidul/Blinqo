import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:blinqo/core/utils/constants/image_path.dart';
import 'package:blinqo/features/role/event_planner/chat_screen/screen/chat_details.dart';
import 'package:blinqo/features/role/venue_owner/venue_chat_page/controllers/chat_controller.dart';
import 'package:blinqo/features/role/venue_owner/venue_chat_page/model/chat_model.dart';
import 'package:blinqo/features/role/venue_owner/venue_chat_page/utils/date_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EpChatScreen extends StatelessWidget {
  final ChatController chatController = Get.put(ChatController());

  EpChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        forceMaterialTransparency: true,
        centerTitle: true,
        title: Text(
          'Chat',
          style: getTextStyle(
            fontSize: 32,
            fontWeight: FontWeight.w600,
            color: AppColors.textColor,
          ),
        ),
        elevation: 0,
        backgroundColor: AppColors.backgroundColor,
      ),

      body: Obx(() {
        final chats = chatController.chats;

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
              chat: chats[index],
              onTap: () {
                chatController.setActiveChat(chats[index].id);
                Get.to(() => ChatDetails(chatId: chats[index].id));
              },
            );
          },
        );
      }),
    );
  }
}

class ChatList extends StatelessWidget {
  final ChatPreview chat;
  final VoidCallback onTap;

  const ChatList({super.key, required this.chat, required this.onTap});

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
                if (user.isOnline)
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: Container(
                      width: 12,
                      height: 12,
                      decoration: BoxDecoration(
                        color: Colors.green,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2),
                      ),
                    ),
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
                        ),
                      ),
                      Text(
                        ChatDateUtils.formatMessageTime(
                          lastMessage.timestamp.toInt(),
                        ),
                        style: getTextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFFABB7C2),
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
                                    ? Colors.black
                                    : Color(0xff767676),
                            fontWeight:
                                chat.unreadCount > 0
                                    ? FontWeight.w500
                                    : FontWeight.w400,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),

                      if (chat.unreadCount > 0)
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: Color(0xFF205295),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          constraints: BoxConstraints(
                            minWidth: 20,
                            minHeight: 20,
                          ),
                          child: Center(
                            child: Text(
                              chat.unreadCount.toString(),
                              style: getTextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
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
