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
    required super.id,
    required super.senderId,
    required this.groupId,
    required super.text,
    required super.timestamp,
    required super.isRead,
    required super.type,
    super.mediaUrl,
    super.audioDuration,
  }) : super(receiverId: groupId);
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
