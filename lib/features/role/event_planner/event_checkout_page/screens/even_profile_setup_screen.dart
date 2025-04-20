import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/utils/constants/icon_path.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controllers/even_profile_controller.dart';
import 'profile_setup_widget/avater_profile_setup_screen.dart';
import 'profile_setup_widget/even_planner_gender.dart';
import 'profile_setup_widget/profile_setup_google_map.dart';

class EvenProfileSetupScreen extends StatelessWidget {
  EvenProfileSetupScreen({super.key});
  final EvenProfileController controller = Get.put(EvenProfileController());
  final MyController myController = Get.put(MyController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                // Your existing profile sections
                AvaterProfileSetupScreen(),
                const SizedBox(height: 20),
                EvenPlannerGender(),
                const SizedBox(height: 20),
                ProfileSetupGoogleMap(),
                const SizedBox(height: 20),

                // Event Preferences Grid
                _buildPreferencesGrid(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPreferencesGrid() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Event Preference',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: myController.eventPreferences.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 0.85,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
          ),
          itemBuilder: (context, index) {
            return _buildPreferenceItem(index);
          },
        ),
      ],
    );
  }

  Widget _buildPreferenceItem(int index) {
    return GestureDetector(
      onTap: () => myController.toggleSelection(index),
      child: Obx(() {
        final isSelected = myController.selectedItems[index];
        return Stack(
          children: [
            Column(
              children: [
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                        myController.eventPreferences[index]['image']!,
                      ),
                    ),
                    shape: BoxShape.circle,
                    color: Colors.grey.shade50, // Fixed: Non-nullable
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  myController.eventPreferences[index]['name']!,
                  style: getTextStyle(
                    fontSize: 12,
                    fontWeight:
                        isSelected ? FontWeight.bold : FontWeight.normal,
                    color: isSelected ? Colors.blue : Colors.black,
                  ),
                ),
              ],
            ),

            // Check if 'verifyProfile' is "true" (string comparison)
            myController.eventPreferences[index]['verifyProfile'] == "true"
                ? Positioned(
                  left: 65,
                  child: CircleAvatar(
                    radius: 15,
                    backgroundImage: AssetImage(IconPath.selected),
                  ),
                )
                : SizedBox(),
          ],
        );
      }),
    );
  }
}

class MyController extends GetxController {
  // Reactive list for selected states (initialized directly with false values)
  final RxList<bool> selectedItems = RxList<bool>.filled(9, false);

  // List of all event preferences with image paths
  final List<Map<String, String>> eventPreferences = [
    {
      'name': 'Corporate Events',
      'image': 'assets/icons/corporateEvents.png',
      'verifyProfile': "false", // Fixed typo here
    },
    {
      'name': 'Weddings',
      'image': 'assets/icons/wedding.png',
      'verifyProfile': "true", // Fixed typo here
    },
    {
      'name': 'Music Festivals',
      'image': 'assets/icons/musidFastivals.png',
      'verifyProfile': "false", // Fixed typo here
    },
    {
      'name': 'Exhibitions',
      'image': 'assets/icons/exhibition.png',
      'verifyProfile': "true", // Fixed typo here
    },
    {
      'name': 'Concerts',
      'image': 'assets/icons/concert.png',
      'verifyProfile': "false", // Fixed typo here
    },
    {
      'name': 'Charity Events',
      'image': 'assets/icons/charityEvent.png',
      'verifyProfile': "false", // Fixed typo here
    },
    {
      'name': 'Private Parties',
      'image': 'assets/icons/privateParties.png',
      'verifyProfile': "true", // Fixed typo here
    },
    {
      'name': 'Product Launches',
      'image': 'assets/icons/productLaunches.png',
      'verifyProfile': "false", // Fixed typo here
    },
    {
      'name': 'Trade Shows',
      'image': 'assets/icons/tradeShow.png',
      'verifyProfile': "true", // Fixed typo here
    },
  ];

  @override
  void onInit() {
    super.onInit();
    // No need for assignAll if RxList is initialized with the desired size and values
  }

  // Toggle selection state
  void toggleSelection(int index) {
    selectedItems[index] = !selectedItems[index];
  }

  // Get selected items count
  int get selectedCount => selectedItems.where((item) => item).length;

  // Get list of selected preference names
  List<String> get selectedPreferences {
    return [
      for (int i = 0; i < eventPreferences.length; i++)
        if (selectedItems[i]) eventPreferences[i]['name']!,
    ];
  }
}
