import 'dart:io';

import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:blinqo/features/role/event_planner/chat_screen/controller/ep_chat_controller.dart';
import 'package:blinqo/features/role/venue_owner/venue_chat_page/model/chat_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class EpCreateGroupController extends GetxController {
  Rx<TextEditingController> groupNameController = TextEditingController().obs;
  RxList<String> selectedMembers = <String>[].obs;
  var profileImage = Rx<File?>(null);

  Map<String, List<String>> groupUsers = {};
  // RxMap<String, List<String>> groupUsers =
  //     <String, List<String>>{}.obs; // {groupId: [userIds, userIds]}

  Future<void> pickImage() async {
    await requestPermissions();

    final ImagePicker picker = ImagePicker();

    final ImageSource? source = await showPickrOption();

    if (source != null) {
      final XFile? pickedFile = await picker.pickImage(source: source);

      if (pickedFile != null) {
        profileImage.value = File(pickedFile.path);
      } else {
        debugPrint("No image selected");
      }
    }
  }

  Future<void> requestPermissions() async {
    PermissionStatus cameraStatus = await Permission.camera.request();
    PermissionStatus storageStatus = await Permission.storage.request();

    if (cameraStatus.isDenied || storageStatus.isDenied) {
      debugPrint("Permission denied");
    } else {
      debugPrint("Permission granted");
    }
  }

  Future<ImageSource?> showPickrOption() async {
    return await Get.bottomSheet(
      Container(
        padding: EdgeInsets.all(20),
        color: AppColors.primary,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Choose Image Source",
              style: getTextStyle(color: AppColors.textColor, fontSize: 20),
            ),
            SizedBox(height: 20),
            ListTile(
              leading: Icon(Icons.camera_alt, color: AppColors.textColor),
              title: Text(
                "Camera",
                style: getTextStyle(color: AppColors.textColor),
              ),
              onTap: () {
                Get.back(result: ImageSource.camera);
              },
            ),
            ListTile(
              leading: Icon(Icons.image, color: AppColors.textColor),
              title: Text(
                "Gallery",
                style: getTextStyle(color: AppColors.textColor),
              ),
              onTap: () {
                Get.back(result: ImageSource.gallery);
              },
            ),
          ],
        ),
      ),
    );
  }

  /// create group
  void createGroup() {
    final EpChatController epChatController = Get.put(EpChatController());

    // Generate a unique chatId for the new group
    String chatId = "group${DateTime.now().millisecondsSinceEpoch}";

    // Create a new user for the group
    User groupUser = User(
      id: chatId,
      name: groupNameController.value.text,
      avatar:
          "https://plus.unsplash.com/premium_photo-1673795753320-a9df2df4461e?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxmZWF0dXJlZC1waG90b3MtZmVlZHwyfHx8ZW58MHx8fHx8",
      isOnline: true,
    );

    // Add the group to the groupUsers map
    groupUsers[chatId] = selectedMembers.toList();

    // Add the user to the users list
    epChatController.users.add(groupUser);

    // Create a ChatPreview for the group
    epChatController.chats.add(
      ChatPreview(
        id: chatId,
        user: groupUser,
        lastMessage: Message(
          id: '',
          senderId: '',
          receiverId: '',
          text: 'No messages yet',
          timestamp: DateTime.now().millisecondsSinceEpoch,
          isRead: true,
          type: MessageType.text,
        ),
        unreadCount: 0,
      ),
    );

    // Clear the group name and image
    groupNameController.value.clear();
    profileImage.value = null;

    Get.back();
  }

  void removeUserFromGroup(groupId, index) {
    groupUsers[groupId]!.remove(index);
    update();
  }

  @override
  void onClose() {
    groupNameController.value.dispose();
    super.onClose();
  }
}
