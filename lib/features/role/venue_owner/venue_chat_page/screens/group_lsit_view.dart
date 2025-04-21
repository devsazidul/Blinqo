import 'package:blinqo/features/role/venue_owner/venue_chat_page/model/chat_model.dart';
import 'package:blinqo/features/role/venue_owner/venue_chat_page/model/group_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:io';
import '../controllers/group_controller.dart';
import '../controllers/chat_controller.dart';
import '../utils/date_utils.dart';
import 'group_chat_view.dart';
import 'create_group_view.dart';

class GroupListView extends StatelessWidget {
  final GroupController groupController = Get.find<GroupController>();
  final ChatController chatController = Get.find<ChatController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Group Chats',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        actions: [
          IconButton(
            icon: Icon(Icons.group_add),
            onPressed: () => Get.to(() => CreateGroupView()),
          ),
        ],
      ),
      body: Obx(() {
        final groupChats = groupController.groupChats;

        if (groupChats.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'No group conversations yet',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[600],
                  ),
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () => Get.to(() => CreateGroupView()),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF0A2647),
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: Text('Create a Group'),
                ),
              ],
            ),
          );
        }

        return ListView.builder(
          itemCount: groupChats.length,
          itemBuilder: (context, index) {
            return GroupChatListItem(
              groupChat: groupChats[index],
              onTap: () {
                groupController.setActiveGroup(groupChats[index].group.id);
                Get.to(() => GroupChatView(groupId: groupChats[index].group.id));
              },
            );
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.to(() => CreateGroupView()),
        backgroundColor: Color(0xFF0A2647),
        child: Icon(Icons.group_add, color: Colors.white),
      ),
    );
  }
}

class GroupChatListItem extends StatelessWidget {
  final GroupChatPreview groupChat;
  final VoidCallback onTap;

  const GroupChatListItem({
    Key? key,
    required this.groupChat,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final group = groupChat.group;
    final lastMessage = groupChat.lastMessage;

    // Get sender name for the last message
    String senderName = '';
    if (lastMessage.senderId != 'system') {
      final ChatController chatController = Get.find<ChatController>();
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
        messagePreview = lastMessage.text.length > 30
            ? '$senderName${lastMessage.text.substring(0, 30 - senderName.length)}...'
            : '$senderName${lastMessage.text}';
        break;
      case MessageType.image:
        messagePreview = '$senderName📷 Image';
        break;
      case MessageType.audio:
        messagePreview = '$senderName🎵 Audio';
        break;
    }

    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Colors.grey[200]!,
              width: 1,
            ),
          ),
        ),
        child: Row(
          children: [
            // Group avatar
            CircleAvatar(
              radius: 25,
              backgroundImage: group.avatar.startsWith('http')
                  ? NetworkImage(group.avatar)
                  : FileImage(File(group.avatar)) as ImageProvider,
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
                        group.name,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        ChatDateUtils.formatMessageTime(lastMessage.timestamp),
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[600],
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
                          style: TextStyle(
                            fontSize: 14,
                            color: groupChat.unreadCount > 0
                                ? Colors.black
                                : Colors.grey[600],
                            fontWeight: groupChat.unreadCount > 0
                                ? FontWeight.w500
                                : FontWeight.normal,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (groupChat.unreadCount > 0)
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
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
                              groupChat.unreadCount.toString(),
                              style: TextStyle(
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