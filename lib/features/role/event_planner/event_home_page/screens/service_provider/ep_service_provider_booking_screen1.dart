// ignore_for_file: library_prefixes

import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:blinqo/core/utils/constants/icon_path.dart';
import 'package:blinqo/features/role/event_planner/chat_screen/screen/ep_chat_screen.dart';
import 'package:blinqo/features/role/event_planner/event_home_page/controllers/ep_service_provider_controller/ep_custom_calender.dart';
import 'package:blinqo/features/role/event_planner/event_home_page/controllers/ep_service_provider_controller/ep_service_provider_booking_controller.dart';
import 'package:blinqo/features/role/event_planner/event_home_page/screens/service_provider/ep_service_porovider_booking_screen2.dart';
import 'package:blinqo/features/role/event_planner/event_home_page/sharch_start_booking/screen/search_start_booking.dart'
    as eventPlanner;
import 'package:blinqo/features/role/event_planner/event_home_page/widgets/ep_status_label.dart';
import 'package:blinqo/features/role/event_planner/profile/controller/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:step_indicator_package/step_indicator.dart';

class EpServiceProviderBookingScreen1 extends StatelessWidget {
  final EpServiceProviderBookingController controller = Get.put(
    EpServiceProviderBookingController(),
  );

  EpServiceProviderBookingScreen1({super.key});

  Future<void> _selectDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2022),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      controller.selectedDate.value = picked;
    }
  }

  Future<void> _selectTime(BuildContext context, bool isStartTime) async {
    TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay(hour: 0, minute: 0),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: Colors.blue,
            hintColor: Colors.orange,
            buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      if (isStartTime) {
        controller.startTime.value = picked;
      } else {
        controller.endTime.value = picked;
      }
    }
  }

  final profileController = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = profileController.isDarkMode.value;
    final myController = StepIndicatorController(maxSteps: 3);
    Future.delayed(Duration(milliseconds: 400), () {
      myController.setStep(0);
    });
    return Scaffold(
      backgroundColor:
          isDarkMode
              ? AppColors.darkBackgroundColor
              : AppColors.backgroundColor,
      appBar: AppBar(
        forceMaterialTransparency: true,
        leading: Padding(
          padding: EdgeInsets.only(left: 20.0),
          child: GestureDetector(
            onTap: () {
              Get.back();
            },
            child: CircleAvatar(
              radius: 20,
              backgroundColor:
                  isDarkMode
                      ? AppColors.primary.withValues(alpha: .10)
                      : AppColors.appBarIcolor,
              child: Image.asset(
                IconPath.arrowleft,
                width: 20,
                height: 20,
                color: isDarkMode ? AppColors.primary : AppColors.textColor,
              ),
            ),
          ),
        ),
        title: Text(
          'Booking',
          style: getTextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: isDarkMode ? AppColors.primary : AppColors.textColor,
          ),
        ),
        centerTitle: true,
      ),

      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 10),
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
            SizedBox(height: 10),
            Text(
              'Ronald Richards',
              style: getTextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: isDarkMode ? AppColors.primary : AppColors.buttonColor2,
              ),
            ),
            SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  IconPath.projectrequestlocation,
                  width: 16,
                  height: 16,
                  fit: BoxFit.cover,
                  color:
                      isDarkMode ? AppColors.primary : AppColors.subTextColor,
                ),
                SizedBox(width: 10),
                Text(
                  'Radio Colony, Savar',
                  style: getTextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color:
                        isDarkMode ? AppColors.primary : AppColors.subTextColor,
                  ),
                ),
              ],
            ),
            SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '4.5',
                  style: getTextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color:
                        isDarkMode ? AppColors.primary : AppColors.subTextColor,
                  ),
                ),
                SizedBox(width: 4),
                Image.asset(
                  IconPath.ratinglogo,
                  width: 11,
                  height: 12,
                  color:
                      isDarkMode ? AppColors.primary : AppColors.subTextColor,
                ),
                SizedBox(width: 30),
                Text(
                  'Project - 10',
                  style: getTextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color:
                        isDarkMode ? AppColors.primary : AppColors.subTextColor,
                  ),
                ),
              ],
            ),

            SizedBox(height: 15),

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                foregroundColor:
                    isDarkMode ? AppColors.buttonColor : AppColors.buttonColor2,
                backgroundColor:
                    isDarkMode
                        ? AppColors.buttonColor.withValues(alpha: .10)
                        : AppColors.chatBackground,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () {
                Get.to(() => EpChatScreen());
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    IconPath.messageicon,
                    width: 20,
                    height: 20,
                    color:
                        isDarkMode
                            ? AppColors.buttonColor
                            : AppColors.buttonColor2,
                  ),
                  SizedBox(width: 8),
                  Text(
                    "Message",
                    style: getTextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color:
                          isDarkMode
                              ? AppColors.buttonColor
                              : AppColors.buttonColor2,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 20),
            Text(
              "Booking Timeline",
              style: getTextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color:
                    isDarkMode ? AppColors.buttonColor : AppColors.buttonColor2,
              ),
            ),
            SizedBox(height: 20),
            StepIndicator(
              controller: myController,
              allowCircleTap: false,
              circleRadius: 18,
              paddingHorizontal: 60,
              showNavigationButtons: false,
              activeLineColor:
                  isDarkMode ? AppColors.buttonColor : AppColors.buttonColor2,
              activeColor:
                  isDarkMode ? AppColors.buttonColor : AppColors.buttonColor2,
            ),

            SizedBox(height: 20),
            Text(
              "Availability",
              style: getTextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: isDarkMode ? AppColors.primary : AppColors.textColor,
              ),
            ),
            SizedBox(height: 16),
            EpCustomCalender(
              selectedDatesNotifier: eventPlanner.selectedDatesNotifier,
            ),
            SizedBox(height: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                EpStatusLabel(
                  color:
                      isDarkMode
                          ? AppColors.darkCalendarColor
                          : AppColors.darkTextColor,
                  label: 'Booked',
                ),
                SizedBox(height: 8),
                EpStatusLabel(
                  color:
                      isDarkMode
                          ? AppColors.darkCalendarColor2
                          : AppColors.buttonColor,
                  label: 'Selected',
                ),
              ],
            ),
            SizedBox(height: 12),
            Container(
              decoration: BoxDecoration(
                color:
                    isDarkMode
                        ? AppColors.textFrieldDarkColor
                        : AppColors.primary,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Selected Date",
                          style: getTextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color:
                                isDarkMode
                                    ? AppColors.primary
                                    : AppColors.subTextColor,
                          ),
                        ),
                        Text(
                          "1 November, 2025",
                          style: getTextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color:
                                isDarkMode
                                    ? AppColors.darkCalendarColor2
                                    : AppColors.buttonColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Price",
                          style: getTextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color:
                                isDarkMode
                                    ? AppColors.primary
                                    : AppColors.textColor,
                          ),
                        ),
                        Text(
                          "\$5000",
                          style: getTextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color:
                                isDarkMode
                                    ? AppColors.darkCalendarColor2
                                    : AppColors.buttonColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 20),
            _buildFormFields(context),

            SizedBox(height: 20),

            // SEND REQUEST BUTTON
            Center(
              child: ElevatedButton(
                onPressed: () {
                  controller.currentStep.value = 2;
                  Get.to(() => EpServicePoroviderBookingScreen2());
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF003366),
                  foregroundColor: Colors.white,
                  minimumSize: Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  "Send Request",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildFormFields(BuildContext context) {
    bool isDarkMode = profileController.isDarkMode.value;
    return Column(
      children: [
        _buildTextField('Event Name', controller.eventName),
        _buildTextField('Event Planner Name', controller.eventPlannerName),
        _buildTextField('Venue', controller.venue),
        _buildTextField('Location', controller.location),

        SizedBox(height: 20),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "Set Date",
            style: getTextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color:
                  isDarkMode ? AppColors.primary : AppColors.dopdownTextColor,
            ),
          ),
        ),
        SizedBox(height: 6),
        // Set Date
        Obx(
          () => Container(
            decoration: BoxDecoration(
              color: isDarkMode ? Color(0x26979797) : Color(0x26979797),
              borderRadius: BorderRadius.circular(4),
            ),
            child: ListTile(
              contentPadding: EdgeInsets.symmetric(vertical: 6, horizontal: 12),
              leading: Image.asset(
                IconPath.epservicecalender,
                width: 24,
                height: 24,
                fit: BoxFit.cover,
                color:
                    isDarkMode
                        ? AppColors.buttonColor
                        : AppColors.dopdownTextColor,
              ),
              title: Text(
                "Selecte a day",
                style: getTextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color:
                      isDarkMode
                          ? AppColors.subTextColor2
                          : AppColors.dopdownTextColor,
                ),
              ),
              subtitle: Text(
                controller.selectedDate.value == null
                    ? 'Select Date'
                    : '${controller.selectedDate.value!.toLocal()}'.split(
                      ' ',
                    )[0],
                style: getTextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color:
                      isDarkMode
                          ? AppColors.buttonColor
                          : AppColors.dopdownTextColor,
                ),
              ),
              trailing: Image.asset(
                IconPath.backButton,
                width: 24,
                height: 24,
                fit: BoxFit.cover,
                color:
                    isDarkMode ? AppColors.primary : AppColors.dopdownTextColor,
              ),
              onTap: () => _selectDate(context),
            ),
          ),
        ),
        SizedBox(height: 20),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "Set Time",
            style: getTextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color:
                  isDarkMode ? AppColors.primary : AppColors.dopdownTextColor,
            ),
          ),
        ),
        SizedBox(height: 6),
        // Set Time
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Obx(
              () => GestureDetector(
                onTap: () => _selectTime(context, true),
                child: Container(
                  height: 52,
                  width: 159,
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Color(0x26979797),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image.asset(
                        IconPath.epserviceclock,
                        width: 18,
                        height: 18,
                        fit: BoxFit.cover,
                        color:
                            isDarkMode
                                ? AppColors.buttonColor
                                : AppColors.dopdownTextColor,
                      ),
                      Column(
                        children: [
                          Text(
                            "Start time",
                            style: getTextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color:
                                  isDarkMode
                                      ? AppColors.primary
                                      : AppColors.textColor,
                            ),
                          ),
                          Text(
                            controller.startTime.value.format(context),
                            style: getTextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color:
                                  isDarkMode
                                      ? AppColors.buttonColor
                                      : AppColors.buttonColor2,
                            ),
                          ),
                        ],
                      ),
                      Image.asset(
                        IconPath.backButton,
                        width: 24,
                        height: 24,
                        fit: BoxFit.cover,
                        color:
                            isDarkMode
                                ? AppColors.primary
                                : AppColors.buttonColor2,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(width: 35),
            Expanded(
              child: Obx(
                () => GestureDetector(
                  onTap: () => _selectTime(context, false),
                  child: Container(
                    height: 52,
                    width: 158,
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Color(0x26979797),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Image.asset(
                          IconPath.epserviceclock,
                          width: 18,
                          height: 18,
                          fit: BoxFit.cover,
                          color:
                              isDarkMode
                                  ? AppColors.buttonColor
                                  : AppColors.dopdownTextColor,
                        ),
                        Column(
                          children: [
                            Text(
                              "End time",
                              style: getTextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color:
                                    isDarkMode
                                        ? AppColors.primary
                                        : AppColors.textColor,
                              ),
                            ),
                            Text(
                              controller.endTime.value.format(context),
                              style: getTextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color:
                                    isDarkMode
                                        ? AppColors.buttonColor
                                        : AppColors.buttonColor2,
                              ),
                            ),
                          ],
                        ),
                        Image.asset(
                          IconPath.backButton,
                          width: 24,
                          height: 24,
                          fit: BoxFit.cover,
                          color:
                              isDarkMode
                                  ? AppColors.primary
                                  : AppColors.buttonColor2,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),

        _buildTextField(
          "Number of Guests",
          controller.numberOfGuests,
          //isNumber: true,
        ),
        SizedBox(height: 20),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "Event Type",
            style: getTextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color:
                  isDarkMode ? AppColors.primary : AppColors.dopdownTextColor,
            ),
          ),
        ),
        SizedBox(height: 6),
        Obx(
          () => Container(
            padding: EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(4),
            ),
            child: DropdownButton<String>(
              value:
                  controller.eventType.value.isEmpty
                      ? null
                      : controller.eventType.value,
              hint: Text('Select Event Type'),
              onChanged: (newValue) {
                controller.eventType.value = newValue!;
              },
              isExpanded: true,

              dropdownColor:
                  isDarkMode ? AppColors.textColor : AppColors.backgroundColor,
              items:
                  <String>[
                    'Birthday',
                    'Wedding',
                    'Conference',
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: getTextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color:
                              isDarkMode
                                  ? AppColors.primary
                                  : AppColors.textColor,
                        ),
                      ),
                    );
                  }).toList(),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTextField(String label, RxString controller) {
    bool isDarkMode = profileController.isDarkMode.value;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: getTextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color:
                  isDarkMode ? AppColors.primary : AppColors.dopdownTextColor,
            ),
          ),
          SizedBox(height: 8),
          TextField(
            onChanged: (value) => controller.value = value,
            style: getTextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color:
                  isDarkMode ? AppColors.primary : AppColors.dopdownTextColor,
            ),
            decoration: InputDecoration(
              hintText: label,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
