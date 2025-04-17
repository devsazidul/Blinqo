import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:blinqo/features/role/event_planner/chat_screen/controller/ep_chat_controller.dart';
import 'package:blinqo/features/role/event_planner/chat_screen/screen/image_view.dart';
import 'package:blinqo/features/role/event_planner/chat_screen/widget/message_picker.dart';
import 'package:blinqo/features/role/service_provider/service_profile_page/controller/service_user_profile_controler.dart';
import 'package:blinqo/features/role/venue_owner/venue_chat_page/model/chat_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddMembers extends StatelessWidget {
  final EpChatController epChatController = Get.find<EpChatController>();
  final themeController = Get.find<SpProfileController>();

  AddMembers({super.key, required this.chatId});
  final String chatId;

  @override
  Widget build(BuildContext context) {
    final user = epChatController.getUserById(chatId);

    return Obx(() {
      final themeMode =
          themeController.isDarkMode.value ? ThemeMode.dark : ThemeMode.light;
      return Scaffold(
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
          ],
        ),
      );
    });
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
}
