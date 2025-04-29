import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:blinqo/features/profile/controller/profile_controller.dart';
import 'package:blinqo/features/role/event_planner/chat_screen/controller/ep_chat_controller.dart';
import 'package:blinqo/features/role/event_planner/chat_screen/controller/ep_create_group_controller.dart';
import 'package:blinqo/features/role/event_planner/chat_screen/screen/group_profile.dart';
import 'package:blinqo/features/role/event_planner/chat_screen/screen/image_view.dart';
import 'package:blinqo/features/role/event_planner/chat_screen/widget/image_picker.dart';
import 'package:blinqo/features/role/event_planner/chat_screen/widget/message_picker.dart';
import 'package:blinqo/features/role/event_planner/chat_screen/widget/pop_up_menu.dart';
import 'package:blinqo/features/role/venue_owner/venue_chat_page/model/chat_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatDetails extends StatelessWidget {
  final ProfileController themeController = Get.put(ProfileController());

  ChatDetails({super.key, required this.chatId});
  final String chatId;

  @override
  Widget build(BuildContext context) {
    final EpChatController epChatController = Get.find<EpChatController>();

    final user = epChatController.getUserById(chatId);
    bool isDarkMode = themeController.isDarkMode.value;

    return Scaffold(
      backgroundColor:
          isDarkMode ? AppColors.darkBackgroundColor : AppColors.chatBackground,
      appBar: customAppBar(user, isDarkMode),
      body: Column(
        children: [
          Expanded(
            child: Obx(() {
              final messages = epChatController.messages[chatId] ?? [];
              return messages.isEmpty
                  ? userEmptyChat(user, isDarkMode)
                  : userMessageList(messages, epChatController);
            }),
          ),
          coustomTextField(epChatController, isDarkMode, context),
        ],
      ),
    );
  }

  AppBar customAppBar(User? user, bool isDarkMode) {
    final EpCreateGroupController epCreateGroupController = Get.put(
      EpCreateGroupController(),
    );
    return AppBar(
      automaticallyImplyLeading: false,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(12),
          bottomRight: Radius.circular(12),
        ),
      ),
      flexibleSpace: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(16),
            bottomRight: Radius.circular(12),
          ),
          border: Border(bottom: BorderSide(color: AppColors.iconColor)),
        ),
      ),
      elevation: 0,
      forceMaterialTransparency: false,
      backgroundColor:
          isDarkMode ? AppColors.textFrieldDarkColor : AppColors.primary,
      title: Row(
        children: [
          CircleAvatar(
            backgroundColor:
                isDarkMode
                    ? AppColors.primary.withValues(alpha: 0.1)
                    : AppColors.textColor.withValues(alpha: 0.15),
            child: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: isDarkMode ? AppColors.primary : AppColors.textColor,
              ),
              onPressed: () => Get.back(),
            ),
          ),
          SizedBox(width: 10),
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  if (epCreateGroupController.groupUsers.containsKey(chatId)) {
                    Get.to(GroupProfile(chatId: chatId));
                  }
                },
                child: CircleAvatar(
                  radius: 20,
                  backgroundImage: NetworkImage(
                    user?.avatar ?? 'https://via.placeholder.com/150',
                  ),
                ),
              ),
              SizedBox(width: 10),
              GestureDetector(
                onTap: () {
                  if (epCreateGroupController.groupUsers.containsKey(chatId)) {
                    Get.to(GroupProfile(chatId: chatId));
                  }
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user?.name ?? '',
                      style: getTextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color:
                            isDarkMode
                                ? AppColors.borderColor2
                                : AppColors.textColor,
                      ),
                    ),
                    Text(
                      user?.isOnline == true ? 'Online' : 'Offline',
                      style: getTextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color:
                            user?.isOnline == true
                                ? AppColors.statusColor
                                : Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),

      actions: [PopUpMenu(isDarkMode: isDarkMode)],
    );
  }

  Widget userEmptyChat(User? user, bool isDarkMode) {
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
            color: isDarkMode ? AppColors.borderColor2 : AppColors.textColor,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'Say hello',
          style: getTextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color:
                isDarkMode ? AppColors.darkTextColor : AppColors.subTextColor,
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
        return MessagePicker(
          message: message,
          isCurrentUser: isCurrentUser,
          onImageTap: (url) {
            Get.to(() => ImageView(imageUrl: url));
          },
        );
      },
    );
  }

  Widget coustomTextField(
    EpChatController controller,
    bool isDarkMode,
    BuildContext context,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      decoration: BoxDecoration(
        color:
            isDarkMode
                ? AppColors.darkBackgroundColor
                : AppColors.chatBackground,
      ),
      child: SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.textFrieldDarkColor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        IconButton(
                          icon: Icon(Icons.emoji_emotions_outlined),
                          color: AppColors.buttonColor,
                          onPressed: () {
                            Get.to(GroupProfile(chatId: chatId));
                          },
                        ),
                        Expanded(
                          child: TextField(
                            onTap: () {},
                            controller: controller.messageController,
                            decoration: InputDecoration(
                              hintText: 'Type Message',
                              hintStyle: getTextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w400,
                                color: AppColors.hintTextColor,
                              ),
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              contentPadding: const EdgeInsets.symmetric(
                                vertical: 10,
                              ),
                            ),
                            style: getTextStyle(color: AppColors.hintTextColor),
                            maxLines: 1,
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.add_link_sharp),
                          color: AppColors.buttonColor,
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
                      child: Icon(
                        Icons.send,
                        color: AppColors.buttonColor,
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
