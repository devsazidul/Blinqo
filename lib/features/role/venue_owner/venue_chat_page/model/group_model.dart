
import 'chat_model.dart';

class Group {
  final String id;
  final String name;
  final String avatar;
  final bool isOnline;
  final List<String> memberIds;
  final String creatorId;
  final int createdAt;

  Group({
    required this.id,
    required this.name,
    required this.avatar,
    this.isOnline = true,
    required this.memberIds,
    required this.creatorId,
    required this.createdAt,
  });
}

class GroupMessage extends Message {
  final String groupId;

  GroupMessage({
    required String id,
    required String senderId,
    required this.groupId,
    required String text,
    required int timestamp,
    required bool isRead,
    required MessageType type,
    String? mediaUrl,
    String? audioDuration,
  }) : super(
    id: id,
    senderId: senderId,
    receiverId: groupId, // Using groupId as receiverId for consistency
    text: text,
    timestamp: timestamp,
    isRead: isRead,
    type: type,
    mediaUrl: mediaUrl,
    audioDuration: audioDuration,
  );
}

class GroupChatPreview {
  final Group group;
  final Message lastMessage;
  final int unreadCount;

  GroupChatPreview({
    required this.group,
    required this.lastMessage,
    required this.unreadCount,
  });
}