import 'package:blinqo/features/role/venue_owner/venue_chat_page/model/chat_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import '../data/chat_data.dart';

class ChatController extends GetxController {
  // Reactive state for current user, users, chats, and messages
  final Rx<User> currentUser = ChatData.currentUser.obs;
  final RxList<User> users = ChatData.users.obs;
  final RxList<ChatPreview> chats = <ChatPreview>[].obs;
  final Rx<String?> activeChat = Rx<String?>(null);
  final RxMap<String, List<Message>> messages = <String, List<Message>>{}.obs;

  // Image picking state
  final ImagePicker _imagePicker = ImagePicker();
  final Rx<File?> selectedImage = Rx<File?>(null);
  final RxBool isUploading = false.obs;

  // Track typing state for input field
  final RxBool isTyping = false.obs;

  // Controllers for text input and messages list scrolling
  final TextEditingController messageController = TextEditingController();
  final ScrollController scrollController = ScrollController();

  @override
  void onInit() {
    super.onInit();
    // Load initial chats and messages from data source
    chats.value = ChatData.getChatPreviews();
    messages.value = Map.from(ChatData.messages);

    // Auto-scroll to latest message when messages update
    messages.listen((_) {
      if (scrollController.hasClients) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          scrollController.animateTo(
            scrollController.position.maxScrollExtent,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOut,
          );
        });
      }
    });

    // Update typing state when text input changes
    messageController.addListener(() {
      onMessageChanged(messageController.text);
    });
  }

  @override
  void onClose() {
    // Clean up controllers to prevent memory leaks
    messageController.dispose();
    scrollController.dispose();
    super.onClose();
  }

  void setActiveChat(String? chatId) {
    // Set the currently active chat and mark its messages as read
    activeChat.value = chatId;
    if (chatId != null) {
      markAsRead(chatId);
    }
  }

  void onMessageChanged(String text) {
    // Update typing state based on whether input is non-empty
    isTyping.value = text.trim().isNotEmpty;
  }

  Future<void> pickImage(String chatId, ImageSource source) async {
    // Pick an image from camera or gallery and send it
    try {
      final XFile? pickedFile = await _imagePicker.pickImage(
        source: source,
        imageQuality: 70,
      );

      if (pickedFile != null) {
        isUploading.value = true;

        // Simulate upload delay (replace with actual upload logic)
        await Future.delayed(const Duration(seconds: 1));

        final File imageFile = File(pickedFile.path);
        selectedImage.value = imageFile;

        sendImageMessage(chatId, imageFile.path);
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

  void sendImageMessage(String chatId, String imagePath) {
    // Create and send an image message with file path
    final newMessage = Message(
      id: 'm${DateTime.now().millisecondsSinceEpoch}',
      senderId: currentUser.value.id,
      receiverId: chatId,
      text: '',
      timestamp: DateTime.now().millisecondsSinceEpoch,
      isRead: false,
      type: MessageType.image,
      mediaUrl: imagePath.startsWith('http') ? imagePath : 'file://$imagePath',
    );

    _addMessageToChat(chatId, newMessage);
  }

  void sendMessage(String chatId, String text, {MessageType type = MessageType.text, String? mediaUrl, String? audioDuration}) {
    // Send a message (text, image, or audio) if valid
    if (text.trim().isEmpty && type == MessageType.text) return;

    final newMessage = Message(
      id: 'm${DateTime.now().millisecondsSinceEpoch}',
      senderId: currentUser.value.id,
      receiverId: chatId,
      text: text,
      timestamp: DateTime.now().millisecondsSinceEpoch,
      isRead: false,
      type: type,
      mediaUrl: mediaUrl,
      audioDuration: type == MessageType.audio ? (audioDuration ?? '0:00') : null,
    );

    _addMessageToChat(chatId, newMessage);
  }

  void _addMessageToChat(String chatId, Message newMessage) {
    // Add message to chat and update chat preview
    final chatMessages = [...(messages[chatId] ?? []), newMessage];
    messages[chatId] = List<Message>.from(chatMessages);

    final updatedChats = chats.map((chat) {
      if (chat.id == chatId) {
        return ChatPreview(
          id: chat.id,
          user: chat.user,
          lastMessage: newMessage,
          unreadCount: chat.unreadCount,
        );
      }
      return chat;
    }).toList();

    // Sort chats by latest message timestamp
    updatedChats.sort((a, b) => b.lastMessage.timestamp.compareTo(a.lastMessage.timestamp));
    chats.value = updatedChats;
  }

  void markAsRead(String chatId) {
    // Mark all unread messages in a chat as read
    final chatMessages = messages[chatId] ?? [];
    final updatedMessages = chatMessages.map((msg) {
      if (msg.senderId == chatId && !msg.isRead) {
        return Message(
          id: msg.id,
          senderId: msg.senderId,
          receiverId: msg.receiverId,
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

    messages[chatId] = List<Message>.from(updatedMessages);

    // Reset unread count for the chat
    final updatedChats = chats.map((chat) {
      if (chat.id == chatId) {
        return ChatPreview(
          id: chat.id,
          user: chat.user,
          lastMessage: chat.lastMessage,
          unreadCount: 0,
        );
      }
      return chat;
    }).toList();

    chats.value = updatedChats;
  }

  User? getUserById(String userId) {
    // Retrieve user by ID, return null if not found
    try {
      return users.firstWhere((user) => user.id == userId);
    } catch (e) {
      return null;
    }
  }

  List<Message> getChatMessages(String chatId) {
    // Get messages for a specific chat
    return messages[chatId] ?? [];
  }
}