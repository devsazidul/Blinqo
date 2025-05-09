
// ignore_for_file: file_names

import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:blinqo/core/utils/constants/icon_path.dart';
import 'package:blinqo/core/utils/constants/image_path.dart';
import 'package:blinqo/features/profile/controller/profile_controller.dart';
import 'package:blinqo/features/profile/widget/f_custom_button.dart';
import 'package:blinqo/features/role/event_planner/chat_screen/controller/ep_chat_controller.dart';
import 'package:blinqo/features/role/event_planner/chat_screen/controller/ep_create_group_controller.dart';
import 'package:blinqo/features/role/event_planner/chat_screen/screen/chat_details.dart';
import 'package:blinqo/features/role/event_planner/chat_screen/widget/date_picker.dart';
import 'package:blinqo/features/role/venue_owner/venue_chat_page/model/chat_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EpChatScreen extends StatelessWidget {
  final EpChatController epChatController = Get.put(EpChatController());
  final ProfileController themeController = Get.put(ProfileController());

  EpChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = themeController.isDarkMode.value;
    return Scaffold(
      backgroundColor:
          isDarkMode
              ? AppColors.darkBackgroundColor
              : AppColors.backgroundColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        forceMaterialTransparency: true,
        centerTitle: true,
        title: Text(
          'Chat',
          style: getTextStyle(
            fontSize: 32,
            fontWeight: FontWeight.w600,
            color: isDarkMode ? AppColors.borderColor2 : AppColors.textColor,
          ),
        ),
        elevation: 0,
        backgroundColor:
            isDarkMode
                ? AppColors.darkBackgroundColor
                : AppColors.backgroundColor,
      ),

      body: Stack(
        children: [
          Obx(() {
            final chats = epChatController.chats;

            ///* If there are no conversations yet then show no content background
            if (chats.isEmpty) {
              return SafeArea(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        ImagePath.nocontentbackground,
                        height: 250,
                        width: 230,
                      ),
                      Text(
                        'No conversations yet',
                        style: getTextStyle(
                          fontSize: 16,
                          color: AppColors.textColor,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }

            ///* If there are conversations then show the list of conversations
            return ListView.builder(
              itemCount: chats.length,
              itemBuilder: (context, index) {
                return ChatList(
                  isDarkMode: isDarkMode,
                  chat: chats[index],
                  onTap: () {
                    epChatController.setActiveChat(chats[index].id);
                    Get.to(() => ChatDetails(chatId: chats[index].id));
                    debugPrint(chats[index].id);
                  },
                );
              },
            );
          }),

          Positioned(
            bottom: 100,
            right: 15,
            child: SizedBox(
              width: 48,
              height: 40,
              child: FloatingActionButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(34),
                ),
                backgroundColor: Color(0xFF003366),
                onPressed: () {
                  Get.dialog(_openCreateGroupDialog());
                },
                child: Icon(Icons.add, color: Color(0xFFE6EBF0)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  AlertDialog _openCreateGroupDialog() {
    final epCreateGroupController = Get.put(EpCreateGroupController());
    final existingGroupIds = epCreateGroupController.groupUsers.keys.toList();
    epCreateGroupController.selectedMembers.clear();
    return AlertDialog(
      backgroundColor: AppColors.backgroundColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      content: SingleChildScrollView(
        // Added SingleChildScrollView to prevent overflow
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            /// Circular Avatar
            GestureDetector(
              onTap: () {
                // Open gallery or camera and update the image
                Get.put(EpCreateGroupController()).pickImage();
              },
              child: Obx(
                () => Stack(
                  children: [
                    SizedBox(width: 48, height: 48),
                    CircleAvatar(
                      backgroundColor: Color(0xFFD9D9D9),
                      radius: 24,
                      child:
                          epCreateGroupController.profileImage.value == null
                              ? null
                              : ClipOval(
                                child: Image.file(
                                  epCreateGroupController.profileImage.value!,
                                  fit: BoxFit.cover,
                                  width: 48,
                                  height: 48,
                                ),
                              ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: CircleAvatar(
                        radius: 6,
                        child: Image.asset(IconPath.edit),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            Align(
              alignment: Alignment.centerRight,
              child: Obx(() {
                return Text(
                  "${epCreateGroupController.selectedMembers.length} Members",
                );
              }),
            ),

            /// TextFormField
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Group Name",
                style: getTextStyle(
                  fontSize: 14,
                  color: Color(0xFF003285),
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            TextField(
              controller: epCreateGroupController.groupNameController.value,
              decoration: InputDecoration(
                hintText: "Jhon & Jeni Wedding",
                hintStyle: getTextStyle(
                  fontSize: 14,
                  color: Color(0xFF868686),
                  fontWeight: FontWeight.w400,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                  borderSide: BorderSide(color: Color(0xFFABB7C2), width: 1),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                  borderSide: BorderSide(color: Color(0xFFABB7C2), width: 1),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                  borderSide: BorderSide(color: Color(0xFFABB7C2), width: 1),
                ),
              ),
            ),

            /// Users list
            for (int i = 0; i < epChatController.users.length; i++)
              if (!existingGroupIds.contains(epChatController.users[i].id))
                Obx(() {
                  return ListTile(
                    onTap: () {
                      if (epCreateGroupController.selectedMembers.contains(
                        epChatController.users[i].id,
                      )) {
                        epCreateGroupController.selectedMembers.remove(
                          epChatController.users[i].id,
                        );
                      } else {
                        epCreateGroupController.selectedMembers.add(
                          epChatController.users[i].id,
                        );
                      }
                    },
                    tileColor:
                        epCreateGroupController.selectedMembers.contains(
                              epChatController.users[i].id,
                            )
                            ? Color(0xFF003366).withAlpha(50)
                            : Colors.transparent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    leading: CircleAvatar(
                      radius: 12,
                      backgroundColor: Colors.grey[300],
                      child: ClipOval(
                        child: Image.network(
                          epChatController.users[i].avatar,
                          width: 24,
                          height: 24,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    title: Text(epChatController.users[i].name),

                    trailing: Obx(() {
                      return epCreateGroupController.selectedMembers.contains(
                            epChatController.users[i].id,
                          )
                          ? Icon(Icons.check, color: Colors.white)
                          : Container(
                            width: 24,
                            height: 24,
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              shape: BoxShape.circle,
                            ),
                            child: Icon(Icons.add, color: Colors.white),
                          );
                    }),
                  );
                }),

            /// Elevated Button
            SizedBox(height: 20),
            FCustomButton(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Create Group"),
                  SizedBox(width: 10), // Added space between text and icon
                  Image.asset(
                    IconPath.messageicon,
                    width: 16.67,
                    height: 16.67,
                    color: Colors.white,
                  ),
                ],
              ),

              onPressed: () {
                epCreateGroupController.createGroup();
              },
            ),
          ],
        ),
      ),
    );
  }
}

class ChatList extends StatelessWidget {
  final ChatPreview chat;
  final VoidCallback onTap;
  final bool isDarkMode;

  const ChatList({
    super.key,
    required this.chat,
    required this.onTap,
    required this.isDarkMode,
  });

  @override
  Widget build(BuildContext context) {
    final user = chat.user;
    final lastMessage = chat.lastMessage;
    String messagePreview;
    switch (lastMessage.type) {
      case MessageType.text:
        messagePreview =
            lastMessage.text.length > 30
                ? '${lastMessage.text.substring(0, 25)}...'
                : lastMessage.text;
        break;
      case MessageType.image:
        messagePreview = '📷 Image';
        break;
      case MessageType.audio:
        messagePreview = '';
        break;
    }

    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: Colors.grey[300],
              radius: 25,
              backgroundImage: NetworkImage(user.avatar),
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ///* ------------ User name
                      Text(
                        user.name,
                        style: getTextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color:
                              isDarkMode
                                  ? AppColors.borderColor2
                                  : AppColors.textColor,
                        ),
                      ),

                      ///* ------------ Last message time
                      Text(
                        DatePicker.formatMessageTime(
                          lastMessage.timestamp.toInt(),
                        ),
                        style: getTextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: AppColors.subTextColor2,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 4),

                  ///* ------------ Message preview
                  Text(
                    messagePreview,
                    style: getTextStyle(
                      fontSize: 14,
                      color:
                          chat.unreadCount > 0
                              ? AppColors.subTextColor
                              : AppColors.subTextColor,
                      fontWeight:
                          chat.unreadCount > 0
                              ? FontWeight.w400
                              : FontWeight.w400,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
