import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:blinqo/core/utils/constants/icon_path.dart';
import 'package:blinqo/core/utils/constants/image_path.dart';
import 'package:blinqo/features/role/venue_owner/profile_page/controller/venue_owner_profile_controller.dart';
import 'package:blinqo/features/role/venue_owner/schedule_and_team/controller/shif_controller.dart';
import 'package:blinqo/features/role/venue_owner/schedule_and_team/model/shift_response_model.dart';
import 'package:blinqo/features/role/venue_owner/schedule_and_team/screen/create_shift_screen.dart';
import 'package:blinqo/features/role/venue_owner/schedule_and_team/screen/shift_details_screen.dart';
import 'package:blinqo/features/role/venue_owner/schedule_and_team/widget/custom_calendar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';

class Schedule extends StatelessWidget {
  final String venueId;
  const Schedule({super.key, required this.venueId});

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode =
        Get.put(VenueOwnerProfileController()).isDarkMode.value;
    final ShiftController shiftController = Get.put(ShiftController());
    final Size screenSize = MediaQuery.of(context).size;
    final double screenHeight = screenSize.height;

    // Fetch shifts when screen loads
    shiftController.fetchAllShifts(venueId);

    return Scaffold(
      backgroundColor:
          isDarkMode ? Color(0xff151515) : AppColors.backgroundColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 26),
              // date picker
              SizedBox(width: double.infinity, child: const CustomDatePicker()),
              SizedBox(height: 40),
              // shift list
              SizedBox(
                width: double.infinity,
                child: Obx(() {
                  if (shiftController.isLoading.value) {
                    return _buildShimmerLoading(isDarkMode);
                  }

                  if (shiftController.shifts.isEmpty) {
                    return _buildEmptyState();
                  }

                  return _buildShiftList(shiftController, isDarkMode);
                }),
              ),
              SizedBox(height: 40),
              // add shift button
              _buildAddShiftButton(screenHeight, isDarkMode),
              SizedBox(height: 60),
            ],
          ),
        ),
      ),
    );
  }

  // Build shimmer loading effect
  Widget _buildShimmerLoading(bool isDarkMode) {
    return Shimmer.fromColors(
      baseColor: isDarkMode ? Color(0xff32383D) : Colors.grey[300]!,
      highlightColor: isDarkMode ? Color(0xff404040) : Colors.grey[100]!,
      child: ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: 3,
        itemBuilder: (context, index) {
          return Container(
            height: 120,
            margin: EdgeInsets.only(bottom: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
          );
        },
      ),
    );
  }

  // Build empty state
  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 80),
        child: Image.asset(
          ImagePath.empty,
          fit: BoxFit.cover,
          width: double.infinity,
        ),
      ),
    );
  }

  // Build shift list
  Widget _buildShiftList(ShiftController shiftController, bool isDarkMode) {
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: shiftController.shifts.length,
      itemBuilder: (context, index) {
        final shift = shiftController.shifts[index];
        return _buildShiftCard(shift, shiftController, isDarkMode);
      },
    );
  }

  // Build individual shift card
  Widget _buildShiftCard(
    ShiftData shift,
    ShiftController shiftController,
    bool isDarkMode,
  ) {
    return InkWell(
      onTap: () => Get.to(() => ShiftDetailsScreen(shift: shift)),
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.only(bottom: 12),
        padding: EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: isDarkMode ? Color(0xff32383D) : Color(0xffFFFFFF),
          border: Border.all(
            width: 1,
            color: isDarkMode ? Color(0xff32383D) : Color(0xffEBEBEB),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 12),
            _buildShiftHeader(shift, shiftController, isDarkMode),
            SizedBox(height: 8),
            _buildShiftTimeInfo(shift, isDarkMode),
            SizedBox(height: 8),
            _buildEmployeeCount(shift, isDarkMode),
            SizedBox(height: 12),
          ],
        ),
      ),
    );
  }

  // Build shift header with name and actions
  Widget _buildShiftHeader(
    ShiftData shift,
    ShiftController shiftController,
    bool isDarkMode,
  ) {
    return Row(
      children: [
        Expanded(
          child: Text(
            shift.shiftName,
            style: getTextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: isDarkMode ? Color(0xffEBEBEB) : Color(0xff000000),
            ),
          ),
        ),
        Row(
          children: [
            _buildActionButton(
              icon: IconPath.delete,
              onTap:
                  () => _showDeleteConfirmationDialog(
                    Get.context!,
                    shift.id,
                    venueId,
                    shiftController,
                  ),
              isDarkMode: isDarkMode,
            ),
            SizedBox(width: 18),
            _buildActionButton(
              icon: IconPath.editPencil,
              onTap: () {
                shiftController.loadShiftForEditing(shift);
                Get.to(
                  () => CreateshiftScreen(
                    title: shift.shiftName,
                    venueId: venueId,
                  ),
                );
              },
              isDarkMode: isDarkMode,
            ),
          ],
        ),
      ],
    );
  }

  // Build action button
  Widget _buildActionButton({
    required String icon,
    required VoidCallback onTap,
    required bool isDarkMode,
  }) {
    return InkWell(
      onTap: onTap,
      child: Image.asset(
        icon,
        height: 18,
        width: 18,
        color: isDarkMode ? Color(0xffD4AF37) : Color(0xff003366),
      ),
    );
  }

  // Build shift time information
  Widget _buildShiftTimeInfo(ShiftData shift, bool isDarkMode) {
    return Row(
      children: [
        Text(
          '${shift.startTime.hour.toString().padLeft(2, '0')}:${shift.startTime.minute.toString().padLeft(2, '0')} - ${shift.endTime.hour.toString().padLeft(2, '0')}:${shift.endTime.minute.toString().padLeft(2, '0')}',
          style: getTextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: isDarkMode ? Color(0xffC0C0C0) : Color(0xff5C5C5C),
          ),
        ),
        SizedBox(width: 16),
        Text(
          'Duration: ${shift.duration ~/ 60}h ${shift.duration % 60}m',
          style: getTextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: isDarkMode ? Color(0xffC0C0C0) : Color(0xff5C5C5C),
          ),
        ),
      ],
    );
  }

  // Build employee count
  Widget _buildEmployeeCount(ShiftData shift, bool isDarkMode) {
    return Row(
      children: [
        Text(
          'Employees ',
          style: getTextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: isDarkMode ? Color(0xffC0C0C0) : Color(0xff5C5C5C),
          ),
        ),
        SizedBox(width: 24),
        Container(
          height: 25,
          width: 25,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: Color(0xffD4AF37).withOpacity(0.10),
          ),
          child: Center(
            child: Text(
              shift.employee.length.toString(),
              style: getTextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: Color(0xffD4AF37),
              ),
            ),
          ),
        ),
      ],
    );
  }

  // Build add shift button
  Widget _buildAddShiftButton(double screenHeight, bool isDarkMode) {
    return InkWell(
      onTap: () {
        final shiftController = Get.find<ShiftController>();
        shiftController.resetForm();
        Get.to(() => CreateshiftScreen(venueId: venueId));
      },
      child: Container(
        width: double.infinity,
        height: screenHeight * 0.070,
        decoration: BoxDecoration(
          color: Color(0xff003366),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Add Shift',
                style: GoogleFonts.roboto(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Color(0xffF4F4F4),
                ),
              ),
              SizedBox(width: 15),
              Icon(Icons.add, color: Color(0xffF4F4F4), weight: 24),
            ],
          ),
        ),
      ),
    );
  }

  // Show delete confirmation dialog
  void _showDeleteConfirmationDialog(
    BuildContext context,
    String shiftId,
    String venueId,
    ShiftController controller,
  ) {
    final bool isDarkMode =
        Get.find<VenueOwnerProfileController>().isDarkMode.value;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          backgroundColor: isDarkMode ? Color(0xff32383D) : Colors.white,
          child: Container(
            padding: EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Color(0xffD4AF37).withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.delete_outline,
                    color: Color(0xffD4AF37),
                    size: 32,
                  ),
                ),
                SizedBox(height: 24),
                Text(
                  'Delete Shift',
                  style: getTextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: isDarkMode ? Color(0xffEBEBEB) : Color(0xff333333),
                  ),
                ),
                SizedBox(height: 12),
                Text(
                  'Are you sure you want to delete this shift? This action cannot be undone.',
                  textAlign: TextAlign.center,
                  style: getTextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: isDarkMode ? Color(0xffC0C0C0) : Color(0xff5C5C5C),
                  ),
                ),
                SizedBox(height: 24),
                Row(
                  children: [
                    Expanded(
                      child: TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                            side: BorderSide(
                              color:
                                  isDarkMode
                                      ? Color(0xffD4AF37)
                                      : Color(0xff003366),
                            ),
                          ),
                        ),
                        child: Text(
                          'Cancel',
                          style: getTextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color:
                                isDarkMode
                                    ? Color(0xffD4AF37)
                                    : Color(0xff003366),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          controller.deleteShift(shiftId, venueId);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xffD4AF37),
                          padding: EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Text(
                          'Delete',
                          style: getTextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
