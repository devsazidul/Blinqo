import 'package:blinqo/features/role/venue_owner/venue_chat_page/model/chat_model.dart';
import 'package:get/get.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import '../data/chat_data.dart';

class ChatController extends GetxController {
  final Rx<User> currentUser = ChatData.currentUser.obs;
  final RxList<User> users = ChatData.users.obs;
  final RxList<ChatPreview> chats = <ChatPreview>[].obs;
  final Rx<String?> activeChat = Rx<String?>(null);
  final RxMap<String, List<Message>> messages = <String, List<Message>>{}.obs;

  // For image picking
  final ImagePicker _imagePicker = ImagePicker();
  final Rx<File?> selectedImage = Rx<File?>(null);
  final RxBool isUploading = false.obs;

  // NEW: Track if user is typing
  final RxBool isTyping = false.obs;

  @override
  void onInit() {
    super.onInit();
    chats.value = ChatData.getChatPreviews();
    messages.value = Map.from(ChatData.messages);
  }

  void setActiveChat(String? chatId) {
    activeChat.value = chatId;
    if (chatId != null) {
      markAsRead(chatId);
    }
  }

  // NEW: Update isTyping when message input changes
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
        isUploading.value = true;

        // Simulate upload delay
        await Future.delayed(Duration(seconds: 1));

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

    updatedChats.sort((a, b) => b.lastMessage.timestamp.compareTo(a.lastMessage.timestamp));
    chats.value = updatedChats;
  }

  void markAsRead(String chatId) {
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
