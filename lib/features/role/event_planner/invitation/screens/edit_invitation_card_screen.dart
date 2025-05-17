import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/common/widgets/custom_appbar_widget.dart';
import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:blinqo/core/utils/constants/icon_path.dart';
import 'package:blinqo/features/role/event_planner/profile/controller/profile_controller.dart';
import 'package:blinqo/features/role/event_planner/profile/widget/f_custom_button.dart';
import 'package:blinqo/features/role/event_planner/profile/widget/f_label_text.dart';
import 'package:blinqo/features/role/event_planner/invitation/controller/edit_invitation_card_controller.dart';
import 'package:blinqo/features/role/event_planner/invitation/screens/invitation_card_screen.dart';
import 'package:blinqo/features/role/event_planner/invitation/widgets/invitation_card_text_form_field.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditInvitationCardScreen extends StatelessWidget {
  const EditInvitationCardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(EditInvitationCardController());
    return Scaffold(
      backgroundColor:
          Get.find<ProfileController>().isDarkMode.value
              ? AppColors.darkBackgroundColor
              : AppColors.backgroundColor,
      appBar: CustomAppBarWidget(
        onPressed: () => Get.back(),
        title: "Edit Invitation Card",
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 62),
              FLabelText(text: "Event Subject"),
              SizedBox(height: 6),
              InvitationCardTextFormField(hintText: "Jhon & Jeni Wedding"),
              SizedBox(height: 20),
              FLabelText(text: "Event Description"),
              SizedBox(height: 6),
              InvitationCardTextFormField(
                maxLines: 4,
                hintText: "Write Invitation Letter Here.....",
              ),
              SizedBox(height: 20),
              FLabelText(text: "Add Photos"),
              SizedBox(height: 6),
              // ------------
              GestureDetector(
                onTap: controller.pickImage,
                child: Obx(() {
                  return DottedBorder(
                    borderType: BorderType.RRect,
                    radius: Radius.circular(5),
                    color: AppColors.buttonColor2,
                    strokeWidth: 1.5,
                    dashPattern: [5, 3],
                    child: Container(
                      width: double.infinity,
                      height: 106,
                      decoration: BoxDecoration(
                        color: Color(0xFFE6EAF8),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child:
                          controller.uploadedImage.value == null
                              ? Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 8,
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
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
                              : PageView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: 1,
                                // profileController.tenImageUpload.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: EdgeInsets.all(4),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: Image.file(
                                        controller.uploadedImage.value!,
                                        width: 80,
                                        height: 80,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  );
                                },
                              ),
                    ),
                  );
                }),
              ),

              SizedBox(height: 20),
              FCustomButton(
                onPressed: () {
                  Get.off(() => InvitationCardScreen());
                },
                child: Text("Save & Change"),
              ),
              SizedBox(height: 20),

              // Row(
              //   children: [
              //     Expanded(
              //       child: ElevatedButton(
              //         onPressed: () {
              //           // Retrieve the controller and call the method
              //           Get.find<SelectedColorController>().changeColor(
              //             Color(0xFF00FF00),
              //           );
              //         },
              //         child: Text("Green"),
              //       ),
              //     ),
              //     Expanded(
              //       child: ElevatedButton(
              //         onPressed: () {
              //           // Retrieve the controller and call the method
              //           Get.find<SelectedColorController>().changeColor(
              //             Color(0xFF4B0082),
              //           ); // Indigo
              //         },
              //         child: Text("Indigo"),
              //       ),
              //     ),
              //   ],
              // ),
              // SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
