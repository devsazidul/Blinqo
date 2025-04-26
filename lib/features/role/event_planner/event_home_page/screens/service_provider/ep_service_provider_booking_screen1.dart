import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:blinqo/core/utils/constants/icon_path.dart';
import 'package:blinqo/features/profile/controller/profile_controller.dart';
import 'package:blinqo/features/role/event_planner/chat_screen/screen/ep_chat_screen.dart';
import 'package:blinqo/features/role/event_planner/event_home_page/controllers/ep_service_provider_controller/ep_service_provider_booking_controller.dart';
import 'package:blinqo/features/role/event_planner/event_home_page/screens/service_provider/ep_service_porovider_booking_screen2.dart';
import 'package:blinqo/features/role/event_planner/event_home_page/screens/service_provider/ep_service_provider_step_indicator.dart';
import 'package:blinqo/features/role/event_planner/event_home_page/sharch_start_booking/screen/search_start_booking.dart'
    as eventPlanner;
import 'package:blinqo/features/role/service_provider/service_booking_page/widget/sp_custom_calender.dart';
import 'package:blinqo/features/role/service_provider/service_booking_page/widget/sp_status_label.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
              backgroundColor: AppColors.appBarIcolor,
              child: Image.asset(
                IconPath.arrowleft,
                width: 20,
                height: 20,
                color: AppColors.textColor,
              ),
            ),
          ),
        ),
        title: Text(
          'Booking',
          style: getTextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: AppColors.textColor,
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
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: Color(0xFF003285),
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
                ),
                SizedBox(width: 10),
                const Text('Radio Colony, Savar'),
              ],
            ),
            const SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('4.5'),
                SizedBox(width: 4),
                Image.asset(IconPath.ratinglogo, width: 11, height: 12),
                SizedBox(width: 30),
                const Text('Project - 10'),
              ],
            ),

            const SizedBox(height: 15),

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                foregroundColor: Color(0xFF003366),
                backgroundColor: Color(0xFFE6EBF0),
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
                  Image.asset(IconPath.messageicon, width: 20, height: 20),
                  SizedBox(width: 8),
                  Text(
                    "Message",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),

            SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [EpServiceProviderStepIndicator()],
            ),
            SizedBox(height: 20),
            Text(
              "Availability",
              style: getTextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: AppColors.textColor,
              ),
            ),
            SizedBox(height: 16),
            SpCustomCalender(
              selectedDatesNotifier: eventPlanner.selectedDatesNotifier,
            ),
            SizedBox(height: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SpStatusLabel(
                  color:
                      isDarkMode
                          ? AppColors.darkCalendarColor
                          : AppColors.darkTextColor,
                  label: 'Booked',
                ),
                SizedBox(height: 8),
                SpStatusLabel(
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
                            color: AppColors.textColor,
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
              color: AppColors.dopdownTextColor,
            ),
          ),
        ),
        SizedBox(height: 6),
        // Set Date
        Obx(
          () => Container(
            decoration: BoxDecoration(
              color: Color(0x26979797),
              borderRadius: BorderRadius.circular(4),
            ),
            child: ListTile(
              contentPadding: EdgeInsets.symmetric(vertical: 6, horizontal: 12),
              leading: Image.asset(
                IconPath.epservicecalender,
                width: 24,
                height: 24,
                fit: BoxFit.cover,
              ),
              title: Text("Selecte a day"),
              subtitle: Text(
                controller.selectedDate.value == null
                    ? 'Select Date'
                    : '${controller.selectedDate.value!.toLocal()}'.split(
                      ' ',
                    )[0],
                style: getTextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: AppColors.dopdownTextColor,
                ),
              ),
              trailing: Image.asset(
                IconPath.backButton,
                width: 24,
                height: 24,
                fit: BoxFit.cover,
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
              color: AppColors.dopdownTextColor,
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
                      ),
                      Column(
                        children: [
                          Text(
                            "Start time",
                            style: getTextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: AppColors.textColor,
                            ),
                          ),
                          Text(
                            controller.startTime.value.format(context),
                            style: getTextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: AppColors.buttonColor2,
                            ),
                          ),
                        ],
                      ),
                      Image.asset(
                        IconPath.backButton,
                        width: 24,
                        height: 24,
                        fit: BoxFit.cover,
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
                        ),
                        Column(
                          children: [
                            Text(
                              "End time",
                              style: getTextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: AppColors.textColor,
                              ),
                            ),
                            Text(
                              controller.endTime.value.format(context),
                              style: getTextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: AppColors.buttonColor2,
                              ),
                            ),
                          ],
                        ),
                        Image.asset(
                          IconPath.backButton,
                          width: 24,
                          height: 24,
                          fit: BoxFit.cover,
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
              color: AppColors.dopdownTextColor,
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
              items:
                  <String>[
                    'Birthday',
                    'Wedding',
                    'Conference',
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTextField(String label, RxString controller) {
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
              color: AppColors.dopdownTextColor,
            ),
          ),
          SizedBox(height: 8),
          TextField(
            onChanged: (value) => controller.value = value,
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
