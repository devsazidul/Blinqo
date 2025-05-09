import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:blinqo/core/utils/constants/icon_path.dart';
import 'package:blinqo/features/role/venue_owner/profile_page/controller/venue_owner_profile_controller.dart';
import 'package:blinqo/features/role/venue_owner/venue_chat_page/model/chat_model.dart';
import 'package:blinqo/features/role/venue_owner/venue_chat_page/model/group_model.dart';
import 'package:blinqo/features/role/venue_owner/venue_chat_page/screens/imger_viewer_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' as foundation;
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'dart:io';
import '../controllers/chat_controller.dart';
import '../controllers/group_controller.dart';
import '../utils/date_utils.dart';
import 'group_info_view.dart';

class GroupChatView extends StatelessWidget {
  final String groupId;
  final GroupController groupController = Get.find<GroupController>();
  final ChatController chatController = Get.find<ChatController>();
  final TextEditingController messageController = TextEditingController();
  final ScrollController scrollController = ScrollController();
  final RxBool showEmojiPicker = false.obs;

  GroupChatView({super.key, required this.groupId});

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
                style: getTextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
                      groupController.pickImage(groupId, ImageSource.camera);
                    },
                  ),
                  _buildImagePickerOption(
                    icon: Icons.photo_library,
                    title: 'Gallery',
                    onTap: () {
                      Get.back();
                      groupController.pickImage(groupId, ImageSource.gallery);
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
              color: AppColors.iconColor.withValues(alpha:  0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: AppColors.iconColor, size: 30),
          ),
          SizedBox(height: 8),
          Text(
            title,
            style: getTextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }

  void _showGroupOptions() {
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
                'Leave Group',
                onTap: () {
                  Get.back();
                  _showLeaveGroupConfirmation();
                },
              ),
              _buildOptionItem(
                'Delete Conversation',
                onTap: () {
                  Get.back();
                  _showDeleteConversationConfirmation();
                },
              ),
              _buildOptionItem(
                'Mark as Unread',
                onTap: () {
                  Get.back();
                  Get.snackbar(
                    'Success',
                    'Conversation marked as unread',
                    snackPosition: SnackPosition.BOTTOM,
                  );
                },
              ),
              _buildOptionItem(
                'Report',
                onTap: () {
                  Get.back();
                  Get.snackbar(
                    'Report Sent',
                    'Thank you for your feedback',
                    snackPosition: SnackPosition.BOTTOM,
                  );
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

  void _showLeaveGroupConfirmation() {
    Get.dialog(
      AlertDialog(
        title: Text('Leave Group'),
        content: Text('Are you sure you want to leave this group?'),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text('Cancel', style: getTextStyle()),
          ),
          TextButton(
            onPressed: () {
              Get.back();
              groupController.leaveGroup(groupId);
            },
            child: Text('Leave', style: getTextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  void _showDeleteConversationConfirmation() {
    Get.dialog(
      AlertDialog(
        title: Text('Delete Conversation'),
        content: Text(
          'Are you sure you want to delete this conversation? This action cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text('Cancel', style: getTextStyle()),
          ),
          TextButton(
            onPressed: () {
              Get.back();
              Get.back(); // Go back to chat list
              Get.snackbar(
                'Success',
                'Conversation deleted',
                snackPosition: SnackPosition.BOTTOM,
              );
            },
            child: Text('Delete', style: getTextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode =
        Get.put(VenueOwnerProfileController()).isDarkMode.value;
    final group = groupController.getGroupById(groupId);

    if (group == null) {
      return Scaffold(
        backgroundColor: const Color(0xFFFFF5D7),
        appBar: AppBar(
          title: Text('Group Chat'),
          elevation: 0,
          backgroundColor: AppColors.backgroundColor,
        ),
        body: Center(child: Text('Group not found')),
      );
    }

    return Scaffold(
      backgroundColor: isDarkMode ? Color(0xff151515) : Color(0xFFE6EBF0),
      appBar: AppBar(
        automaticallyImplyLeading: false,
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
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
          side: BorderSide(color: Color(0xff003366), width: 1),
        ),
        elevation: 0,
        backgroundColor: isDarkMode ? Color(0xff32383D) : Color(0xffFFFFFF),
        forceMaterialTransparency: false,
        // leading: IconButton(
        //   icon: const Icon(Icons.arrow_back, size: 24),
        //   onPressed: () => Get.back(),
        // ),
        title: GestureDetector(
          onTap: () => Get.to(() => GroupInfoView(groupId: groupId)),
          child: Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundImage:
                    group.avatar.startsWith('http')
                        ? NetworkImage(group.avatar)
                        : FileImage(File(group.avatar)) as ImageProvider,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      group.name,
                      style: getTextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color:
                            isDarkMode ? Color(0xffEBEBEB) : Color(0xff333333),
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      'Online',
                      style: getTextStyle(fontSize: 14, color: Colors.green),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.more_vert,
              color: isDarkMode ? Colors.white : Colors.black,
              size: 28,
            ),
            onPressed: _showGroupOptions,
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: GetBuilder<GroupController>(
              builder: (controller) {
                final messages = controller.getGroupMessages(groupId);

                if (messages.isEmpty) {
                  return Center(child: Text('No messages yet'));
                }

                WidgetsBinding.instance.addPostFrameCallback((_) {
                  if (scrollController.hasClients) {
                    scrollController.jumpTo(
                      scrollController.position.maxScrollExtent,
                    );
                  }
                });

                return ListView.builder(
                  controller: scrollController,
                  padding: const EdgeInsets.all(16),
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    final message = messages[index];
                    final isCurrentUser =
                        message.senderId == chatController.currentUser.value.id;
                    final isSystemMessage = message.senderId == 'system';

                    if (isSystemMessage) {
                      return SystemMessage(text: message.text);
                    }

                    return GroupMessageBubble(
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
              },
            ),
          ),
          _buildUploadingIndicator(),
          _buildChatInput(context),
        ],
      ),
    );
  }

  Widget _buildUploadingIndicator() {
    return Obx(
      () =>
          groupController.isUploading.value
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

  Widget _buildChatInput(BuildContext context) {
    final bool isDarkMode =
        Get.put(VenueOwnerProfileController()).isDarkMode.value;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      decoration: BoxDecoration(
        color: isDarkMode ? Color(0xff151515) : Color(0xFFE6EBF0),
      ),
      child: SafeArea(
        child: Column(
          children: [
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
                        IconButton(
                          icon: const Icon(Icons.emoji_emotions_outlined),
                          color:
                              isDarkMode
                                  ? Color(0xffD4AF37)
                                  : AppColors.iconColor,
                          onPressed: () {
                            if (!showEmojiPicker.value) {
                              FocusScope.of(context).unfocus();
                              showEmojiPicker.value = true;
                            } else {
                              showEmojiPicker.value = false;
                            }
                          },
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: TextField(
                            style: getTextStyle(
                              color: isDarkMode ? Colors.white : Colors.black,
                            ),
                            controller: messageController,
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
                            onChanged: (text) {
                              groupController.isTyping.value =
                                  text.trim().isNotEmpty;
                            },
                            onTap: () {
                              if (showEmojiPicker.value) {
                                showEmojiPicker.value = false;
                              }
                            },
                          ),
                        ),
                        const SizedBox(width: 8),
                        IconButton(
                          icon: const Icon(Icons.image),
                          color:
                              isDarkMode
                                  ? Color(0xffD4AF37)
                                  : AppColors.iconColor,
                          onPressed: _showImagePickerOptions,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Obx(() {
                  final hasText = groupController.isTyping.value;
                  return GestureDetector(
                    onTap:
                        hasText
                            ? () {
                              groupController.sendGroupMessage(
                                groupId,
                                messageController.text.trim(),
                              );
                              messageController.clear();
                              showEmojiPicker.value = false;
                              Future.delayed(
                                const Duration(milliseconds: 100),
                                () {
                                  if (scrollController.hasClients) {
                                    scrollController.animateTo(
                                      scrollController.position.maxScrollExtent,
                                      duration: const Duration(
                                        milliseconds: 300,
                                      ),
                                      curve: Curves.easeOut,
                                    );
                                  }
                                },
                              );
                            }
                            : null,
                    child: Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        color:
                            hasText
                                ? (isDarkMode
                                    ? Color(0xffD4AF37)
                                    : AppColors.iconColor)
                                : (isDarkMode
                                    ? Color(0xffD4AF37).withValues(alpha: 0.5)
                                    : AppColors.iconColor.withValues(
                                      alpha: 0.5,
                                    )),
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
            Obx(
              () => Offstage(
                offstage: !showEmojiPicker.value,
                child: SizedBox(
                  height: 250,
                  child: EmojiPicker(
                    onEmojiSelected: (category, emoji) {
                      messageController.text += emoji.emoji;
                      groupController.isTyping.value =
                          messageController.text.trim().isNotEmpty;
                    },
                    onBackspacePressed: () {
                      messageController.text =
                          messageController.text.characters
                              .skipLast(1)
                              .toString();
                      groupController.isTyping.value =
                          messageController.text.trim().isNotEmpty;
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

class GroupMessageBubble extends StatelessWidget {
  final GroupMessage message;
  final bool isCurrentUser;
  final Function(String)? onImageTap;
  final Function(String)? onAudioTap;

  const GroupMessageBubble({
    super.key,
    required this.message,
    required this.isCurrentUser,
    this.onImageTap,
    this.onAudioTap,
  });

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode =
        Get.put(VenueOwnerProfileController()).isDarkMode.value;
    final ChatController chatController = Get.find<ChatController>();
    final sender = chatController.getUserById(message.senderId);
    final senderName = sender?.name.split(' ')[0] ?? 'Unknown';
    final senderAvatar = sender?.avatar ?? 'https://via.placeholder.com/150';

    return Align(
      alignment: isCurrentUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 4),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.8,
        ),
        child: Column(
          crossAxisAlignment:
          isCurrentUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            if (!isCurrentUser)
              Row(
                children: [
                  SizedBox(width: 30),
                  Padding(
                    padding: EdgeInsets.only(left: 12, bottom: 2),
                    child: Text(
                      senderName,
                      style: getTextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: isDarkMode ? Color(0xffEBEBEB) : Colors.black,
                      ),

                    ),
                  ),
                ],
              ),
            Row(
              mainAxisAlignment: isCurrentUser
                  ? MainAxisAlignment.end
                  : MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                if (!isCurrentUser) ...[
                  CircleAvatar(
                    radius: 14,
                    backgroundImage: senderAvatar.startsWith('http')
                        ? NetworkImage(senderAvatar)
                        : FileImage(File(senderAvatar)) as ImageProvider,
                  ),
                  const SizedBox(width: 8),
                ],
                Flexible(
                  child: Container(
                    decoration: BoxDecoration(
                      color: isCurrentUser ? Color(0xFF205295) : Color(0xFFF0F0F0),
                      borderRadius: BorderRadius.circular(16).copyWith(
                        bottomRight: isCurrentUser
                            ? Radius.circular(4)
                            : Radius.circular(16),
                        bottomLeft: !isCurrentUser
                            ? Radius.circular(4)
                            : Radius.circular(16),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        _buildMessageContent(context),
                        Padding(
                          padding: EdgeInsets.only(right: 8, bottom: 4, left: 8),
                          child: Text(
                            ChatDateUtils.formatTime(message.timestamp),
                            style: getTextStyle(
                              fontSize: 10,
                              color: isCurrentUser
                                  ? Colors.white.withValues(alpha:  0.7)
                                  : Colors.black.withValues(alpha:  0.5),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMessageContent(BuildContext context) {
    switch (message.type) {
      case MessageType.image:
        return GestureDetector(
          onTap:
              () =>
                  message.mediaUrl != null && onImageTap != null
                      ? onImageTap!(message.mediaUrl!)
                      : null,
          child: ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
            child:
                message.mediaUrl!.startsWith('http')
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
          onTap:
              () =>
                  message.mediaUrl != null && onAudioTap != null
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
                    color: Colors.black.withValues(alpha:  0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.play_arrow,
                    size: 16,
                    color: isCurrentUser ? Colors.white : Colors.black,
                  ),
                ),
                SizedBox(width: 8),
                SizedBox(
                  width: 100,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: List.generate(
                      15,
                      (index) => Expanded(
                        child: Container(
                          height: 4 + (index % 3) * 4.0,
                          margin: EdgeInsets.symmetric(horizontal: 1),
                          decoration: BoxDecoration(
                            color:
                                isCurrentUser
                                    ? Colors.white.withValues(alpha: 
                                      0.2 + (index % 5) * 0.15,
                                    )
                                    : Colors.black.withValues( alpha: 
                                      0.2 + (index % 5) * 0.15,
                                    ),
                            borderRadius: BorderRadius.circular(1.5),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 8),
                Text(
                  message.audioDuration ?? '0:00',
                  style: getTextStyle(
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
            style: getTextStyle(
              fontSize: 16,
              color: isCurrentUser ? Colors.white : Colors.black,
            ),
          ),
        );
    }
  }
}

class SystemMessage extends StatelessWidget {
  final String text;

  const SystemMessage({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      alignment: Alignment.center,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          text,
          style: getTextStyle(
            fontSize: 12,
            color: Colors.grey[800] ?? Colors.grey,
          ),
        ),
      ),
    );
  }
}
