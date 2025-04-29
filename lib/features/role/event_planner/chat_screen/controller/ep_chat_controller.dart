import 'dart:io';

import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:blinqo/features/role/venue_owner/venue_chat_page/data/chat_data.dart';
import 'package:blinqo/features/role/venue_owner/venue_chat_page/model/chat_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class EpChatController extends GetxController {
  final Rx<User> currentUser = ChatData.currentUser.obs;
  final RxList<User> users = ChatData.users.obs;
  final RxList<ChatPreview> chats = <ChatPreview>[].obs;
  final Rx<String?> activeChat = Rx<String?>(null);
  final RxMap<String, List<Message>> messages = <String, List<Message>>{}.obs;

  final ImagePicker _imagePicker = ImagePicker();
  final Rx<File?> previewImage = Rx<File?>(null);
  final RxBool isUploading = false.obs;

  final RxBool isTyping = false.obs;
  final TextEditingController messageController = TextEditingController();
  final ScrollController scrollController = ScrollController();

  void showImage(bool values) {
    if (values == true) {
      values != values;
    }
    update();
  }

  @override
  void onInit() {
    super.onInit();
    chats.value = ChatData.getChatPreviews();
    messages.value = Map.from(ChatData.messages);

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

    messageController.addListener(() {
      onMessageChanged(messageController.text);
    });
  }

  @override
  void onClose() {
    messageController.dispose();
    scrollController.dispose();
    super.onClose();
  }

  void setActiveChat(String? chatId) {
    activeChat.value = chatId;
    if (chatId != null) {
      markAsRead(chatId);
    }
  }

  void onMessageChanged(String text) {
    isTyping.value = text.trim().isNotEmpty;
  }

  Future<void> pickImage(String chatId, ImageSource source) async {
    try {
      final XFile? pickedFile = await _imagePicker.pickImage(
        source: source,
        imageQuality: 70,
      );

      if (pickedFile != null) {
        final File tempFile = File(pickedFile.path);
        final Directory appDir = await getApplicationDocumentsDirectory();
        final String newPath =
            '${appDir.path}/${DateTime.now().millisecondsSinceEpoch}.jpg';
        final File savedFile = await tempFile.copy(newPath);

        previewImage.value = savedFile;

        Get.dialog(
          AlertDialog(
            backgroundColor: Colors.white,
            title: const Text('Send Image?'),
            content: Image.file(savedFile, height: 200, fit: BoxFit.cover),
            actions: [
              TextButton(
                onPressed: () {
                  previewImage.value = null;
                  Get.back();
                },
                child: Text(
                  'Cancel',
                  style: getTextStyle(color: AppColors.iconColor),
                ),
              ),
              TextButton(
                onPressed: () {
                  sendImageMessage(chatId, savedFile.path);
                  previewImage.value = null;
                  Get.back();
                },
                child: Text(
                  'Send',
                  style: TextStyle(color: AppColors.iconColor),
                ),
              ),
            ],
          ),
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to pick image: $e',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  void sendImageMessage(String chatId, String imagePath) {
    final newMessage = Message(
      id: 'm${DateTime.now().millisecondsSinceEpoch}',
      senderId: currentUser.value.id,
      receiverId: chatId,
      text: '',
      timestamp: DateTime.now().millisecondsSinceEpoch,
      isRead: false,
      type: MessageType.image,
      mediaUrl: imagePath,
    );

    _addMessageToChat(chatId, newMessage);
  }

  void sendMessage(
    String chatId,
    String text, {
    MessageType type = MessageType.text,
    String? mediaUrl,
    String? audioDuration,
  }) {
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
      audioDuration:
          type == MessageType.audio ? (audioDuration ?? '0:00') : null,
    );

    _addMessageToChat(chatId, newMessage);
  }

  void _addMessageToChat(String chatId, Message newMessage) {
    final chatMessages = [...(messages[chatId] ?? []), newMessage];
    messages[chatId] = List<Message>.from(chatMessages);

    final updatedChats =
        chats.map((chat) {
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

    updatedChats.sort(
      (a, b) => b.lastMessage.timestamp.compareTo(a.lastMessage.timestamp),
    );
    chats.value = updatedChats;
  }

  void markAsRead(String chatId) {
    final chatMessages = messages[chatId] ?? [];
    final updatedMessages =
        chatMessages.map((msg) {
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

    final updatedChats =
        chats.map((chat) {
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
    try {
      return users.firstWhere((user) => user.id == userId);
    } catch (e) {
      return null;
    }
  }

  List<Message> getChatMessages(String chatId) {
    return messages[chatId] ?? [];
  }
}
