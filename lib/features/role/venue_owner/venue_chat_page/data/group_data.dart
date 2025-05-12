import 'package:blinqo/features/role/venue_owner/venue_chat_page/data/chat_data.dart';
import 'package:blinqo/features/role/venue_owner/venue_chat_page/model/chat_model.dart';
import 'package:blinqo/features/role/venue_owner/venue_chat_page/model/group_model.dart';

class GroupData {
  static final List<Group> groups = [
    Group(
      id: "g1",
      name: "Birthday Group",
      avatar:
          "https://images.unsplash.com/photo-1513151233558-d860c5398176?ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=80",
      isOnline: true,
      memberIds: ["current-user", "1", "2", "3", "4", "5", "6", "7", "8"],
      creatorId: "current-user",
      createdAt:
          DateTime.now().millisecondsSinceEpoch - 86400000 * 30, // 30 days ago
    ),
    Group(
      id: "g2",
      name: "Work Team",
      avatar:
          "https://images.unsplash.com/photo-1542744173-8e7e53415bb0?ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=80",
      isOnline: true,
      memberIds: ["current-user", "1", "3", "5", "7"],
      creatorId: "1",
      createdAt:
          DateTime.now().millisecondsSinceEpoch - 86400000 * 60, // 60 days ago
    ),
    Group(
      id: "g3",
      name: "Family",
      avatar:
          "https://images.unsplash.com/photo-1511895426328-dc8714191300?ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=80",
      isOnline: true,
      memberIds: ["current-user", "2", "4", "6"],
      creatorId: "current-user",
      createdAt:
          DateTime.now().millisecondsSinceEpoch - 86400000 * 90, // 90 days ago
    ),
  ];

  static final Map<String, List<GroupMessage>> groupMessages = {
    "g1": [
      GroupMessage(
        id: "gm1",
        senderId: "2",
        groupId: "g1",
        text: "Hey everyone! Let's plan the birthday party!",
        timestamp: DateTime.now().millisecondsSinceEpoch - 3600000 * 24,
        isRead: true,
        type: MessageType.text,
      ),
      GroupMessage(
        id: "gm2",
        senderId: "current-user",
        groupId: "g1",
        text: "Great idea! When should we do it?",
        timestamp: DateTime.now().millisecondsSinceEpoch - 3600000 * 23,
        isRead: true,
        type: MessageType.text,
      ),
      GroupMessage(
        id: "gm3",
        senderId: "3",
        groupId: "g1",
        text: "How about next Saturday?",
        timestamp: DateTime.now().millisecondsSinceEpoch - 3600000 * 22,
        isRead: true,
        type: MessageType.text,
      ),
      GroupMessage(
        id: "gm4",
        senderId: "4",
        groupId: "g1",
        text: "",
        timestamp: DateTime.now().millisecondsSinceEpoch - 3600000 * 20,
        isRead: true,
        type: MessageType.image,
        mediaUrl:
            "https://images.unsplash.com/photo-1464349153735-7db50ed83c84?ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=80",
      ),
      GroupMessage(
        id: "gm5",
        senderId: "1",
        groupId: "g1",
        text: "This looks like a great venue!",
        timestamp: DateTime.now().millisecondsSinceEpoch - 3600000 * 19,
        isRead: true,
        type: MessageType.text,
      ),
      GroupMessage(
        id: "gm6",
        senderId: "current-user",
        groupId: "g1",
        text: "I agree, let's book it!",
        timestamp: DateTime.now().millisecondsSinceEpoch - 3600000 * 18,
        isRead: true,
        type: MessageType.text,
      ),
    ],
    "g2": [
      GroupMessage(
        id: "gm7",
        senderId: "1",
        groupId: "g2",
        text: "Team meeting at 10 AM tomorrow",
        timestamp: DateTime.now().millisecondsSinceEpoch - 3600000 * 10,
        isRead: true,
        type: MessageType.text,
      ),
      GroupMessage(
        id: "gm8",
        senderId: "current-user",
        groupId: "g2",
        text: "I'll prepare the presentation",
        timestamp: DateTime.now().millisecondsSinceEpoch - 3600000 * 9,
        isRead: true,
        type: MessageType.text,
      ),
    ],
    "g3": [
      GroupMessage(
        id: "gm9",
        senderId: "2",
        groupId: "g3",
        text: "Who's coming to dinner this weekend?",
        timestamp: DateTime.now().millisecondsSinceEpoch - 3600000 * 5,
        isRead: true,
        type: MessageType.text,
      ),
      GroupMessage(
        id: "gm10",
        senderId: "current-user",
        groupId: "g3",
        text: "I'll be there!",
        timestamp: DateTime.now().millisecondsSinceEpoch - 3600000 * 4,
        isRead: true,
        type: MessageType.text,
      ),
    ],
  };

  static List<GroupChatPreview> getGroupChatPreviews() {
    return groups.map((group) {
        final groupMsgs = groupMessages[group.id] ?? [];
        final lastMessage =
            groupMsgs.isNotEmpty
                ? groupMsgs.last
                : GroupMessage(
                  id: "default",
                  senderId: "system",
                  groupId: group.id,
                  text: "Group created",
                  timestamp: group.createdAt,
                  isRead: true,
                  type: MessageType.text,
                );

        // Count unread messages for current user
        final unreadCount =
            groupMsgs
                .where(
                  (msg) =>
                      msg.senderId != ChatData.currentUser.id && !msg.isRead,
                )
                .length;

        return GroupChatPreview(
          group: group,
          lastMessage: lastMessage,
          unreadCount: unreadCount,
        );
      }).toList()
      ..sort(
        (a, b) => b.lastMessage.timestamp.compareTo(a.lastMessage.timestamp),
      );
  }
}
