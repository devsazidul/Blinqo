import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:io';
import '../controllers/chat_controller.dart';
import '../controllers/group_controller.dart';

class CreateGroupView extends StatelessWidget {
  final ChatController chatController = Get.find<ChatController>();
  final GroupController groupController = Get.find<GroupController>();
  final TextEditingController groupNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // Reset group creation state when entering this screen
    groupController.resetGroupCreation();

    return Scaffold(
      appBar: AppBar(
        title: Text('Create Group'),
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
        ),
        actions: [
          Obx(() => groupController.selectedMembers.isNotEmpty
              ? TextButton(
            onPressed: () {
              if (groupNameController.text.trim().isNotEmpty) {
                groupController.groupName.value = groupNameController.text.trim();
                groupController.createGroup();
              } else {
                Get.snackbar(
                  'Error',
                  'Please enter a group name',
                  snackPosition: SnackPosition.BOTTOM,
                );
              }
            },
            child: Text(
              'Create',
              style: TextStyle(
                color: Color(0xFF0A2647),
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          )
              : SizedBox.shrink()
          ),
        ],
      ),
      body: Column(
        children: [
          // Group info section
          Padding(
            padding: EdgeInsets.all(16),
            child: Row(
              children: [
                // Group avatar
                GestureDetector(
                  onTap: () => groupController.pickGroupAvatar(),
                  child: Obx(() {
                    final avatar = groupController.groupAvatar.value;
                    return CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.grey[200],
                      backgroundImage: avatar != null
                          ? FileImage(avatar)
                          : null,
                      child: avatar == null
                          ? Icon(Icons.camera_alt, color: Colors.grey[600])
                          : null,
                    );
                  }),
                ),
                SizedBox(width: 16),
                // Group name input
                Expanded(
                  child: TextField(
                    controller: groupNameController,
                    decoration: InputDecoration(
                      hintText: 'Group Name',
                      border: InputBorder.none,
                      hintStyle: TextStyle(
                        color: Colors.grey[500],
                      ),
                    ),
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                    onChanged: (value) {
                      groupController.groupName.value = value;
                    },
                  ),
                ),
              ],
            ),
          ),

          Divider(),

          // Selected members count
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                Text(
                  'Participants',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(width: 8),
                Obx(() => Text(
                  '${groupController.selectedMembers.length} selected',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                )),
              ],
            ),
          ),

          // Members list
          Expanded(
            child: ListView.builder(
              itemCount: chatController.users.length,
              itemBuilder: (context, index) {
                final user = chatController.users[index];
                return Obx(() {
                  final isSelected = groupController.selectedMembers.contains(user.id);
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(user.avatar),
                    ),
                    title: Text(user.name),
                    subtitle: Text(user.isOnline ? 'Online' : 'Offline'),
                    trailing: isSelected
                        ? Icon(Icons.check_circle, color: Color(0xFF0A2647))
                        : Icon(Icons.circle_outlined, color: Colors.grey),
                    onTap: () => groupController.toggleMemberSelection(user.id),
                  );
                });
              },
            ),
          ),

          // Create button for small screens
          Padding(
            padding: EdgeInsets.all(16),
            child: Obx(() => groupController.isCreatingGroup.value
                ? Center(
              child: CircularProgressIndicator(),
            )
                : ElevatedButton(
              onPressed: groupController.selectedMembers.isEmpty
                  ? null
                  : () {
                if (groupNameController.text.trim().isNotEmpty) {
                  groupController.groupName.value = groupNameController.text.trim();
                  groupController.createGroup();
                } else {
                  Get.snackbar(
                    'Error',
                    'Please enter a group name',
                    snackPosition: SnackPosition.BOTTOM,
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF0A2647),
                foregroundColor: Colors.white,
                minimumSize: Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                disabledBackgroundColor: Colors.grey[300],
              ),
              child: Text(
                'Create Group',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ),
          ),
        ],
      ),
    );
  }
}