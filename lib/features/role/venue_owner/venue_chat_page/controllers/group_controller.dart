import 'package:blinqo/features/role/venue_owner/venue_chat_page/model/chat_model.dart';
import 'package:blinqo/features/role/venue_owner/venue_chat_page/model/group_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

import '../data/chat_data.dart';
import '../data/group_data.dart';

class GroupController extends GetxController {
  final Rx<User> currentUser = ChatData.currentUser.obs;
  final RxList<Group> groups = GroupData.groups.obs;
  final RxList<GroupChatPreview> groupChats = <GroupChatPreview>[].obs;
  final Rx<String?> activeGroup = Rx<String?>(null);
  final RxMap<String, List<GroupMessage>> groupMessages = <String, List<GroupMessage>>{}.obs;

  // For image picking
  final ImagePicker _imagePicker = ImagePicker();
  final Rx<File?> selectedImage = Rx<File?>(null);
  final RxBool isUploading = false.obs;

  // For group creation
  final RxList<String> selectedMembers = <String>[].obs;
  final RxString groupName = ''.obs;
  final Rx<File?> groupAvatar = Rx<File?>(null);
  final RxBool isCreatingGroup = false.obs;

  @override
  void onInit() {
    super.onInit();
    groupChats.value = GroupData.getGroupChatPreviews();
    groupMessages.value = Map.from(GroupData.groupMessages);
  }

  void setActiveGroup(String? groupId) {
    activeGroup.value = groupId;
    if (groupId != null) {
      markGroupMessagesAsRead(groupId);
    }
    update(); // Add this to trigger GetBuilder updates
  }

  Future<void> pickImage(String groupId, ImageSource source) async {
    try {
      final XFile? pickedFile = await _imagePicker.pickImage(
        source: source,
        imageQuality: 70,
      );

      if (pickedFile != null) {
        isUploading.value = true;

        // In a real app, you would upload the image to a server here
        // For this demo, we'll simulate a brief delay
        await Future.delayed(Duration(seconds: 1));

        // Create a local file path for the image
        final File imageFile = File(pickedFile.path);
        selectedImage.value = imageFile;

        // Send the image message
        sendGroupImageMessage(groupId, imageFile.path);

        isUploading.value = false;
      }
    } catch (e) {
      isUploading.value = false;
      Get.snackbar(
        'Error',
        'Failed to pick image: $e',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  void sendGroupImageMessage(String groupId, String imagePath) {
    // In a real app, imagePath would be a URL from your server
    // For this demo, we'll use the local path
    final newMessage = GroupMessage(
      id: 'gm${DateTime.now().millisecondsSinceEpoch}',
      senderId: currentUser.value.id,
      groupId: groupId,
      text: '',
      timestamp: DateTime.now().millisecondsSinceEpoch,
      isRead: false,
      type: MessageType.image,
      mediaUrl: imagePath,
    );

    _addMessageToGroup(groupId, newMessage);
  }

  void sendGroupMessage(String groupId, String text, {MessageType type = MessageType.text, String? mediaUrl, String? audioDuration}) {
    if (text.trim().isEmpty && type == MessageType.text) return;

    final newMessage = GroupMessage(
      id: 'gm${DateTime.now().millisecondsSinceEpoch}',
      senderId: currentUser.value.id,
      groupId: groupId,
      text: text,
      timestamp: DateTime.now().millisecondsSinceEpoch,
      isRead: false,
      type: type,
      mediaUrl: mediaUrl,
      audioDuration: audioDuration,
    );

    _addMessageToGroup(groupId, newMessage);
  }

  void _addMessageToGroup(String groupId, GroupMessage newMessage) {
    // Update messages
    final List<GroupMessage> chatMessages = List<GroupMessage>.from(groupMessages[groupId] ?? []);
    chatMessages.add(newMessage);
    groupMessages[groupId] = chatMessages;


    // Update group chat previews
    final updatedGroupChats = groupChats.map((chat) {
      if (chat.group.id == groupId) {
        return GroupChatPreview(
          group: chat.group,
          lastMessage: newMessage,
          unreadCount: chat.unreadCount,
        );
      }
      return chat;
    }).toList();

    // Sort chats by latest message
    updatedGroupChats.sort((a, b) => b.lastMessage.timestamp.compareTo(a.lastMessage.timestamp));
    groupChats.value = updatedGroupChats;

    update(); // Add this to trigger GetBuilder updates
  }

  void markGroupMessagesAsRead(String groupId) {
    // Mark all messages in this group as read
    final chatMessages = groupMessages[groupId] ?? [];
    final updatedMessages = chatMessages.map((msg) {
      if (!msg.isRead) {
        return GroupMessage(
          id: msg.id,
          senderId: msg.senderId,
          groupId: msg.groupId,
          text: msg.text,
          timestamp: msg.timestamp,
          isRead: true,
          type: msg.type,
          mediaUrl: msg.mediaUrl,
          audioDuration: msg.audioDuration,
        );
      }
      return msg;
    }).toList();

    groupMessages[groupId] = updatedMessages;

    // Update unread count in group chat preview
    final updatedGroupChats = groupChats.map((chat) {
      if (chat.group.id == groupId) {
        return GroupChatPreview(
          group: chat.group,
          lastMessage: chat.lastMessage,
          unreadCount: 0,
        );
      }
      return chat;
    }).toList();

    groupChats.value = updatedGroupChats;
    update(); // Add this to trigger GetBuilder updates
  }

  Group? getGroupById(String groupId) {
    try {
      return groups.firstWhere((group) => group.id == groupId);
    } catch (e) {
      return null;
    }
  }

  List<GroupMessage> getGroupMessages(String groupId) {
    return groupMessages[groupId] ?? [];
  }

  List<User> getGroupMembers(String groupId) {
    final group = getGroupById(groupId);
    if (group == null) return [];

    return group.memberIds.map((memberId) {
      if (memberId == currentUser.value.id) {
        return currentUser.value;
      }
      return ChatData.users.firstWhere(
            (user) => user.id == memberId,
        orElse: () => User(
          id: memberId,
          name: "Unknown User",
          avatar: "https://images.unsplash.com/photo-1511367461989-f85a21fda167?ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=80",
          isOnline: false,
        ),
      );
    }).toList();
  }

  Future<void> createGroup() async {
    if (groupName.value.trim().isEmpty) {
      Get.snackbar(
        'Error',
        'Please enter a group name',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    if (selectedMembers.isEmpty) {
      Get.snackbar(
        'Error',
        'Please select at least one member',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    isCreatingGroup.value = true;

    try {
      // In a real app, you would upload the group avatar to a server here
      // For this demo, we'll use a default image or the selected one
      String avatarUrl = "https://images.unsplash.com/photo-1529156069898-49953e39b3ac?ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=80";

      if (groupAvatar.value != null) {
        // Simulate upload delay
        await Future.delayed(Duration(seconds: 1));
        avatarUrl = groupAvatar.value!.path;
      }

      // Create new group
      final newGroupId = 'g${DateTime.now().millisecondsSinceEpoch}';
      final newGroup = Group(
        id: newGroupId,
        name: groupName.value.trim(),
        avatar: avatarUrl,
        isOnline: true,
        memberIds: [...selectedMembers, currentUser.value.id],
        creatorId: currentUser.value.id,
        createdAt: DateTime.now().millisecondsSinceEpoch,
      );

      // Add group to list
      groups.add(newGroup);

      // Create initial system message
      final initialMessage = GroupMessage(
        id: 'gm${DateTime.now().millisecondsSinceEpoch}',
        senderId: 'system',
        groupId: newGroupId,
        text: 'Group created by ${currentUser.value.name}',
        timestamp: DateTime.now().millisecondsSinceEpoch,
        isRead: true,
        type: MessageType.text,
      );

      // Add message to group messages
      groupMessages[newGroupId] = [initialMessage];

      // Add to group chat previews
      final newGroupChat = GroupChatPreview(
        group: newGroup,
        lastMessage: initialMessage,
        unreadCount: 0,
      );

      groupChats.add(newGroupChat);

      // Sort chats by latest message
      groupChats.sort((a, b) => b.lastMessage.timestamp.compareTo(a.lastMessage.timestamp));

      // Reset creation state
      resetGroupCreation();

      // Navigate to the new group chat
      Get.back(); // Close the create group screen
      setActiveGroup(newGroupId);
      Get.toNamed('/group_chat/$newGroupId');

      update(); // Add this to trigger GetBuilder updates

    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to create group: $e',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isCreatingGroup.value = false;
    }
  }

  void resetGroupCreation() {
    groupName.value = '';
    selectedMembers.clear();
    groupAvatar.value = null;
    update(); // Add this to trigger GetBuilder updates
  }

  Future<void> pickGroupAvatar() async {
    try {
      final XFile? pickedFile = await _imagePicker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 70,
      );

      if (pickedFile != null) {
        groupAvatar.value = File(pickedFile.path);
        update(); // Add this to trigger GetBuilder updates
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to pick image: $e',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  void toggleMemberSelection(String userId) {
    if (selectedMembers.contains(userId)) {
      selectedMembers.remove(userId);
    } else {
      selectedMembers.add(userId);
    }
    update(); // Add this to trigger GetBuilder updates
  }

  void removeMemberFromGroup(String groupId, String userId) {
    final group = getGroupById(groupId);
    if (group == null) return;

    // Check if current user is the creator
    if (group.creatorId != currentUser.value.id) {
      Get.snackbar(
        'Error',
        'Only the group creator can remove members',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    // Cannot remove the creator
    if (userId == group.creatorId) {
      Get.snackbar(
        'Error',
        'Cannot remove the group creator',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    // Update group members
    final updatedGroups = groups.map((g) {
      if (g.id == groupId) {
        return Group(
          id: g.id,
          name: g.name,
          avatar: g.avatar,
          isOnline: g.isOnline,
          memberIds: g.memberIds.where((id) => id != userId).toList(),
          creatorId: g.creatorId,
          createdAt: g.createdAt,
        );
      }
      return g;
    }).toList();

    groups.value = updatedGroups;

    // Add system message about member removal
    final user = ChatData.users.firstWhere(
          (u) => u.id == userId,
      orElse: () => User(
        id: userId,
        name: "Unknown User",
        avatar: "https://via.placeholder.com/150",
        isOnline: false,
      ),
    );

    final systemMessage = GroupMessage(
      id: 'gm${DateTime.now().millisecondsSinceEpoch}',
      senderId: 'system',
      groupId: groupId,
      text: '${user.name} was removed from the group',
      timestamp: DateTime.now().millisecondsSinceEpoch,
      isRead: true,
      type: MessageType.text,
    );

    _addMessageToGroup(groupId, systemMessage);

    Get.snackbar(
      'Success',
      '${user.name} was removed from the group',
      snackPosition: SnackPosition.BOTTOM,
    );

    update(); // Add this to trigger GetBuilder updates
  }

  void leaveGroup(String groupId) {
    final group = getGroupById(groupId);
    if (group == null) return;

    // If current user is the creator, they can't leave
    if (group.creatorId == currentUser.value.id) {
      Get.snackbar(
        'Error',
        'As the creator, you cannot leave the group. You can delete it instead.',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    // Update group members
    final updatedGroups = groups.map((g) {
      if (g.id == groupId) {
        return Group(
          id: g.id,
          name: g.name,
          avatar: g.avatar,
          isOnline: g.isOnline,
          memberIds: g.memberIds.where((id) => id != currentUser.value.id).toList(),
          creatorId: g.creatorId,
          createdAt: g.createdAt,
        );
      }
      return g;
    }).toList();

    groups.value = updatedGroups;

    // Add system message about leaving
    final systemMessage = GroupMessage(
      id: 'gm${DateTime.now().millisecondsSinceEpoch}',
      senderId: 'system',
      groupId: groupId,
      text: '${currentUser.value.name} left the group',
      timestamp: DateTime.now().millisecondsSinceEpoch,
      isRead: true,
      type: MessageType.text,
    );

    _addMessageToGroup(groupId, systemMessage);

    Get.back(); // Go back to chat list
    Get.snackbar(
      'Success',
      'You left the group',
      snackPosition: SnackPosition.BOTTOM,
    );

    update(); // Add this to trigger GetBuilder updates
  }

  void deleteGroup(String groupId) {
    final group = getGroupById(groupId);
    if (group == null) return;

    // Only creator can delete the group
    if (group.creatorId != currentUser.value.id) {
      Get.snackbar(
        'Error',
        'Only the group creator can delete the group',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    // Remove group from lists
    groups.removeWhere((g) => g.id == groupId);
    groupChats.removeWhere((gc) => gc.group.id == groupId);
    groupMessages.remove(groupId);

    Get.back(); // Go back to chat list
    Get.snackbar(
      'Success',
      'Group deleted',
      snackPosition: SnackPosition.BOTTOM,
    );

    update(); // Add this to trigger GetBuilder updates
  }
}