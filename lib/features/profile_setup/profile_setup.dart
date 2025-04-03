import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../core/utils/theme/custom_themes/text_theme.dart';

class ProfileSetup extends StatelessWidget {
  const ProfileSetup({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      // Get the current theme mode (light or dark)
      var themeMode = Get.find<ThemeController>().themeMode.value;

      return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Profile Setup',
            style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.w600),
          ),
          actions: [
            IconButton(
              icon: Icon(
                themeMode == ThemeMode.dark
                    ? Icons.light_mode
                    : Icons.dark_mode, // Toggle between icons based on theme
              ),
              onPressed: () {
                // Toggle the theme mode on button press
                var newThemeMode =
                    themeMode == ThemeMode.dark
                        ? ThemeMode.light
                        : ThemeMode.dark;
                Get.find<ThemeController>().setThemeMode(newThemeMode);
              },
            ),
          ],
          automaticallyImplyLeading: false,
        ),
        body: ListView(
          padding: EdgeInsets.all(20.w),
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  height:
                      80.h, // Adjusted height to accommodate larger avatar space
                  width: 80.w, // Adjusted width for avatar
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color:
                        themeMode == ThemeMode.dark
                            ? Colors.grey[800]
                            : Color(
                              0xffD9D9D9,
                            ), // Adjust container color based on theme
                  ),
                ),
                Positioned(
                  top: 50.w, // Positioned icon a little lower for better UI
                  left: 175.w, // Adjusted position of the edit icon
                  child: GestureDetector(
                    onTap: () {
                      // Implement your image picker or edit functionality here
                      print('Edit button tapped!');
                    },
                    child: Image.asset(
                      "assets/icons/edit.png",
                      height: 30.w,
                      width: 30.w,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.h),

            TextFormField(
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(8),
                labelText: "Name",
                hintText: "type your name",
              ),
            ),

            SizedBox(height: 8.h),

            // Gender PopupMenuButton
            // Gender PopupMenuButton with Border
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  width: 0,
                  color:
                      themeMode == ThemeMode.dark
                          ? Colors.white
                          : Colors.black, // Border color based on theme
                ),
                borderRadius: BorderRadius.circular(8), // Rounded corners
              ),
              child: PopupMenuButton<String>(
                onSelected: (String value) {
                  // Handle the selection of gender
                  print('Selected Gender: $value');
                },
                itemBuilder: (BuildContext context) {
                  return ['Male', 'Female'].map((String gender) {
                    return PopupMenuItem<String>(
                      value: gender,
                      child: Text(gender),
                    );
                  }).toList();
                },
                child: ListTile(
                  title: Text('Select Gender'),
                  trailing: Icon(Icons.arrow_drop_down),
                ),
              ),
            ),
            SizedBox(height: 10.h),

            ElevatedButton(
              onPressed: () {
                // Implement your save functionality here
                print('Save button tapped!');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    themeMode == ThemeMode.dark
                        ? Colors.blueGrey
                        : Colors.blue, // Button color based on theme
                padding: EdgeInsets.symmetric(
                  vertical: 15.h,
                  horizontal: 100.w,
                ),
              ),
              child: Text(
                'Save',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                  color:
                      themeMode == ThemeMode.dark
                          ? Colors.white
                          : Colors.black, // Button text color based on theme
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
