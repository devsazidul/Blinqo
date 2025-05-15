import 'dart:io';

import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/utils/constants/colors.dart';
import 'package:blinqo/features/role/event_planner/profile_setup/controller/profile_setup_controller.dart';
import 'package:blinqo/features/role/event_planner/profile_setup/widgets/event_googlemap.dart';
import 'package:blinqo/features/role/event_planner/profile_setup/widgets/event_preference_circle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ProfileSetup extends StatelessWidget {
  ProfileSetup({super.key});
  final ProfileSetupController controller = Get.put(ProfileSetupController());
  final _formKey = GlobalKey<FormState>(); // Global key for form

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Profile Setup',
          style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.w600),
        ),
        actions: [
          IconButton(icon: const Icon(Icons.dark_mode), onPressed: () {}),
        ],
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.w),
        child: Form(
          key: _formKey, // Assigning the form key
          child: Column(
            children: [
              _buildProfilePictureSection(context),
              SizedBox(height: 20.h),
              _buildNameField(),
              SizedBox(height: 8.h),
              _buildGenderDropdown(),
              SizedBox(height: 10.h),
              _buildLocationField(),
              SizedBox(height: 10.h),
              _buildMapSection(),
              SizedBox(height: 20.h),
              _buildEventPreferencesSection(),
              SizedBox(height: 20.h),
              _buildUpgradeCard(),
              SizedBox(height: 40.h),
              _buildContinueButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfilePictureSection(BuildContext context) {
    return Stack(
      children: [
        Obx(
          () => CircleAvatar(
            radius: 48.r,
            backgroundColor: Colors.grey[300],
            backgroundImage:
                controller.selectedImagePath.value.isNotEmpty
                    ? FileImage(File(controller.selectedImagePath.value))
                    : null,
            child:
                controller.selectedImagePath.value.isEmpty
                    ? Icon(Icons.person, size: 48)
                    : null,
          ),
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: GestureDetector(
            onTap: () => _showImageSourceDialog(context),
            child: CircleAvatar(
              backgroundColor: AppColors.primary,
              child: Icon(Icons.edit, color: Color(0xff003366)),
            ),
          ),
        ),
      ],
    );
  }

  void _showImageSourceDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext dialogContext) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                leading: Icon(Icons.photo_library),
                title: Text('Choose from Gallery'),
                onTap: () async {
                  await controller.pickImage(ImageSource.gallery);
                  // ignore: use_build_context_synchronously
                  Navigator.pop(dialogContext);
                },
              ),
              ListTile(
                leading: Icon(Icons.camera_alt),
                title: Text('Take a Photo'),
                onTap: () async {
                  await controller.pickImage(ImageSource.camera);
                  // ignore: use_build_context_synchronously
                  Navigator.pop(dialogContext);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildNameField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: "User Name",
        hintText: "Type your Username",
        border: OutlineInputBorder(),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey, width: 1.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.green, width: 2.0),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red, width: 2.0),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red, width: 2.0),
        ),
      ),
      controller: controller.namecontroller,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your username';
        }
        if (value.length < 3) {
          return 'Username must be at least 3 characters long';
        }
        if (!RegExp(r'^[a-z0-9_]+$').hasMatch(value)) {
          return 'Username must contain only lowercase alphanumeric and underscore';
        }
        return null;
      },
      autovalidateMode: AutovalidateMode.onUserInteraction,
    );
  }

  Widget _buildGenderDropdown() {
    return Obx(
      () => DropdownButtonFormField<String>(
        value: controller.selectedGender.value,
        items:
            ['MALE', 'FEMALE', 'OTHER'].map((String value) {
              return DropdownMenuItem<String>(value: value, child: Text(value));
            }).toList(),
        onChanged: (newValue) {
          if (newValue != 'MALE') {
            controller.updateGender(newValue!);
          }
        },
        decoration: InputDecoration(border: OutlineInputBorder()),
      ),
    );
  }

  Widget _buildLocationField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: "Location",
        hintText: "Enter your location",
        border: OutlineInputBorder(),
      ),
      controller: controller.locationcontroller,
    );
  }

  Widget _buildMapSection() {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Select From Map',
            style: getTextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Color(0xff333333),
            ),
          ),
        ),
        SizedBox(height: 10.h),
        SizedBox(height: 200.h, child: EventGoogleMap()),
      ],
    );
  }

  Widget _buildEventPreferencesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Event Preference", style: TextStyle(fontSize: 20)),
        SizedBox(height: 20),
        Obx(() {
          if (controller.isLoadingEventPreference.value) {
            return Center(child: CircularProgressIndicator());
          }
          return GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 0.8,
            ),
            itemCount: controller.eventPreferenceList.length,
            itemBuilder: (context, index) {
              final event = controller.eventPreferenceList[index];
              return EventPreferenceCircleAvatar(
                eventPreference: event,
                isSelected: controller.selectedEvents.contains(event.id),
                onTap: () => controller.toggleEventSelection(event.id ?? ''),
              );
            },
          );
        }),
      ],
    );
  }

  Widget _buildUpgradeCard() {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [Colors.black, Color(0xff003285)]),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Upgrade to pro', style: getTextStyle(color: Colors.white)),
          SizedBox(height: 8),
          Text(
            'Boost Your Visibility & Get More Bookings with Premium!',
            style: getTextStyle(color: Colors.white),
          ),
          SizedBox(height: 12),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(backgroundColor: Color(0xffD4AF37)),
            child: Text(
              'Upgrade Now',
              style: getTextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContinueButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          if (_formKey.currentState?.validate() ?? false) {
            controller.submitProfileSetup();
          } else {
            debugPrint('Form is invalid');
          }
        },
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
          backgroundColor: Color(0xff003366),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Text(
          'Continue',
          style: getTextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Color(0xffFFFFFF),
          ),
        ),
      ),
    );
  }
}
