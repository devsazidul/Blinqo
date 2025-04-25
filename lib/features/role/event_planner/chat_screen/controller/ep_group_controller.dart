// import 'package:blinqo/features/role/venue_owner/venue_chat_page/data/chat_data.dart';
// import 'package:blinqo/features/role/venue_owner/venue_chat_page/data/group_data.dart';
// import 'package:blinqo/features/role/venue_owner/venue_chat_page/model/chat_model.dart';
// import 'package:blinqo/features/role/venue_owner/venue_chat_page/model/group_model.dart';
// import 'package:get/get.dart';

// class EpGroupController extends GetxController {
//   final Rx<User> currentUser = ChatData.currentUser.obs;
//   final RxList<Group> groups = GroupData.groups.obs;
//   //  final RxList<User> users = ChatData.users.obs;
//   final RxList<GroupChatPreview> groupChats = <GroupChatPreview>[].obs;
//   final RxMap<String, List<GroupMessage>> groupMessages =
//       <String, List<GroupMessage>>{}.obs;

//   Group? getGroupById(String groupId) {
//     try {
//       return groups.firstWhere((group) => group.id == groupId);
//     } catch (e) {
//       return null;
//     }
//   }

//   void _addMessageToGroup(String groupId, GroupMessage newMessage) {
//     // Update messages
//     final List<GroupMessage> chatMessages = List<GroupMessage>.from(
//       groupMessages[groupId] ?? [],
//     );
//     chatMessages.add(newMessage);
//     groupMessages[groupId] = chatMessages;

//     // Update group chat previews
//     final updatedGroupChats =
//         groupChats.map((chat) {
//           if (chat.group.id == groupId) {
//             return GroupChatPreview(
//               group: chat.group,
//               lastMessage: newMessage,
//               unreadCount: chat.unreadCount,
//             );
//           }
//           return chat;
//         }).toList();

//     // Sort chats by latest message
//     updatedGroupChats.sort(
//       (a, b) => b.lastMessage.timestamp.compareTo(a.lastMessage.timestamp),
//     );
//     groupChats.value = updatedGroupChats;

//     update(); // Add this to trigger GetBuilder updates
//   }

//   List<User> getGroupMembers(String groupId) {
//     final group = getGroupById(groupId);
//     if (group == null) return [];

//     return group.memberIds.map((memberId) {
//       if (memberId == currentUser.value.id) {
//         return currentUser.value;
//       }
//       return ChatData.users.firstWhere(
//         (user) => user.id == memberId,
//         orElse:
//             () => User(
//               id: memberId,
//               name: "Unknown User",
//               avatar:
//                   "https://images.unsplash.com/photo-1511367461989-f85a21fda167?ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=80",
//               isOnline: false,
//             ),
//       );
//     }).toList();
//   }

//   void removeMemberFromGroup(String groupId, String userId) {
//     final group = getGroupById(groupId);
//     if (group == null) return;

//     // Check if current user is the creator
//     if (group.creatorId != currentUser.value.id) {
//       Get.snackbar(
//         'Error',
//         'Only the group creator can remove members',
//         snackPosition: SnackPosition.BOTTOM,
//       );
//       return;
//     }

//     // Cannot remove the creator
//     if (userId == group.creatorId) {
//       Get.snackbar(
//         'Error',
//         'Cannot remove the group creator',
//         snackPosition: SnackPosition.BOTTOM,
//       );
//       return;
//     }

//     // Update group members
//     final updatedGroups =
//         groups.map((g) {
//           if (g.id == groupId) {
//             return Group(
//               id: g.id,
//               name: g.name,
//               avatar: g.avatar,
//               isOnline: g.isOnline,
//               memberIds: g.memberIds.where((id) => id != userId).toList(),
//               creatorId: g.creatorId,
//               createdAt: g.createdAt,
//             );
//           }
//           return g;
//         }).toList();

//     groups.value = updatedGroups;

//     // Add system message about member removal
//     final user = ChatData.users.firstWhere(
//       (u) => u.id == userId,
//       orElse:
//           () => User(
//             id: userId,
//             name: "Unknown User",
//             avatar: "https://via.placeholder.com/150",
//             isOnline: false,
//           ),
//     );

//     final systemMessage = GroupMessage(
//       id: 'gm${DateTime.now().millisecondsSinceEpoch}',
//       senderId: 'system',
//       groupId: groupId,
//       text: '${user.name} was removed from the group',
//       timestamp: DateTime.now().millisecondsSinceEpoch,
//       isRead: true,
//       type: MessageType.text,
//     );

//     _addMessageToGroup(groupId, systemMessage);

//     Get.snackbar(
//       'Success',
//       '${user.name} was removed from the group',
//       snackPosition: SnackPosition.BOTTOM,
//     );

//     update(); // Add this to trigger GetBuilder updates
//   }
// }
