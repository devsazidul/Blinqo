import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:blinqo/features/role/event_planner/chat_screen/controller/ep_chat_controller.dart';
import 'package:blinqo/features/role/event_planner/chat_screen/widget/image_picker.dart';
import 'package:blinqo/features/role/service_provider/service_profile_page/controller/service_user_profile_controler.dart';
import 'package:blinqo/features/role/venue_owner/venue_chat_page/model/chat_model.dart';
import 'package:blinqo/features/role/venue_owner/venue_chat_page/screens/imger_viewer_view.dart';
import 'package:blinqo/features/role/venue_owner/venue_chat_page/widgets/message_bubble.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/foundation.dart' as foundation;
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatDetails extends StatelessWidget {
  final themeController = Get.find<SpProfileController>();

  ChatDetails({super.key, required this.chatId});
  final String chatId;

  @override
  Widget build(BuildContext context) {
    final EpChatController epChatController = Get.find<EpChatController>();

    final user = epChatController.getUserById(chatId);

    return Obx(() {
      final themeMode =
          themeController.isDarkMode.value ? ThemeMode.dark : ThemeMode.light;
      return Scaffold(
        backgroundColor:
            themeMode == ThemeMode.dark
                ? AppColors.darkBackgroundColor
                : AppColors.chatBackground,
        appBar: coustomAppBar(user, themeMode),
        body: Column(
          children: [
            Expanded(
              child: Obx(() {
                final messages = epChatController.messages[chatId] ?? [];
                return messages.isEmpty
                    ? userEmptyChat(user, themeMode)
                    : userMessageList(messages, epChatController);
              }),
            ),
            uploadingImage(epChatController),
            coustomTextField(epChatController, context),
          ],
        ),
      );
    });
  }

  AppBar coustomAppBar(User? user, ThemeMode themeMode) {
    return AppBar(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(12),
          bottomRight: Radius.circular(12),
        ),
      ),
      elevation: 0,
      forceMaterialTransparency: false,
      backgroundColor:
          themeMode == ThemeMode.dark
              ? AppColors.textFrieldDarkColor
              : Color(0xffFFFFFF),
      leadingWidth: 35,
      leading: CircleAvatar(
        backgroundColor: Color(0xffD9D9D9),
        child: IconButton(
          icon: Icon(Icons.arrow_back, size: 28),
          onPressed: () => Get.back(),
        ),
      ),
      title: Row(
        children: [
          CircleAvatar(
            radius: 20,
            backgroundImage: NetworkImage(user?.avatar ?? ''),
          ),
          SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                user?.name ?? '',
                style: getTextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color:
                      themeMode == ThemeMode.dark
                          ? AppColors.borderColor2
                          : AppColors.textColor,
                ),
              ),
              Text(
                user?.isOnline == true ? 'Online' : 'Offline',
                style: getTextStyle(
                  fontSize: 14,
                  color: user?.isOnline == true ? Colors.green : Colors.grey,
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
            size: 30,
            color:
                themeMode == ThemeMode.dark
                    ? AppColors.borderColor2
                    : AppColors.textColor,
          ),
          onPressed: () {},
        ),
      ],
    );
  }

  Widget userEmptyChat(User? user, ThemeMode themeMode) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Spacer(flex: 3),
        CircleAvatar(
          radius: 60,
          backgroundImage: NetworkImage(user?.avatar ?? ''),
        ),
        const SizedBox(height: 12),
        Text(
          user?.name ?? '',
          style: getTextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
            color:
                themeMode == ThemeMode.dark
                    ? AppColors.borderColor2
                    : AppColors.textColor,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'Say hello',
          style: getTextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color:
                themeMode == ThemeMode.dark
                    ? AppColors.darkTextColor
                    : AppColors.subTextColor,
          ),
        ),
        const Spacer(),
      ],
    );
  }

  Widget userMessageList(List<Message> messages, EpChatController controller) {
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

  Widget uploadingImage(EpChatController controller) {
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

  Widget coustomTextField(EpChatController controller, BuildContext context) {
    final RxBool showEmojiPicker = false.obs;
    final FocusNode focusNode = FocusNode();
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
                    // onEmojiSelected: (category, emoji) {
                    //   controller.messageController.text += emoji.emoji;
                    //   showEmojiPicker.value = false;
                    // },
                    // onBackspacePressed: () {
                    //   controller.messageController.text =
                    //       controller.messageController.text.characters
                    //           .skipLast(1)
                    //           .toString();
                    // },
                    // config: Config(
                    //   height: 256,
                    //   checkPlatformCompatibility: true,
                    //   emojiViewConfig: EmojiViewConfig(
                    //     emojiSizeMax:
                    //         28 *
                    //         (foundation.defaultTargetPlatform ==
                    //                 TargetPlatform.iOS
                    //             ? 1.20
                    //             : 1.0),
                    //   ),
                    //   bottomActionBarConfig: BottomActionBarConfig(
                    //     showSearchViewButton: false,
                    //     showBackspaceButton: false,
                    //   ),
                    // ),
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
                          icon: Icon(Icons.emoji_emotions_outlined),
                          color: AppColors.iconColor,
                          onPressed: () {
                            showEmojiPicker.value = !showEmojiPicker.value;
                            if (showEmojiPicker.value) {
                              FocusScope.of(context).unfocus();
                            } else {
                              FocusScope.of(context).requestFocus();
                            }
                          },
                        ),
                        Expanded(
                          child: TextField(
                            onTap: () {
                              controller.showImage(showEmojiPicker.value);
                            },
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
                                ImagesPicker(
                                  chatId: chatId,
                                  epChatController: controller,
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
