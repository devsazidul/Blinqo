import 'dart:io';

import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/common/widgets/customcontinuebutton.dart';
import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:blinqo/core/utils/constants/icon_path.dart';
import 'package:blinqo/features/role/service_provider/service_profile_page/controller/service_user_profile_controler.dart';
import 'package:blinqo/features/role/service_provider/service_profile_page/controller/share_work_controller.dart';
import 'package:blinqo/features/role/service_provider/service_profile_page/widget/sp_profile_app_bar.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class SpShareWorkPage extends StatelessWidget {
  static const String name = '/sp_profile_share_work';

  SpShareWorkPage({
    super.key,
    this.isEditing = false,
    this.postIndex,
    this.eventType,
    this.projectTitle,
    this.description,
    this.photos,
  });

  final bool isEditing;
  final int? postIndex;
  final String? eventType;
  final String? projectTitle;
  final String? description;
  final List<XFile>? photos;

  final ShareWorkController _shareWorkController = Get.put(
    ShareWorkController(),
  );

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = Get.put(SpProfileController()).isDarkMode.value;
    return Scaffold(
      backgroundColor:
          isDarkMode
              ? AppColors.darkBackgroundColor
              : AppColors.backgroundColor,
      appBar: SpProfileAppBar(title: 'Share Work', isMoreVertIcon: false),
      body: ColoredBox(
        color:
            isDarkMode
                ? AppColors.darkBackgroundColor
                : AppColors.backgroundColor,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 4),
                Obx(
                  () => DropdownButtonFormField<String>(
                    icon: Icon(
                      Icons.keyboard_arrow_down_outlined,
                      color:
                          isDarkMode
                              ? AppColors.buttonColor
                              : AppColors.buttonColor2,
                    ),
                    items:
                        _shareWorkController.eventList.map((e) {
                          return DropdownMenuItem<String>(
                            value: e,
                            child: Text(
                              e,
                              style: getTextStyle(
                                color:
                                    isDarkMode
                                        ? Color(0xFFebebeb)
                                        : AppColors.textColor,
                              ),
                            ),
                          );
                        }).toList(),
                    decoration: InputDecoration(
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      labelText: "Event Type",
                      labelStyle: getTextStyle(
                        fontSize: 16,
                        color:
                            isDarkMode
                                ? Colors.grey.shade300
                                : AppColors.textColor,
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color:
                              isDarkMode ? AppColors.borderColor2 : Colors.grey,
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    value: _shareWorkController.selectedEvent.value,
                    onChanged: (String? newValue) {
                      if (newValue != null) {
                        _shareWorkController.selectedEvent.value = newValue;
                      }
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please select an event type";
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: _shareWorkController.titleController,
                  decoration: InputDecoration(
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    labelText: "Project Title",
                    labelStyle: getTextStyle(
                      fontSize: 16,
                      color:
                          isDarkMode
                              ? Colors.grey.shade300
                              : AppColors.textColor,
                    ),
                    hintText: "Birthday Party Photography",
                    hintStyle: getTextStyle(
                      fontSize: 14,
                      color:
                          isDarkMode ? Color(0xFFebebeb) : AppColors.textColor,
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color:
                            isDarkMode ? AppColors.borderColor2 : Colors.grey,
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: _shareWorkController.descriptionController,
                  maxLines: 3,
                  decoration: InputDecoration(
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    alignLabelWithHint: true,
                    labelText: "Project Description",
                    labelStyle: getTextStyle(
                      fontSize: 16,
                      color:
                          isDarkMode
                              ? Colors.grey.shade300
                              : AppColors.textColor,
                    ),
                    hintText: "write something about this project",
                    hintStyle: getTextStyle(
                      fontSize: 14,
                      color: isDarkMode ? Color(0xFFebebeb) : Color(0xFFA1A1A1),
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color:
                            isDarkMode ? AppColors.borderColor2 : Colors.grey,
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                SizedBox(height: 32),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Upload (Max 20 Photos)",
                    style: getTextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color:
                          isDarkMode
                              ? AppColors.buttonColor
                              : AppColors.buttonColor2,
                    ),
                  ),
                ),
                SizedBox(height: 8),
                GestureDetector(
                  onTap: _shareWorkController.pickImages,
                  child: Obx(() {
                    return DottedBorder(
                      borderType: BorderType.RRect,
                      radius: Radius.circular(5),
                      color: AppColors.buttonColor2,
                      strokeWidth: 1.5,
                      dashPattern: [5, 3],
                      child: Container(
                        width: double.infinity,
                        height: 110,
                        decoration: BoxDecoration(
                          color: Color(0xFFE6EAF8),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child:
                            _shareWorkController.selectedImages.isEmpty
                                ? Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 8,
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        IconPath.backup,
                                        height: 32,
                                        width: 32,
                                      ),
                                      SizedBox(height: 8),
                                      Text(
                                        'Select File',
                                        style: getTextStyle(
                                          color: AppColors.buttonColor2,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      SizedBox(height: 8),
                                      Text(
                                        'Supported formats: JPEG, PNG',
                                        style: getTextStyle(
                                          color: Color(0xFF898989),
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                                : GridView.builder(
                                  scrollDirection: Axis.horizontal,
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 1,
                                        childAspectRatio: 1,
                                        mainAxisSpacing: 8,
                                      ),
                                  itemCount:
                                      _shareWorkController
                                          .selectedImages
                                          .length,
                                  itemBuilder: (context, index) {
                                    return Stack(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.all(4),
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.circular(
                                              8,
                                            ),
                                            child: Image.file(
                                              File(
                                                _shareWorkController
                                                    .selectedImages[index]
                                                    .path,
                                              ),
                                              width: 80,
                                              height: 80,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          top: 0,
                                          right: 0,
                                          child: GestureDetector(
                                            onTap: () {
                                              _shareWorkController.removeImage(
                                                index,
                                              );
                                            },
                                            child: Container(
                                              padding: EdgeInsets.all(2),
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Colors.red,
                                              ),
                                              child: Icon(
                                                Icons.close,
                                                color: Colors.white,
                                                size: 16,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                ),
                      ),
                    );
                  }),
                ),
                SizedBox(height: 40),
                CustomContinueButton(
                  onPress: _shareWorkController.uploadToServer,
                  title: isEditing ? "Update" : "Upload",
                ),
                SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
