import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:blinqo/features/role/venue_owner/venue_chat_page/model/chat_model.dart';
import 'package:blinqo/features/role/venue_owner/venue_chat_page/screens/imger_viewer_view.dart';
import 'package:blinqo/features/role/venue_owner/venue_chat_page/widgets/image_picker_bottom_sheet.dart';
import 'package:blinqo/features/role/venue_owner/venue_chat_page/widgets/message_bubble.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/chat_controller.dart';
import '../utils/date_utils.dart';

class ChatDetailView extends StatelessWidget {
  final String chatId;

  const ChatDetailView({super.key, required this.chatId});

  @override
  Widget build(BuildContext context) {
    // Access ChatController (assumed initialized in parent)
    final ChatController controller = Get.find<ChatController>();

    // Check if user exists, show error UI if not
    final user = controller.getUserById(chatId);
    if (user == null) {
      return Scaffold(
        backgroundColor: const Color(0xFFFFF5D7),
        appBar: AppBar(
          forceMaterialTransparency: true,
          title: const Text('Chat'),
          elevation: 0,
        ),
        body: const Center(child: Text('User not found')),
      );
    }

    return Scaffold(
      backgroundColor: const Color(0xFFFFF5D7),
      appBar: _buildAppBar(user),
      body: Column(
        children: [
          Expanded(
            child: Obx(() {
              final messages = controller.messages[chatId] ?? [];
              return messages.isEmpty
                  ? _buildEmptyState(user)
                  : _buildMessagesList(messages, controller);
            }),
          ),
          _buildUploadingIndicator(controller),
          _buildChatInput(controller),
        ],
      ),
    );
  }

  AppBar _buildAppBar(User user) {
    // Build app bar with user avatar, name, and online status
    return AppBar(
      elevation: 0,
      forceMaterialTransparency: false,
      backgroundColor: AppColors.backgroundColor,
      leading: IconButton(
        icon: Icon(Icons.arrow_back, size: 28),
        onPressed: () => Get.back(),
      ),
      title: Row(
        children: [
          CircleAvatar(
            radius: 20,
            backgroundImage: NetworkImage(user.avatar),
          ),
          SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                user.name,
                style: getTextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                user.isOnline ? 'Online' : 'Offline',
                style: getTextStyle(
                  fontSize: 14,
                  color: user.isOnline ? Colors.green : Colors.grey,
                ),
              ),
            ],
          ),
        ],
      ),
      actions: [IconButton(icon: Icon(Icons.more_vert), onPressed: () {})],
    );
  }

  Widget _buildEmptyState(User user) {
    // Display welcome UI when no messages exist
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Spacer(flex: 3),
        CircleAvatar(
          radius: 60,
          backgroundImage: NetworkImage(user.avatar),
        ),
        const SizedBox(height: 16),
        Text(
          user.name,
          style: getTextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 18),
        Text(
          'Say hello to ${user.name}',
          style: getTextStyle(
            fontSize: 14,
            color: const Color(0xFF767676),
          ),
        ),
        const Spacer(),
      ],
    );
  }

  Widget _buildMessagesList(List<Message> messages, ChatController controller) {
    // Render list of chat messages
    return ListView.builder(
      controller: controller.scrollController,
      padding: const EdgeInsets.all(16),
      itemCount: messages.length,
      itemBuilder: (context, index) {
        final message = messages[index];
        final isCurrentUser = message.senderId == controller.currentUser.value.id;
        return MessageBubble(
          message: message,
          isCurrentUser: isCurrentUser,
          onImageTap: (url) {
            Get.to(() => ImageViewerView(imageUrl: url));
          },
          onAudioTap: (url) {
            Get.snackbar(
              'Coming Soon',
              'Audio playback will be available in the next update',
              snackPosition: SnackPosition.BOTTOM,
            );
          },
        );
      },
    );
  }

  Widget _buildUploadingIndicator(ChatController controller) {
    // Show progress indicator during image uploads
    return Obx(() => controller.isUploading.value
        ? Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      color: Colors.white,
      child: Center(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: const [
            SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation<Color>(
                  Color(0xFF205295),
                ),
              ),
            ),
            SizedBox(width: 10),
            Text('Sending image...'),
          ],
        ),
      ),
    )
        : const SizedBox.shrink());
  }

  Widget _buildChatInput(ChatController controller) {
    // Build input area with text field and action buttons
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      decoration: const BoxDecoration(
        color: Color(0xFFFFF5D7),
      ),
      child: SafeArea(
        child: Row(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.emoji_emotions_outlined),
                      color: AppColors.iconColor,
                      onPressed: () {},
                    ),
                    Expanded(
                      child: TextField(
                        controller: controller.messageController,
                        decoration: InputDecoration(
                          hintText: 'Type Message',
                          hintStyle: getTextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                          ),
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          contentPadding: const EdgeInsets.symmetric(vertical: 10),
                        ),
                        maxLines: null,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.image),
                      color: AppColors.iconColor,
                      onPressed: () => Get.bottomSheet(
                        ImagePickerBottomSheet(
                          chatId: chatId,
                          chatController: controller,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 8),
            Obx(() {
              final hasText = controller.isTyping.value;
              return GestureDetector(
                onTap: () {
                  if (hasText) {
                    controller.sendMessage(chatId, controller.messageController.text.trim());
                    controller.messageController.clear();
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
                    color: AppColors.iconColor,
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
    );
  }
}