import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:blinqo/core/utils/constants/image_path.dart';
import 'package:blinqo/features/role/venue_owner/venue_chat_page/model/chat_model.dart';
import 'package:blinqo/features/role/venue_owner/venue_chat_page/screens/chat_details_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/chat_controller.dart';
import '../utils/date_utils.dart';

class ChatListView extends StatelessWidget {
  final ChatController chatController = Get.put(ChatController());

  ChatListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /*appBar: AppBar(
        automaticallyImplyLeading: false,
        forceMaterialTransparency: true,
        centerTitle: true,
        // title: Text(
        //   'Chat',
        //   style: getTextStyle(
        //     fontSize: 32,
        //     fontWeight: FontWeight.w600,
        //     color: Color(0xFF333333),
        //   ),
        // ),
        elevation: 0,
        backgroundColor: AppColors.backgroundColor,
      ),*/

      body: Obx(() {
        final chats = chatController.chats;

        /* If there are no chats, show a message */
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
                    style: getTextStyle(fontSize: 16, color: Color(0xFF333333)),
                  ),
                ],
              ),
            ),
          );
        }

        /* If there are chats, show them */
        return ListView.builder(
          itemCount: chats.length,
          itemBuilder: (context, index) {
            return ChatListItem(
              chat: chats[index],
              onTap: () {
                chatController.setActiveChat(chats[index].id);
                Get.to(() => ChatDetailView(chatId: chats[index].id));
              },
            );
          },
        );
      }),
    );
  }
}

// Widget to display a chat list item
class ChatListItem extends StatelessWidget {
  final ChatPreview chat;
  final VoidCallback onTap;

  const ChatListItem({super.key, required this.chat, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final user = chat.user;
    final lastMessage = chat.lastMessage;

    // Truncate message text if too long
    String messagePreview;
    switch (lastMessage.type) {
      case MessageType.text:
        messagePreview =
            lastMessage.text.length > 30
                ? '${lastMessage.text.substring(0, 30)}...'
                : lastMessage.text;
        break;
      case MessageType.image:
        messagePreview = '📷 Image';
        break;
      case MessageType.audio:
        messagePreview = '🎵 Audio';
        break;
    }

    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),

        child: Row(
          children: [
            // Avatar with online indicator
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
            // Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Name and time
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
                      // time
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
                  // Message preview and unread count
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

                      // Unread count
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
