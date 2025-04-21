import 'package:get/get.dart';

mixin ProfileSetupEventPreference {
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
