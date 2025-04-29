class ChatUserModel {
  final String id;
  final String name;
  final String avatar;
  final bool isOnline;

  ChatUserModel({
    required this.id,
    required this.name,
    required this.avatar,
    required this.isOnline,
  });
}

class MessageModel {
  final String id;
  final String senderId;
  final String receiverId;
  final String text;
  final int timestamp;
  final bool isRead;
  final MessageType type;
  final String? mediaUrl;
  final String? audioDuration;

  MessageModel({
    required this.id,
    required this.senderId,
    required this.receiverId,
    required this.text,
    required this.timestamp,
    required this.isRead,
    required this.type,
    this.mediaUrl,
    this.audioDuration,
  });
}

class ChatPreviewModel {
  final String id;
  final ChatUserModel user;
  final MessageModel lastMessage;
  final int unreadCount;

  ChatPreviewModel({
    required this.id,
    required this.user,
    required this.lastMessage,
    required this.unreadCount,
  });
}

enum MessageType { text, image }
