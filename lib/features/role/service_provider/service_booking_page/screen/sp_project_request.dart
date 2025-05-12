import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/common/widgets/custom_continue_button.dart';
import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:blinqo/core/utils/constants/icon_path.dart';
import 'package:blinqo/features/role/service_provider/service_booking_page/controller/sp_project_requestcontroller.dart';
import 'package:blinqo/features/role/service_provider/service_booking_page/widget/accept_decline_button.dart';
import 'package:blinqo/features/role/service_provider/service_booking_page/widget/custom_p_request_row.dart';
import 'package:blinqo/features/role/service_provider/service_chat_page/screen/sp_chat_page.dart';
import 'package:blinqo/features/role/service_provider/sp_profile/controller/service_user_profile_controler.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SpProjectRequest extends StatelessWidget {
  SpProjectRequest({super.key});
  final SpProjectRequestcontroller spProjectRequestcontroller = Get.put(
    SpProjectRequestcontroller(),
  );
  final controller = Get.put(SpProfileController());
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final themeMode =
          controller.isDarkMode.value ? ThemeMode.dark : ThemeMode.light;
      return Scaffold(
        backgroundColor:
            themeMode == ThemeMode.dark
                ? Colors.black
                : AppColors.backgroundColor,
        appBar: AppBar(
          forceMaterialTransparency: true,
          leading: GestureDetector(
            onTap: () {
              Get.back();
            },
            child: Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: CircleAvatar(
                radius: 20,
                backgroundColor:
                    themeMode == ThemeMode.dark
                        ? AppColors.primary.withValues(alpha: .10)
                        : AppColors.textColor.withValues(alpha: .10),
                child: Image.asset(
                  IconPath.arrowleft,
                  width: 16,
                  height: 12,
                  color:
                      themeMode == ThemeMode.dark
                          ? AppColors.primary
                          : AppColors.textColor,
                ),
              ),
            ),
          ),
          centerTitle: true,
          title: Text(
            "Project Request ",
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
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              children: [
                Center(
                  child: CircleAvatar(
                    radius: 70,
                    backgroundColor: Colors.transparent,
                    child: Image.asset(
                      IconPath.projectrequestimage,
                      width: 125,
                      height: 125,
                    ),
                  ),
                ),
                SizedBox(height: 16),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    "John Deo Events",
                    style: getTextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color:
                          themeMode == ThemeMode.dark
                              ? AppColors.primary
                              : AppColors.buttonColor2,
                    ),
                  ),
                ),
                SizedBox(height: 4),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Organizer",
                    style: getTextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: AppColors.subtitleColor2,
                    ),
                  ),
                ),
                SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      IconPath.projectrequestlocation,
                      width: 16,
                      height: 16,
                    ),
                    SizedBox(width: 5),
                    Text(
                      "Radio Colony, Savar",
                      style: getTextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppColors.subtitleColor2,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 24),
                GestureDetector(
                  onTap: () {
                    Get.to(SpChatPage());
                  },
                  child: Container(
                    width: 148,
                    decoration: BoxDecoration(
                      color:
                          themeMode == ThemeMode.dark
                              ? AppColors.buttonColor.withValues(alpha: 0.10)
                              : AppColors.buttonColor2.withValues(alpha: 0.10),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 16.0,
                      ),
                      child: Row(
                        children: [
                          Image.asset(
                            IconPath.messageicon,
                            width: 16,
                            height: 16,
                            color:
                                themeMode == ThemeMode.dark
                                    ? AppColors.buttonColor
                                    : AppColors.buttonColor2,
                          ),
                          SizedBox(width: 5),
                          Text(
                            "Message",
                            style: getTextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color:
                                  themeMode == ThemeMode.dark
                                      ? AppColors.buttonColor
                                      : AppColors.buttonColor2,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 40),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Jhon’s Birthday",
                    style: getTextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color:
                          themeMode == ThemeMode.dark
                              ? AppColors.primary
                              : AppColors.buttonColor2,
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  decoration: BoxDecoration(
                    color:
                        themeMode == ThemeMode.dark
                            ? AppColors.textColor
                            : AppColors.primary,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      children: [
                        CustomPRequestRow(
                          title: 'Organizer',
                          eventName: 'John Doe Events',
                        ),
                        SizedBox(height: 16),
                        CustomPRequestRow(
                          title: 'venue',
                          eventName: 'The Garden Hall',
                        ),
                        SizedBox(height: 16),
                        CustomPRequestRow(
                          title: 'Location',
                          eventName: 'New York',
                        ),
                        SizedBox(height: 16),
                        CustomPRequestRow(
                          title: 'Date',
                          eventName: '15/03/2025',
                        ),
                        SizedBox(height: 16),
                        CustomPRequestRow(
                          title: 'Time',
                          eventName: '10:00am-4:00pm',
                        ),
                        SizedBox(height: 16),
                        CustomPRequestRow(title: 'Guest', eventName: '100'),
                        SizedBox(height: 16),
                        CustomPRequestRow(
                          title: 'Event Type',
                          eventName: 'Birthday',
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 40),
                Obx(() {
                  if (spProjectRequestcontroller.isAcceptClicked.value) {
                    return Column(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Set Price",
                            style: getTextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color:
                                  themeMode == ThemeMode.dark
                                      ? AppColors.primary
                                      : AppColors.buttonColor2,
                            ),
                          ),
                        ),
                        SizedBox(height: 6),

                        Obx(() {
                          return TextField(
                            controller:
                                spProjectRequestcontroller.psetpricecontroller,
                            onChanged: (text) {
                              spProjectRequestcontroller.enteredText.value =
                                  text;
                            },
                            enabled:
                                spProjectRequestcontroller.isEditable.value,
                            decoration: InputDecoration(
                              hintText: 'Enter Price',
                              hintStyle: getTextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: AppColors.buttonColor,
                              ),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: AppColors.subTextColor,
                                  width: 1.0,
                                ),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: AppColors.subTextColor,
                                  width: 1.0,
                                ),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: AppColors.subTextColor,
                                  width: 2.0,
                                ),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              filled: true,
                              fillColor: AppColors.primary,
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 8,
                              ),
                            ),
                            style: getTextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: AppColors.buttonColor,
                            ),
                          );
                        }),

                        SizedBox(height: 24),

                        Obx(() {
                          return Visibility(
                            visible:
                                spProjectRequestcontroller.isEditable.value,
                            child: CustomContinueButton(
                              onPress: () {
                                spProjectRequestcontroller.onSubmitTapped(
                                  spProjectRequestcontroller.enteredText.value,
                                );
                              },
                              title: "Submit",
                            ),
                          );
                        }),

                        SizedBox(height: 82),
                      ],
                    );
                  } else {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AcceptDeclineButton(
                          text: 'Decline',
                          width: 148,
                          backgroundColor:
                              themeMode == ThemeMode.dark
                                  ? AppColors.buttonColor2
                                  : AppColors.buttonColor2.withValues(
                                    alpha: 0.10,
                                  ),
                          textColor:
                              themeMode == ThemeMode.dark
                                  ? AppColors.primary
                                  : AppColors.buttonColor2,
                          fontSize: 16,
                          onTap: () {},
                        ),
                        SizedBox(width: 10),
                        AcceptDeclineButton(
                          text: 'Accept',
                          width: 148,
                          backgroundColor: AppColors.buttonColor2,
                          textColor: Colors.white,
                          fontSize: 16,
                          onTap: spProjectRequestcontroller.onAcceptTapped,
                        ),
                      ],
                    );
                  }
                }),

                SizedBox(height: 30),
              ],
            ),
          ),
        ),
      );
    });
  }
}
