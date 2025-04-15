import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:blinqo/features/role/venue_owner/venue_chat_page/controllers/chat_controller.dart';
import 'package:blinqo/features/role/venue_owner/venue_chat_page/model/chat_model.dart';
import 'package:blinqo/features/role/venue_owner/venue_chat_page/screens/imger_viewer_view.dart';
import 'package:blinqo/features/role/venue_owner/venue_chat_page/widgets/image_picker_bottom_sheet.dart';
import 'package:blinqo/features/role/venue_owner/venue_chat_page/widgets/message_bubble.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/foundation.dart' as foundation;
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatDetails extends StatelessWidget {
  final String chatId;

  const ChatDetails({super.key, required this.chatId});

  @override
  Widget build(BuildContext context) {
    final ChatController controller = Get.find<ChatController>();

    final user = controller.getUserById(chatId);
    if (user == null) {
      return Scaffold(
        backgroundColor: AppColors.chatBackground,
        appBar: AppBar(
          forceMaterialTransparency: true,
          title: const Text('Chat'),
          elevation: 0,
        ),
        body: const Center(child: Text('User not found')),
      );
    }

    return Scaffold(
      backgroundColor: AppColors.chatBackground,
      appBar: coustomAppBar(user),
      body: Column(
        children: [
          Expanded(
            child: Obx(() {
              final messages = controller.messages[chatId] ?? [];
              return messages.isEmpty
                  ? userEmptyChat(user)
                  : userMessageList(messages, controller);
            }),
          ),
          uploadingImage(controller),
          coustomTextField(controller),
        ],
      ),
    );
  }

  AppBar coustomAppBar(User user) {
    return AppBar(
      elevation: 0,
      forceMaterialTransparency: false,
      backgroundColor: AppColors.backgroundColor,
      leadingWidth: 35,
      leading: IconButton(
        icon: Icon(Icons.arrow_back, size: 28),
        onPressed: () => Get.back(),
      ),
      title: Row(
        children: [
          CircleAvatar(radius: 20, backgroundImage: NetworkImage(user.avatar)),
          SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                user.name,
                style: getTextStyle(fontSize: 16, fontWeight: FontWeight.w500),
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
      actions: [
        IconButton(icon: Icon(Icons.more_vert, size: 30), onPressed: () {}),
      ],
    );
  }

  Widget userEmptyChat(User user) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Spacer(flex: 3),
        CircleAvatar(radius: 60, backgroundImage: NetworkImage(user.avatar)),
        const SizedBox(height: 4),
        Text(
          user.name,
          style: getTextStyle(fontSize: 20, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 8),
        Text(
          'Say hello to ${user.name}',
          style: getTextStyle(fontSize: 14, color: const Color(0xFF767676)),
        ),
        const Spacer(),
      ],
    );
  }

  Widget userMessageList(List<Message> messages, ChatController controller) {
    return ListView.builder(
      controller: controller.scrollController,
      padding: const EdgeInsets.all(16),
      itemCount: messages.length,
      itemBuilder: (context, index) {
        final message = messages[index];
        final isCurrentUser =
            message.senderId == controller.currentUser.value.id;
        return MessageBubble(
          message: message,
          isCurrentUser: isCurrentUser,
          onImageTap: (url) {
            Get.to(() => ImageViewerView(imageUrl: url));
          },
        );
      },
    );
  }

  Widget uploadingImage(ChatController controller) {
    return Obx(
      () =>
          controller.isUploading.value
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
              : const SizedBox.shrink(),
    );
  }

  Widget coustomTextField(ChatController controller) {
    final RxBool showEmojiPicker = false.obs;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      decoration: const BoxDecoration(color: AppColors.chatBackground),
      child: SafeArea(
        child: Column(
          children: [
            Obx(
              () => Offstage(
                offstage: !showEmojiPicker.value,
                child: SizedBox(
                  child: EmojiPicker(
                    onEmojiSelected: (category, emoji) {
                      controller.messageController.text += emoji.emoji;
                      showEmojiPicker.value = false;
                    },
                    onBackspacePressed: () {
                      controller.messageController.text =
                          controller.messageController.text.characters
                              .skipLast(1)
                              .toString();
                    },
                    config: Config(
                      height: 256,
                      checkPlatformCompatibility: true,
                      emojiViewConfig: EmojiViewConfig(
                        emojiSizeMax:
                            28 *
                            (foundation.defaultTargetPlatform ==
                                    TargetPlatform.iOS
                                ? 1.20
                                : 1.0),
                      ),
                      bottomActionBarConfig: BottomActionBarConfig(
                        showSearchViewButton: false,
                        showBackspaceButton: false,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Row(
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
                          onPressed: () {
                            showEmojiPicker.value = !showEmojiPicker.value;
                          },
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
                              contentPadding: const EdgeInsets.symmetric(
                                vertical: 10,
                              ),
                            ),
                            maxLines: 1,
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.add_link_sharp),
                          color: AppColors.iconColor,
                          onPressed:
                              () => Get.bottomSheet(
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
                        controller.sendMessage(
                          chatId,
                          controller.messageController.text.trim(),
                        );
                        controller.messageController.clear();
                      } else {
                        Get.snackbar(
                          'Empty!',
                          'empty message',
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
                      child: const Icon(
                        Icons.send,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  );
                }),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
