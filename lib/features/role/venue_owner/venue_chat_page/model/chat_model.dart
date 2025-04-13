import 'package:get/get.dart';

class User {
  final String id;
  final String name;
  final String avatar;
  final bool isOnline;

  User({
    required this.id,
    required this.name,
    required this.avatar,
    required this.isOnline,
  });
}

class Message {
  final String id;
  final String senderId;
  final String receiverId;
  final String text;
  final int timestamp;
  final bool isRead;
  final MessageType type;
  final String? mediaUrl;
  final String? audioDuration;

  Message({
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

class ChatPreview {
  final String id;
  final User user;
  final Message lastMessage;
  final int unreadCount;

  ChatPreview({
    required this.id,
    required this.user,
    required this.lastMessage,
    required this.unreadCount,
  });
}

enum MessageType {
  text,
  image,
  audio,
}