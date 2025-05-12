import 'package:blinqo/features/role/venue_owner/venue_chat_page/model/chat_model.dart';
import 'package:blinqo/features/role/venue_owner/venue_chat_page/model/group_model.dart';

enum ChatType { personal, group }

class UnifiedChat {
  final ChatType type;
  final ChatPreview? personalChat;
  final GroupChatPreview? groupChat;

  UnifiedChat.personal(this.personalChat)
    : type = ChatType.personal,
      groupChat = null;

  UnifiedChat.group(this.groupChat)
    : type = ChatType.group,
      personalChat = null;

  // Helper to get last message timestamp for sorting
  int get lastMessageTimestamp =>
      type == ChatType.personal
          ? personalChat!.lastMessage.timestamp.toInt()
          : groupChat!.lastMessage.timestamp;

  // Helper to get display name
  String get displayName =>
      type == ChatType.personal
          ? personalChat!.user.name
          : groupChat!.group.name;

  // Helper to get avatar
  String get avatar =>
      type == ChatType.personal
          ? personalChat!.user.avatar
          : groupChat!.group.avatar;

  // Helper to get unread count
  int get unreadCount =>
      type == ChatType.personal
          ? personalChat!.unreadCount
          : groupChat!.unreadCount;

  // Helper to get last message
  Message get lastMessage =>
      type == ChatType.personal
          ? personalChat!.lastMessage
          : groupChat!.lastMessage;

  // Helper to get online status (for personal chats only)
  bool get isOnline => type == ChatType.personal && personalChat!.user.isOnline;
}
