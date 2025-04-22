import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/utils/constants/image_path.dart';
import 'package:blinqo/features/role/venue_owner/profile_page/controller/venue_owner_profile_controller.dart';
import 'package:blinqo/features/role/venue_owner/venue_chat_page/model/chat_model.dart';
import 'package:blinqo/features/role/venue_owner/venue_chat_page/model/unified_chat_model.dart';
import 'package:blinqo/features/role/venue_owner/venue_chat_page/screens/chat_details_view.dart';
import 'package:blinqo/features/role/venue_owner/venue_chat_page/screens/group_chat_view.dart';
import 'package:blinqo/features/role/venue_owner/venue_chat_page/screens/create_group_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:io';
import '../controllers/chat_controller.dart';
import '../controllers/group_controller.dart';
import '../utils/date_utils.dart';

class ChatListView extends StatelessWidget {
  final ChatController chatController = Get.put(ChatController());
  final GroupController groupController = Get.put(GroupController());

  ChatListView({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode =
        Get.put(VenueOwnerProfileController()).isDarkMode.value;
    return Scaffold(
      backgroundColor: isDarkMode ? Color(0xff151515) : Color(0xffF4F4F4),
      appBar: AppBar(
        title: Text(
          'Chat',
          style: getTextStyle(
            fontSize: 32,
            fontWeight: FontWeight.w600,
            color: isDarkMode ? Color(0xffEBEBEB) : Color(0xff333333),
          ),
        ),
        centerTitle: true,
        backgroundColor: isDarkMode ? Color(0xff151515) : Color(0xffF4F4F4),
        automaticallyImplyLeading: false,
        forceMaterialTransparency:true,
      ),

      body: Obx(() {
        // Combine personal and group chats
        final personalChats =
            chatController.chats
                .map((chat) => UnifiedChat.personal(chat))
                .toList();
        final groupChats =
            groupController.groupChats
                .map((chat) => UnifiedChat.group(chat))
                .toList();
        final allChats = [...personalChats, ...groupChats]..sort(
          (a, b) => b.lastMessageTimestamp.compareTo(a.lastMessageTimestamp),
        );

        if (allChats.isEmpty) {
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
                      color: const Color(0xFF333333),
                    ),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => Get.to(() => CreateGroupView()),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF205295),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: Text(
                      'Create a Group',
                      style: getTextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }

        return ListView.builder(
          itemCount: allChats.length,
          itemBuilder: (context, index) {
            final unifiedChat = allChats[index];
            return UnifiedChatListItem(
              unifiedChat: unifiedChat,
              onTap: () {
                if (unifiedChat.type == ChatType.personal) {
                  chatController.setActiveChat(unifiedChat.personalChat!.id);
                  Get.to(
                    () => ChatDetailView(chatId: unifiedChat.personalChat!.id),
                  );
                } else {
                  groupController.setActiveGroup(
                    unifiedChat.groupChat!.group.id,
                  );
                  Get.to(
                    () =>
                        GroupChatView(groupId: unifiedChat.groupChat!.group.id),
                  );
                }
              },
            );
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.to(() => CreateGroupView()),
        backgroundColor: const Color(0xFF205295),
        child: const Icon(Icons.group_add, color: Colors.white),
      ),
    );
  }
}

class UnifiedChatListItem extends StatelessWidget {
  final UnifiedChat unifiedChat;
  final VoidCallback onTap;

  const UnifiedChatListItem({
    super.key,
    required this.unifiedChat,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode =
        Get.put(VenueOwnerProfileController()).isDarkMode.value;
    final lastMessage = unifiedChat.lastMessage;
    final isGroup = unifiedChat.type == ChatType.group;

    // Get sender name for group chats
    String senderName = '';
    if (isGroup && lastMessage.senderId != 'system') {
      final chatController = Get.find<ChatController>();
      if (lastMessage.senderId == chatController.currentUser.value.id) {
        senderName = 'You: ';
      } else {
        final sender = chatController.getUserById(lastMessage.senderId);
        if (sender != null) {
          senderName = '${sender.name.split(' ')[0]}: ';
        }
      }
    }

    // Truncate message text if too long
    String messagePreview;
    switch (lastMessage.type) {
      case MessageType.text:
        final text =
            isGroup ? '$senderName${lastMessage.text}' : lastMessage.text;
        messagePreview =
            text.length > 30 ? '${text.substring(0, 30)}...' : text;
        break;
      case MessageType.image:
        messagePreview = isGroup ? '$senderName📷 Image' : '📷 Image';
        break;
      case MessageType.audio:
        messagePreview = isGroup ? '$senderName🎵 Audio' : '🎵 Audio';
        break;
    }

    return InkWell(
      onTap: onTap,
      child: Container(
        color: isDarkMode ? Color(0xff151515) : Color(0xffF4F4F4),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        child: Row(
          children: [
            // Avatar with online or group indicator
            Stack(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.grey[300],
                  radius: 25,
                  backgroundImage:
                      unifiedChat.avatar.startsWith('http')
                          ? NetworkImage(unifiedChat.avatar)
                          : FileImage(File(unifiedChat.avatar))
                              as ImageProvider,
                ),
                if (unifiedChat.isOnline)
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: Container(
                      width: 12,
                      height: 12,
                      decoration: BoxDecoration(
                        color: Colors.green,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: isDarkMode ? Color(0xff151515) : Colors.white,
                          width: 2,
                        ),
                      ),
                    ),
                  ),
                if (isGroup)
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: Container(
                      width: 12,
                      height: 12,
                      decoration: BoxDecoration(
                        color: const Color(0xFF205295),
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: isDarkMode ? Color(0xff151515) : Colors.white,
                          width: 2,
                        ),
                      ),
                      child: const Icon(
                        Icons.group,
                        size: 8,
                        color: Colors.white,
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(width: 16),
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
                        unifiedChat.displayName,
                        style: getTextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color:
                              isDarkMode
                                  ? Color(0xffEBEBEB)
                                  : Color(0xff333333),
                          lineHeight: 0,
                        ),
                      ),
                      Text(
                        ChatDateUtils.formatMessageTime(
                          lastMessage.timestamp.toInt(),
                        ),
                        style: getTextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color:
                              isDarkMode
                                  ? Color(0xffABB7C2)
                                  : Color(0xFFABB7C2),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  // Message preview and unread count
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          messagePreview,
                          style: getTextStyle(
                            fontSize: 14,
                            color:
                                isDarkMode
                                    ? Color(0xff767676)
                                    : unifiedChat.unreadCount > 0
                                    ? Colors.black
                                    : const Color(0xff767676),
                            fontWeight:
                                unifiedChat.unreadCount > 0
                                    ? FontWeight.w500
                                    : FontWeight.w400,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (unifiedChat.unreadCount > 0)
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFF205295),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          constraints: const BoxConstraints(
                            minWidth: 20,
                            minHeight: 20,
                          ),
                          child: Center(
                            child: Text(
                              unifiedChat.unreadCount.toString(),
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
