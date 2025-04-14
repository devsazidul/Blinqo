import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:blinqo/core/utils/constants/image_path.dart';
import 'package:blinqo/features/role/event_planner/chat_screen/controller/ep_chat_screen_controller.dart';
import 'package:blinqo/features/role/event_planner/chat_screen/screen/chat_details.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EPChatScreen extends StatelessWidget {
  final EpChatScreenController epChatScreenController = Get.put(
    EpChatScreenController(),
  );
  EPChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Chat',
          style: TextStyle(
            fontSize: screenHeight * 0.04,
            fontWeight: FontWeight.w600,
            color: AppColors.textColor,
          ),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        forceMaterialTransparency: true,
      ),
      body: ListView.builder(
        shrinkWrap: true,
        itemCount: 15,
        itemBuilder: (context, index) {
          return ChatList(
            onTap: () {
              Get.to(() => ChatDetails());
              debugPrint('object$index');
            },
          );
        },
      ),
    );
  }
}

class ChatList extends StatelessWidget {
  final Function()? onTap;
  const ChatList({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Padding(
      padding: const EdgeInsets.all(1),
      child: ListTile(
        onTap: onTap,
        dense: true,
        leading: CircleAvatar(
          backgroundImage: AssetImage(ImagePath.profile),
          radius: 24,
        ),
        title: Text(
          'Mia Wilson',
          style: getTextStyle(
            fontSize: screenHeight * 0.023,
            fontWeight: FontWeight.w500,
            color: AppColors.textColor,
          ),
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Text(
          'No message',
          style: getTextStyle(
            fontSize: screenHeight * 0.017,
            fontWeight: FontWeight.w400,
            color: AppColors.subTextColor,
          ),
          overflow: TextOverflow.ellipsis,
        ),
        trailing: Text(
          '10:10',
          style: getTextStyle(
            fontSize: screenHeight * 0.017,
            fontWeight: FontWeight.w400,
            color: AppColors.subTextColor2,
          ),
        ),
      ),
    );
  }
}
