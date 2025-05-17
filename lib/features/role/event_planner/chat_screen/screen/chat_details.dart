import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:blinqo/features/role/event_planner/chat_screen/controller/ep_chat_controller.dart';
import 'package:blinqo/features/role/event_planner/chat_screen/controller/ep_create_group_controller.dart';
import 'package:blinqo/features/role/event_planner/chat_screen/screen/group_profile.dart';
import 'package:blinqo/features/role/event_planner/chat_screen/screen/image_view.dart';
import 'package:blinqo/features/role/event_planner/chat_screen/widget/coustom_textField.dart';
import 'package:blinqo/features/role/event_planner/chat_screen/widget/message_picker.dart';
import 'package:blinqo/features/role/event_planner/chat_screen/widget/pop_up_menu.dart';
import 'package:blinqo/features/role/event_planner/profile/controller/pick_color_controller.dart';
import 'package:blinqo/features/role/event_planner/profile/controller/profile_controller.dart';
import 'package:blinqo/features/role/venue_owner/venue_chat_page/model/chat_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatDetails extends StatelessWidget {
  final ProfileController themeController = Get.put(ProfileController());
  final PickColorController femaleColorController = Get.put(
    PickColorController(),
  );

  ChatDetails({super.key, required this.chatId});
  final String chatId;

  @override
  Widget build(BuildContext context) {
    final EpChatController epChatController = Get.find<EpChatController>();
    final user = epChatController.getUserById(chatId);
    final bool isDarkMode = themeController.isDarkMode.value;
    final bool isFemale = femaleColorController.isFemale.value;

    return Scaffold(
      appBar: customAppBar(user, isDarkMode, isFemale, femaleColorController),
      body: ColoredBox(
        color:
            isDarkMode
                ? AppColors.darkBackgroundColor
                : isFemale
                ? femaleColorController.selectedColor.withValues(alpha: 0.13)
                : AppColors.chatBackground,
        child: Column(
          children: [
            Expanded(
              child: Obx(() {
                final messages = epChatController.messages[chatId] ?? [];
                return messages.isEmpty
                    ? userEmptyChat(user, isDarkMode)
                    : userMessageList(messages, epChatController, isFemale);
              }),
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: coustomTextField(
                epChatController,
                isDarkMode,
                context,
                chatId,
                isFemale,
                femaleColorController,
              ),
            ),
          ],
        ),
      ),
    );
  }

  AppBar customAppBar(
    User? user,
    bool isDarkMode,
    bool isFemale,
    PickColorController femaleColorController,
  ) {
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
          border: Border(
            bottom: BorderSide(
              color:
                  isDarkMode
                      ? AppColors.iconColor
                      : isFemale
                      ? femaleColorController.selectedColor
                      : AppColors.iconColor,
            ),
          ),
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
        // const Spacer(flex: 3),
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
        const SizedBox(height: 8),
        Text(
          'Say hello',
          style: getTextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color:
                isDarkMode ? AppColors.darkTextColor : AppColors.subTextColor,
          ),
        ),
        // const Spacer(),
      ],
    );
  }

  Widget userMessageList(
    List<Message> messages,
    EpChatController controller,
    bool isFemale,
  ) {
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
          isFemale: isFemale,
          femaleColorController: femaleColorController,
        );
      },
    );
  }
}
