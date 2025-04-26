import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:blinqo/core/utils/constants/icon_path.dart';
import 'package:blinqo/features/role/venue_owner/profile_page/controller/venue_owner_profile_controller.dart';
import 'package:blinqo/features/role/venue_owner/venue_chat_page/model/chat_model.dart';
import 'package:blinqo/features/role/venue_owner/venue_chat_page/screens/imger_viewer_view.dart';
import 'package:blinqo/features/role/venue_owner/venue_chat_page/widgets/image_picker_bottom_sheet.dart';
import 'package:blinqo/features/role/venue_owner/venue_chat_page/widgets/message_bubble.dart';
import 'package:flutter/foundation.dart' as foundation;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import '../controllers/chat_controller.dart';

class ChatDetailView extends StatelessWidget {
  final String chatId;

  const ChatDetailView({super.key, required this.chatId});

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode =
        Get.put(VenueOwnerProfileController()).isDarkMode.value;
    final ChatController controller = Get.find<ChatController>();
    final user = controller.getUserById(chatId);

    if (user == null) {
      return Scaffold(
        backgroundColor: isDarkMode ? Color(0xff151515) : Color(0xFFE6EBF0),
        appBar: AppBar(
          forceMaterialTransparency: true,
          title: const Text('Chat'),
          elevation: 0,
        ),
        body: const Center(child: Text('User not found')),
      );
    }

    return Scaffold(
      backgroundColor: isDarkMode ? Color(0xff151515) : Color(0xFFE6EBF0),
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
          _buildChatInput(controller, context),
        ],
      ),
    );
  }

  AppBar _buildAppBar(User user) {
    final bool isDarkMode =
        Get.put(VenueOwnerProfileController()).isDarkMode.value;
    return AppBar(
      elevation: 0,
      automaticallyImplyLeading: false,
      forceMaterialTransparency: false,
      leading: Padding(
        padding: const EdgeInsets.only(left: 20.0),
        child: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: CircleAvatar(
            backgroundColor:
            isDarkMode
                ? Color(0xFFD9D9D9).withAlpha(40)
                : const Color(0xFFD9D9D9),
            child: Image.asset(
              IconPath.arrowLeftAlt,
              width: 16,
              height: 12,
              color: isDarkMode ? Colors.white : AppColors.textColor,
            ),
          ),
        ),
      ),
      backgroundColor: isDarkMode ? Color(0xff32383D) : Color(0xffffffff),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
        side: BorderSide(color: Color(0xFF003366), width: 1),
      ),
      // leading: IconButton(
      //   icon: const Icon(Icons.arrow_back, size: 28),
      //   onPressed: () => Get.back(),
      // ),
      title: Row(
        children: [
          CircleAvatar(radius: 20, backgroundImage: NetworkImage(user.avatar)),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                user.name,
                style: getTextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: isDarkMode ? Color(0xffEBEBEB) : Color(0xff333333),
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
      actions: [
        IconButton(
          icon: Icon(
            Icons.more_vert,
            size: 28,
            color: isDarkMode ? Color(0xffEBEBEB) : Color(0xff333333),
          ),
          onPressed: () {
            _showChatOptions();
          },
        ),
      ],
    );
  }

  void _showChatOptions() {
    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Container(
          decoration: BoxDecoration(
            color: Color(0xffEEEEEE),
            borderRadius: BorderRadius.circular(12),
          ),
          padding: EdgeInsets.symmetric(vertical: 8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildOptionItem(
                'Delete Conversation',
                onTap: () {
                  Get.back();

                },
              ),
              _buildOptionItem(
                'Mark as Unread',
                onTap: () {
                  Get.back();

                },
              ),
              _buildOptionItem(
                'Block',
                onTap: () {
                  Get.back();

                },
              ),
              _buildOptionItem(
                'Report',
                onTap: () {
                  Get.back();
                },
                isLast: true,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOptionItem(
      String title, {
        required VoidCallback onTap,
        bool isLast = false,
      }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        decoration: BoxDecoration(
          border:
          !isLast
              ? Border(
            bottom: BorderSide(color: Colors.grey[200]!, width: 1),
          )
              : null,
        ),
        child: Center(
          child: Text(
            title,
            style: getTextStyle(
              fontSize: 16,
              color:
              title.contains('Leave') || title.contains('Delete')
                  ? Colors.red
                  : Colors.black,
            ),
          ),
        ),
      ),
    );
  }


  Widget _buildEmptyState(User user) {
    final bool isDarkMode =
        Get.put(VenueOwnerProfileController()).isDarkMode.value;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Spacer(flex: 3),
        CircleAvatar(radius: 60, backgroundImage: NetworkImage(user.avatar)),
        const SizedBox(height: 4),
        Text(
          user.name,
          style: getTextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
            color: isDarkMode ? Color(0xffEBEBEB) : Color(0xff333333),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Say hello to ${user.name}',
          style: getTextStyle(
            fontSize: 14,
            color: isDarkMode ? Color(0xffC0C0C0) : Color(0xFF767676),
          ),
        ),
        const Spacer(),
      ],
    );
  }

  Widget _buildMessagesList(List<Message> messages, ChatController controller) {
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

  Widget _buildChatInput(ChatController controller, BuildContext context) {
    final bool isDarkMode =
        Get.put(VenueOwnerProfileController()).isDarkMode.value;
    final RxBool showEmojiPicker = false.obs;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      decoration: BoxDecoration(
        color: isDarkMode ? Color(0xff151515) : Color(0xffE6EBF0),
      ),
      child: SafeArea(
        child: Column(
          children: [
            // Chat Input Row
            Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: isDarkMode ? Color(0xff32383D) : Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        // Emoji Button
                        IconButton(
                          icon: const Icon(Icons.emoji_emotions_outlined),
                          color:
                              isDarkMode
                                  ? Color(0xffD4AF37)
                                  : AppColors.iconColor,
                          onPressed: () {
                            if (!showEmojiPicker.value) {
                              // Hide keyboard and show emoji picker
                              FocusScope.of(context).unfocus();
                              showEmojiPicker.value = true;
                            } else {
                              // Hide emoji picker
                              showEmojiPicker.value = false;
                            }
                          },
                        ),
                        const SizedBox(width: 8),
                        // Space between emoji icon and text field
                        Expanded(
                          child: TextField(
                            style: getTextStyle(
                              color: isDarkMode ? Colors.white : Colors.black,
                            ),
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
                            maxLines: null,
                            onTap: () {
                              // Hide emoji picker when keyboard is opened
                              if (showEmojiPicker.value) {
                                showEmojiPicker.value = false;
                              }
                            },
                          ),
                        ),
                        const SizedBox(width: 8),
                        // Space between text field and image icon
                        IconButton(
                          icon: const Icon(Icons.image),
                          color:
                              isDarkMode
                                  ? Color(0xffD4AF37)
                                  : AppColors.iconColor,
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
                // Send Button (only for messages)
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
                        showEmojiPicker.value =
                            false; // Hide emoji picker after sending
                      }
                    },
                    child: Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        color:
                            isDarkMode
                                ? Color(0xffD4AF37)
                                : AppColors.iconColor,
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
            SizedBox(height: 4),
            // Emoji Picker (below the input field)
            Obx(
              () => Offstage(
                offstage: !showEmojiPicker.value,
                child: SizedBox(
                  height: 250,
                  child: EmojiPicker(
                    onEmojiSelected: (category, emoji) {
                      controller.messageController.text += emoji.emoji;
                      // Do not hide the picker, allowing multiple selections
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
                        backgroundColor: Colors.white,
                        emojiSizeMax:
                            28 *
                            (foundation.defaultTargetPlatform ==
                                    TargetPlatform.iOS
                                ? 1.20
                                : 1.0),
                      ),
                      viewOrderConfig: ViewOrderConfig(
                        top: EmojiPickerItem.categoryBar,
                        middle: EmojiPickerItem.emojiView,
                        bottom: EmojiPickerItem.searchBar,
                      ),
                      skinToneConfig: SkinToneConfig(
                        indicatorColor: AppColors.iconColor,
                      ),
                      categoryViewConfig: CategoryViewConfig(
                        backgroundColor: Colors.white,
                        indicatorColor: AppColors.iconColor,
                      ),
                      bottomActionBarConfig: BottomActionBarConfig(
                        enabled: false,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
