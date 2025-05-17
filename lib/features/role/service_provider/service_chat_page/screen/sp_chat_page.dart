import 'package:blinqo/features/role/service_provider/service_chat_page/screen/sp_group_chat_page.dart';
import 'package:blinqo/features/role/service_provider/service_chat_page/screen/sp_single_page_chat.dart'
    show SpSinglePageChat;
import 'package:blinqo/features/role/service_provider/service_chat_page/widget/sp_custom_chat_list.dart';
import 'package:blinqo/features/role/service_provider/sp_profile/controller/sp_profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:blinqo/features/role/service_provider/service_chat_page/controller/sp_chat_controller.dart';

class SpChatPage extends StatelessWidget {
  SpChatPage({super.key});
  final controller = Get.put(SpProfileController());
  final SpChatController spChatController = Get.put(SpChatController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final themeMode =
          controller.isDarkMode.value ? ThemeMode.dark : ThemeMode.light;
      return Scaffold(
        backgroundColor:
            themeMode == ThemeMode.dark
                ? AppColors.darkBackgroundColor
                : AppColors.backgroundColor,
        appBar: AppBar(
          forceMaterialTransparency: true,
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: Text(
            "Chat",
            style: getTextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color:
                  themeMode == ThemeMode.dark
                      ? AppColors.primary
                      : AppColors.textColor,
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: spChatController.chats.length,
            itemBuilder: (context, index) {
              final chat = spChatController.chats[index];

              if (chat["type"] == "group") {
                // Handle Group Chat
                return GestureDetector(
                  onTap: () {
                    Get.to(() => SpGroupChatPage(groupChat: chat));
                  },
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundImage: AssetImage(chat['image'] ?? ''),
                    ),
                    title: Text(chat['groupName'] ?? 'Group'),
                    subtitle: Text(chat['message']),
                    trailing: Text(chat['time']),
                  ),
                );
              } else {
                // Handle Individual Chat
                return GestureDetector(
                  onTap: () {
                    Get.to(() => SpSinglePageChat(chat: chat));
                  },
                  child: SpCustomChatList(
                    imagePath: chat['image'] ?? '',
                    name: chat['name'] ?? '',
                    lastMessage: chat['message'] ?? '',
                    time: chat['time'] ?? '',
                  ),
                );
              }
            },
          ),
        ),
      );
    });
  }
}

// class SpChatPage extends StatelessWidget {
//   SpChatPage({super.key});
//   final controller = Get.put(SpProfileController());
//   final SpChatController spChatController = Get.put(SpChatController());

//   @override
//   Widget build(BuildContext context) {
//     return Obx(() {
//       final themeMode =
//           controller.isDarkMode.value ? ThemeMode.dark : ThemeMode.light;
//       return Scaffold(
//         backgroundColor:
//             themeMode == ThemeMode.dark
//                 ? AppColors.darkBackgroundColor
//                 : AppColors.backgroundColor,
//         appBar: AppBar(
//           forceMaterialTransparency: true,
//           automaticallyImplyLeading: false,
//           centerTitle: true,
//           title: Text(
//             "Chat",
//             style: getTextStyle(
//               fontSize: 20,
//               fontWeight: FontWeight.w700,
//               color:
//                   themeMode == ThemeMode.dark
//                       ? AppColors.primary
//                       : AppColors.textColor,
//             ),
//           ),
//         ),
//         body: Padding(
//           padding: const EdgeInsets.only(left: 20.0),
//           child: ListView.builder(
//             shrinkWrap: true,
//             itemCount: spChatController.chats.length,
//             itemBuilder: (context, index) {
//               final chat = spChatController.chats[index];
//               return GestureDetector(
//                 onTap: () {
//                   Get.to(() => SpSinglePageChat(chat: chat));
//                 },
//                 child: SpCustomChatList(
//                   imagePath: chat['image'] ?? '',
//                   name: chat['name'] ?? '',
//                   lastMessage: chat['message'] ?? '',
//                   time: chat['time'] ?? '',
//                 ),
//               );
//             },
//           ),
//         ),
//       );
//     });
//   }
// }
