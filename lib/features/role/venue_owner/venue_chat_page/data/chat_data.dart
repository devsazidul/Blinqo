import 'package:blinqo/features/role/venue_owner/venue_chat_page/model/chat_model.dart';
import 'package:flutter/material.dart';

class ChatData {
  static final User currentUser = User(
    id: "current-user",
    name: "Current User",
    avatar: "https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=80",
    isOnline: true,
  );

  static final List<User> users = [
    User(
      id: "1",
      name: "Floyd Miles",
      avatar: "https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=80",
      isOnline: false,
    ),
    User(
      id: "2",
      name: "Samantha Green",
      avatar: "https://images.unsplash.com/photo-1438761681033-6461ffad8d80?ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=80",
      isOnline: true,
    ),
    User(
      id: "3",
      name: "Oliver Smith",
      avatar: "https://images.unsplash.com/photo-1500648767791-00dcc994a43e?ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=80",
      isOnline: false,
    ),
    User(
      id: "4",
      name: "Isabella Johnson",
      avatar: "https://images.unsplash.com/photo-1544005313-94ddf0286df2?ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=80",
      isOnline: true,
    ),
    User(
      id: "5",
      name: "Liam Brown",
      avatar: "https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=80",
      isOnline: false,
    ),
    User(
      id: "6",
      name: "Mia Wilson",
      avatar: "https://images.unsplash.com/photo-1554151228-14d9def656e4?ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=80",
      isOnline: true,
    ),
    User(
      id: "7",
      name: "Noah Garcia",
      avatar: "https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=80",
      isOnline: false,
    ),
    User(
      id: "8",
      name: "Emma Martinez",
      avatar: "https://images.unsplash.com/photo-1534528741775-53994a69daeb?ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=80",
      isOnline: true,
    ),
    User(
      id: "9",
      name: "Ava Taylor",
      avatar: "https://images.unsplash.com/photo-1546456073-6712f79251bb?ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=80",
      isOnline: false,
    ),
  ];

  static final Map<String, List<Message>> messages = {
    "2": [
      Message(
        id: "m1",
        senderId: "2",
        receiverId: "current-user",
        text: "Hi, I'm Alex! Today, I'm here to assist you in finding the perfect Webflow Template! 👋",
        timestamp: DateTime.now().millisecondsSinceEpoch - 3600000 * 2,
        isRead: true,
        type: MessageType.text,
      ),
      Message(
        id: "m2",
        senderId: "current-user",
        receiverId: "2",
        text: "",
        timestamp: DateTime.now().millisecondsSinceEpoch - (3600000 * 1.5).toInt(),
        isRead: true,
        type: MessageType.image,
        mediaUrl: "https://images.unsplash.com/photo-1481349518771-20055b2a7b24?ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=80",
      ),
      Message(
        id: "m3",
        senderId: "2",
        receiverId: "current-user",
        text: "Hello!",
        timestamp: DateTime.now().millisecondsSinceEpoch - 3600000 * 1,
        isRead: true,
        type: MessageType.text,
      ),
      Message(
        id: "m4",
        senderId: "current-user",
        receiverId: "2",
        text: "",
        timestamp: DateTime.now().millisecondsSinceEpoch - (3600000 * 0.8).toInt(),
        isRead: true,
        type: MessageType.audio,
        mediaUrl: "audio-url",
        audioDuration: "0:05",
      ),
      Message(
        id: "m5",
        senderId: "2",
        receiverId: "current-user",
        text: "Hello! It's great to meet you!",
        timestamp: DateTime.now().millisecondsSinceEpoch - (3600000 * 0.5).toInt(),
        isRead: true,
        type: MessageType.text,
      ),
      Message(
        id: "m6",
        senderId: "current-user",
        receiverId: "2",
        text: "Hey, I'm Alex! Today, I'm excited to guide you in discovering the ideal Webflow Template for your needs! 👋",
        timestamp: DateTime.now().millisecondsSinceEpoch - (3600000 * 0.2).toInt(),
        isRead: false,
        type: MessageType.text,
      ),
    ],
    "1": [
      Message(
        id: "m7",
        senderId: "1",
        receiverId: "current-user",
        text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
        timestamp: DateTime.now().millisecondsSinceEpoch - 3600000 * 5,
        isRead: true,
        type: MessageType.text,
      ),
    ],
    "3": [
      Message(
        id: "m8",
        senderId: "3",
        receiverId: "current-user",
        text: "Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
        timestamp: DateTime.now().millisecondsSinceEpoch - 3600000 * 8,
        isRead: true,
        type: MessageType.text,
      ),
    ],
    "4": [
      Message(
        id: "m9",
        senderId: "4",
        receiverId: "current-user",
        text: "Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris.",
        timestamp: DateTime.now().millisecondsSinceEpoch - 3600000 * 10,
        isRead: true,
        type: MessageType.text,
      ),
    ],
    "5": [
      Message(
        id: "m10",
        senderId: "5",
        receiverId: "current-user",
        text: "Quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.",
        timestamp: DateTime.now().millisecondsSinceEpoch - 3600000 * 12,
        isRead: true,
        type: MessageType.text,
      ),
    ],
    "6": [
      Message(
        id: "m11",
        senderId: "6",
        receiverId: "current-user",
        text: "Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.",
        timestamp: DateTime.now().millisecondsSinceEpoch - 3600000 * 15,
        isRead: true,
        type: MessageType.text,
      ),
    ],
    "7": [
      Message(
        id: "m12",
        senderId: "7",
        receiverId: "current-user",
        text: "In reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.",
        timestamp: DateTime.now().millisecondsSinceEpoch - 3600000 * 18,
        isRead: true,
        type: MessageType.text,
      ),
    ],
    "8": [
      Message(
        id: "m13",
        senderId: "8",
        receiverId: "current-user",
        text: "Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
        timestamp: DateTime.now().millisecondsSinceEpoch - 3600000 * 20,
        isRead: true,
        type: MessageType.text,
      ),
    ],
    "9": [
      Message(
        id: "m14",
        senderId: "9",
        receiverId: "current-user",
        text: "Laboris nisi ut aliquip ex ea commodo consequat.",
        timestamp: DateTime.now().millisecondsSinceEpoch - 3600000 * 22,
        isRead: true,
        type: MessageType.text,
      ),
    ],
  };

  static List<ChatPreview> getChatPreviews() {
    return users.map((user) {
      final userMessages = messages[user.id] ?? [];
      final lastMessage = userMessages.isNotEmpty ? userMessages.last : Message(
        id: "default",
        senderId: user.id,
        receiverId: "current-user",
        text: "No messages yet",
        timestamp: DateTime.now().millisecondsSinceEpoch,
        isRead: true,
        type: MessageType.text,
      );

      return ChatPreview(
        id: user.id,
        user: user,
        lastMessage: lastMessage,
        unreadCount: userMessages.where((msg) => msg.senderId == user.id && !msg.isRead).length,
      );
    }).toList()
      ..sort((a, b) => b.lastMessage.timestamp.compareTo(a.lastMessage.timestamp));
  }
}