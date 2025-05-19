import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:blinqo/core/utils/constants/icon_path.dart';
import 'package:blinqo/features/role/venue_owner/profile_page/controller/venue_owner_profile_controller.dart';
import 'package:blinqo/features/role/venue_owner/schedule_and_team/controller/create_shift_controller.dart';
import 'package:blinqo/features/role/venue_owner/schedule_and_team/controller/shif_controller.dart';
import 'package:blinqo/features/role/venue_owner/schedule_and_team/screen/add_employee_for_shift_screen.dart';
import 'package:blinqo/features/role/venue_owner/schedule_and_team/screen/create_employee_screen.dart';
import 'package:blinqo/features/role/venue_owner/schedule_and_team/widget/custom_calendar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateshiftScreen extends StatelessWidget {
  final String? title;
  final String venueId;

  const CreateshiftScreen({super.key, this.title, required this.venueId});

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode =
        Get.put(VenueOwnerProfileController()).isDarkMode.value;
    final ShiftController shiftController = Get.put(ShiftController());
    final CreateShiftController createShiftController = Get.put(
      CreateShiftController(),
    );
    final TextEditingController textEditingController = TextEditingController();
    final Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor:
          isDarkMode ? Color(0xff151515) : AppColors.backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(isDarkMode, screenSize.width),
                SizedBox(height: 19),
                SizedBox(width: double.infinity, child: CustomDatePicker()),
                SizedBox(height: 32),
                _buildTimeSelectionSection(shiftController, isDarkMode),
                SizedBox(height: 40),
                _buildShiftNameSection(textEditingController, isDarkMode),
                SizedBox(height: 40),
                _buildCreateButton(
                  createShiftController,
                  textEditingController,
                  venueId,
                  screenSize.height,
                  isDarkMode,
                ),
                SizedBox(height: 40),
                _buildEmployeeSection(shiftController, venueId, isDarkMode),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Build header with back button and title
  Widget _buildHeader(bool isDarkMode, double screenWidth) {
    return Row(
      children: [
        _buildBackButton(isDarkMode),
        SizedBox(width: screenWidth * 0.20),
        Text(
          title ?? 'Create Shift',
          style: getTextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: isDarkMode ? Color(0xffEBEBEB) : Color(0xff333333),
          ),
        ),
        Spacer(),
        if (title != null) _buildDeleteButton(isDarkMode),
      ],
    );
  }

  // Build back button
  Widget _buildBackButton(bool isDarkMode) {
    return InkWell(
      onTap: () => Get.back(),
      child: Container(
        height: 40,
        width: 40,
        decoration: BoxDecoration(
          color: const Color(0xff333333).withValues(alpha: .1),
          shape: BoxShape.circle,
        ),
        child: Center(
          child: Image.asset(
            IconPath.arrowLeftAlt,
            width: 20,
            height: 20,
            color: Color(0xff1C1B1F),
          ),
        ),
      ),
    );
  }

  // Build delete button
  Widget _buildDeleteButton(bool isDarkMode) {
    return InkWell(
      onTap: () {},
      child: Image.asset(
        IconPath.delete,
        color: isDarkMode ? Color(0xffD4AF37) : Color(0xff003366),
        height: 15,
        width: 15,
      ),
    );
  }

  // Build time selection section with start time, end time, and duration
  Widget _buildTimeSelectionSection(
    ShiftController shiftController,
    bool isDarkMode,
  ) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: _buildTimePicker(
                label: 'Start Time',
                time: shiftController.startTime,
                onTap:
                    () => _showTimePicker(shiftController, isStartTime: true),
                isDarkMode: isDarkMode,
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: _buildTimePicker(
                label: 'End Time',
                time: shiftController.endTime,
                onTap:
                    () => _showTimePicker(shiftController, isStartTime: false),
                isDarkMode: isDarkMode,
              ),
            ),
          ],
        ),
        SizedBox(height: 16),
        _buildDuration(shiftController, isDarkMode),
      ],
    );
  }

  // Build time picker field
  Widget _buildTimePicker({
    required String label,
    required Rx<TimeOfDay?> time,
    required VoidCallback onTap,
    required bool isDarkMode,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: getTextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: isDarkMode ? Color(0xffEBEBEB) : Color(0xff333333),
          ),
        ),
        SizedBox(height: 4),
        InkWell(
          onTap: onTap,
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 12, horizontal: 12),
            decoration: BoxDecoration(
              color: isDarkMode ? Color(0xff32383D) : Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: isDarkMode ? Color(0xff32383D) : Color(0xffEBEBEB),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Obx(
                    () => Text(
                      time.value == null
                          ? 'Select time'
                          : time.value!.format(Get.context!),
                      style: TextStyle(
                        fontSize: 14,
                        color:
                            time.value == null
                                ? Colors.grey
                                : isDarkMode
                                ? Color(0xffA1A1A1)
                                : Colors.black,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
                SizedBox(width: 8),
                Icon(
                  Icons.access_time,
                  size: 20,
                  color: isDarkMode ? Color(0xffD4AF37) : Color(0xff003366),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // Show time picker dialog
  void _showTimePicker(
    ShiftController shiftController, {
    required bool isStartTime,
  }) {
    showTimePicker(
      context: Get.context!,
      initialTime: TimeOfDay.now(),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.dark().copyWith(
            colorScheme: ColorScheme.dark(
              primary: Color(0xffD4AF37),
              onPrimary: Colors.white,
              surface: Color(0xff32383D),
              onSurface: Colors.white,
            ),
          ),
          child: child!,
        );
      },
    ).then((TimeOfDay? time) {
      if (time != null) {
        if (isStartTime) {
          shiftController.startTime.value = time;
        } else {
          shiftController.endTime.value = time;
        }
      }
    });
  }

  // Build duration display
  Widget _buildDuration(ShiftController shiftController, bool isDarkMode) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 12),
      decoration: BoxDecoration(
        color: isDarkMode ? Color(0xff32383D) : Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: isDarkMode ? Color(0xff32383D) : Color(0xffEBEBEB),
        ),
      ),
      child: Row(
        children: [
          Text(
            'Duration',
            style: getTextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: isDarkMode ? Color(0xffEBEBEB) : Color(0xff333333),
            ),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Obx(
              () => Text(
                shiftController.duration,
                style: TextStyle(
                  fontSize: 14,
                  color: isDarkMode ? Color(0xffA1A1A1) : Color(0xff333333),
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Build shift name section
  Widget _buildShiftNameSection(
    TextEditingController controller,
    bool isDarkMode,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Shift Name',
          style: getTextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: isDarkMode ? Color(0xffEBEBEB) : Color(0xff333333),
          ),
        ),
        SizedBox(height: 8),
        TextField(
          controller: controller,
          decoration: InputDecoration(
            hintText: 'Enter shift name',
            hintStyle: TextStyle(
              color: isDarkMode ? Color(0xffA1A1A1) : Color(0xffC0C0C0),
            ),
            filled: true,
            fillColor: isDarkMode ? Color(0xff32383D) : Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: isDarkMode ? Color(0xff32383D) : Color(0xffEBEBEB),
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: isDarkMode ? Color(0xff32383D) : Color(0xffEBEBEB),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: isDarkMode ? Color(0xffD4AF37) : Color(0xff003366),
              ),
            ),
            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          ),
          style: TextStyle(
            color: isDarkMode ? Color(0xffEBEBEB) : Colors.black,
            fontSize: 14,
          ),
        ),
      ],
    );
  }

  // Build create button
  Widget _buildCreateButton(
    CreateShiftController createShiftController,
    TextEditingController textEditingController,
    String venueId,
    double screenHeight,
    bool isDarkMode,
  ) {
    return Obx(
      () => GestureDetector(
        onTap:
            createShiftController.isLoading.value
                ? null
                : () {
                  createShiftController.createShift(
                    venueId: venueId,
                    shiftName: textEditingController.text,
                  );
                },
        child: Container(
          width: double.infinity,
          height: screenHeight * 0.070,
          decoration: BoxDecoration(
            color:
                createShiftController.isLoading.value
                    ? Color(0xff003366).withValues(alpha: .5)
                    : Color(0xff003366),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Center(
            child:
                createShiftController.isLoading.value
                    ? CircularProgressIndicator(color: Colors.white)
                    : Text(
                      'Create Shift',
                      style: getTextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Color(0xffF4F4F4),
                      ),
                    ),
          ),
        ),
      ),
    );
  }

  // Build employee section
  Widget _buildEmployeeSection(
    ShiftController shiftController,
    String venueId,
    bool isDarkMode,
  ) {
    return Column(
      children: [
        _buildEmployeeHeader(shiftController, isDarkMode),
        SizedBox(height: 20),
        _buildAddEmployeeButton(venueId, isDarkMode),
        SizedBox(height: 20),
        _buildEmployeeList(shiftController, venueId, isDarkMode),
      ],
    );
  }

  // Build employee header with count
  Widget _buildEmployeeHeader(
    ShiftController shiftController,
    bool isDarkMode,
  ) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Employees',
            style: getTextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: isDarkMode ? Color(0xffD4AF37) : Color(0xff333333),
            ),
          ),
          SizedBox(width: 20),
          Container(
            height: 25,
            width: 25,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              color: Color(0xffD4AF37).withValues(alpha: .1),
            ),
            child: Obx(
              () => Center(
                child: Text(
                  shiftController.selectedEmployees.length.toString(),
                  style: getTextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Color(0xffD4AF37),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Build add employee button
  Widget _buildAddEmployeeButton(String venueId, bool isDarkMode) {
    return Align(
      alignment: Alignment.centerRight,
      child: InkWell(
        onTap: () => Get.to(() => AddEmployeeForShift(venueId: venueId)),
        child: Container(
          height: 46,
          width: 53,
          decoration: BoxDecoration(
            color: Color(0xff003366),
            boxShadow: [
              BoxShadow(
                color: Color(0xff000000).withValues(alpha: .6),
                offset: Offset(0, 1),
                blurRadius: 2,
              ),
            ],
            borderRadius: BorderRadius.circular(34),
          ),
          child: Icon(Icons.add, color: Colors.white),
        ),
      ),
    );
  }

  // Build employee list
  Widget _buildEmployeeList(
    ShiftController shiftController,
    String venueId,
    bool isDarkMode,
  ) {
    return Obx(
      () => Column(
        children:
            shiftController.selectedEmployees.map((employee) {
              return Container(
                width: double.infinity,
                margin: EdgeInsets.only(bottom: 8),
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: isDarkMode ? Color(0xff32383D) : Color(0xffFFFFFF),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: isDarkMode ? Color(0xff32383D) : Color(0xffEBEBEB),
                    width: 1,
                  ),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            employee.name,
                            style: getTextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color:
                                  isDarkMode
                                      ? Color(0xffEBEBEB)
                                      : Color(0xff333333),
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            employee.position,
                            style: getTextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: Color(0xffA1A1A1),
                            ),
                          ),
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        // Simply remove the employee from the selected list
                        shiftController.selectedEmployees.remove(employee);
                      },
                      child: Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color:
                              isDarkMode
                                  ? Color(0xff2A2F34)
                                  : Color(0xffF8F9FA),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Icon(
                          Icons.remove_circle_outline,
                          size: 20,
                          color:
                              isDarkMode
                                  ? Color(0xffD4AF37)
                                  : Color(0xff003366),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
      ),
    );
  }
}
