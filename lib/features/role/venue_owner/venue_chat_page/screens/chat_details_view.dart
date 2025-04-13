import 'package:blinqo/features/role/venue_owner/venue_chat_page/model/chat_model.dart';
import 'package:blinqo/features/role/venue_owner/venue_chat_page/screens/imger_viewer_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../controllers/chat_controller.dart';
import '../utils/date_utils.dart';
import 'user_profile_view.dart';

class ChatDetailView extends StatelessWidget {
  final String chatId;
  final ChatController chatController = Get.put(ChatController());
  final TextEditingController messageController = TextEditingController();
  final ScrollController scrollController = ScrollController();

  ChatDetailView({Key? key, required this.chatId}) : super(key: key);

  void _showImagePickerOptions() {
    Get.bottomSheet(
      Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Select Image',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildImagePickerOption(
                    icon: Icons.camera_alt,
                    title: 'Camera',
                    onTap: () {
                      Get.back();
                      chatController.pickImage(chatId, ImageSource.camera);
                    },
                  ),
                  _buildImagePickerOption(
                    icon: Icons.photo_library,
                    title: 'Gallery',
                    onTap: () {
                      Get.back();
                      chatController.pickImage(chatId, ImageSource.gallery);
                    },
                  ),
                ],
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImagePickerOption({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: Color(0xFF205295).withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: Color(0xFF205295),
              size: 30,
            ),
          ),
          SizedBox(height: 8),
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = chatController.getUserById(chatId);

    if (user == null) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Chat'),
          elevation: 0,
        ),
        body: Center(
          child: Text('User not found'),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
        ),
        title: GestureDetector(
          onTap: () => Get.to(() => UserProfileView(userId: chatId)),
          child: Row(
            children: [
              CircleAvatar(
                radius: 18,
                backgroundImage: NetworkImage(user.avatar),
              ),
              SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    user.name,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    user.isOnline ? 'Online' : 'Offline',
                    style: TextStyle(
                      fontSize: 12,
                      color: user.isOnline ? Colors.green : Colors.grey,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          // Messages list
          Expanded(
            child: Obx(() {
              final messages = chatController.getChatMessages(chatId);

              if (messages.isEmpty) {
                return Center(
                  child: Text('No messages yet'),
                );
              }

              WidgetsBinding.instance.addPostFrameCallback((_) {
                if (scrollController.hasClients) {
                  scrollController.jumpTo(scrollController.position.maxScrollExtent);
                }
              });

              return ListView.builder(
                controller: scrollController,
                padding: EdgeInsets.all(16),
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  final message = messages[index];
                  final isCurrentUser = message.senderId == chatController.currentUser.value.id;

                  return MessageBubble(
                    message: message,
                    isCurrentUser: isCurrentUser,
                    onImageTap: (url) {
                      Get.to(() => ImageViewerView(imageUrl: url));
                    },
                    onAudioTap: (url) {
                      // Audio playback functionality would go here
                      Get.snackbar(
                        'Coming Soon',
                        'Audio playback will be available in the next update',
                        snackPosition: SnackPosition.BOTTOM,
                      );
                    },
                  );
                },
              );
            }),
          ),

          // Uploading indicator
          Obx(() => chatController.isUploading.value
              ? Container(
            padding: EdgeInsets.symmetric(vertical: 8),
            color: Colors.white,
            child: Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF205295)),
                    ),
                  ),
                  SizedBox(width: 10),
                  Text('Sending image...'),
                ],
              ),
            ),
          )
              : SizedBox.shrink()
          ),

          // Chat input
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                top: BorderSide(
                  color: Colors.grey[200]!,
                  width: 1,
                ),
              ),
            ),
            child: SafeArea(
              child: Row(
                children: [
                  // Input field with emoji button
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: Row(
                        children: [
                          IconButton(
                            icon: Icon(Icons.emoji_emotions_outlined),
                            color: Colors.grey[600],
                            onPressed: () {},
                          ),
                          Expanded(
                            child: TextField(
                              controller: messageController,
                              decoration: InputDecoration(
                                hintText: 'Type Message',
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.symmetric(vertical: 10),
                              ),
                              maxLines: null,
                            ),
                          ),
                          IconButton(
                            icon: Icon(Icons.image),
                            color: Colors.grey[600],
                            onPressed: _showImagePickerOptions,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: 8),
                  // Send/mic button
                  Obx(() {
                    final hasText = chatController.isTyping.value;

                    return GestureDetector(
                      onTap: () {
                        if (hasText) {
                          chatController.sendMessage(
                            chatId,
                            messageController.text.trim(),
                          );
                          messageController.clear();
                          chatController.isTyping.value = false; // reset

                          Future.delayed(Duration(milliseconds: 100), () {
                            if (scrollController.hasClients) {
                              scrollController.animateTo(
                                scrollController.position.maxScrollExtent,
                                duration: Duration(milliseconds: 300),
                                curve: Curves.easeOut,
                              );
                            }
                          });
                        } else {
                          Get.snackbar(
                            'Coming Soon',
                            'Audio recording will be available in the next update',
                            snackPosition: SnackPosition.BOTTOM,
                          );
                        }
                      },
                      child: Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          color: Color(0xFF205295),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          hasText ? Icons.send : Icons.mic,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    );
                  }),

                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MessageBubble extends StatelessWidget {
  final Message message;
  final bool isCurrentUser;
  final Function(String)? onImageTap;
  final Function(String)? onAudioTap;

  const MessageBubble({
    Key? key,
    required this.message,
    required this.isCurrentUser,
    this.onImageTap,
    this.onAudioTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isCurrentUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 4),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.8,
        ),
        decoration: BoxDecoration(
          color: isCurrentUser ? Color(0xFF205295) : Color(0xFFF0F0F0),
          borderRadius: BorderRadius.circular(16).copyWith(
            bottomRight: isCurrentUser ? Radius.circular(4) : Radius.circular(16),
            bottomLeft: !isCurrentUser ? Radius.circular(4) : Radius.circular(16),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            // Message content
            _buildMessageContent(),

            // Timestamp
            Padding(
              padding: EdgeInsets.only(right: 8, bottom: 4, left: 8),
              child: Text(
                ChatDateUtils.formatTime(message.timestamp.toInt()),
                style: TextStyle(
                  fontSize: 10,
                  color: isCurrentUser
                      ? Colors.white.withOpacity(0.7)
                      : Colors.black.withOpacity(0.5),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMessageContent() {
    switch (message.type) {
      case MessageType.image:
        return GestureDetector(
          onTap: () => message.mediaUrl != null && onImageTap != null
              ? onImageTap!(message.mediaUrl!)
              : null,
          child: ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
            child: message.mediaUrl!.startsWith('http')
                ? Image.network(
              message.mediaUrl!,
              width: 200,
              height: 150,
              fit: BoxFit.cover,
            )
                : Image.file(
              File(message.mediaUrl!),
              width: 200,
              height: 150,
              fit: BoxFit.cover,
            ),
          ),
        );

      case MessageType.audio:
        return GestureDetector(
          onTap: () => message.mediaUrl != null && onAudioTap != null
              ? onAudioTap!(message.mediaUrl!)
              : null,
          child: Container(
            padding: EdgeInsets.all(12),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 28,
                  height: 28,
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.play_arrow,
                    size: 16,
                    color: isCurrentUser ? Colors.white : Colors.black,
                  ),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: Row(
                    children: List.generate(
                      15,
                          (index) => Container(
                        width: 3,
                        height: 4 + (index % 3) * 4.0,
                        margin: EdgeInsets.symmetric(horizontal: 1),
                        decoration: BoxDecoration(
                          color: isCurrentUser
                              ? Colors.white.withOpacity(0.2 + (index % 5) * 0.15)
                              : Colors.black.withOpacity(0.2 + (index % 5) * 0.15),
                          borderRadius: BorderRadius.circular(1.5),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 8),
                Text(
                  message.audioDuration ?? '0:00',
                  style: TextStyle(
                    fontSize: 12,
                    color: isCurrentUser ? Colors.white : Colors.black,
                  ),
                ),
              ],
            ),
          ),
        );

      default:
        return Padding(
          padding: EdgeInsets.all(12),
          child: Text(
            message.text,
            style: TextStyle(
              fontSize: 16,
              color: isCurrentUser ? Colors.white : Colors.black,
            ),
          ),
        );
    }
  }
}