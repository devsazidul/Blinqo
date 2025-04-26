import 'package:blinqo/core/utils/constants/icon_path.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EpEventServiceDetailsController extends GetxController {
  final TextEditingController search = TextEditingController();

  var allServiceProviders = <Map<String, dynamic>>[
    {
      'name': 'Thaddeus Mercer',
      'rating': 4.5,
      'location': 'New York',
      'price': '\$800',
      'image': IconPath.chatlogo1,
      'verified': true,
    },
    {
      'name': 'Jessica Leigh',
      'rating': 3.7,
      'location': 'Los Angeles',
      'price': '\$550',
      'image': IconPath.chatlogo2,
      'verified': false,
    },
    {
      'name': 'Michael Clark',
      'rating': 5.0,
      'location': 'Chicago',
      'price': '\$500',
      'image': IconPath.chatlogo5,
      'verified': true,
    },
    {
      'name': 'Colen',
      'rating': 4.6,
      'location': 'Los Angeles',
      'price': '\$100',
      'image': IconPath.chatlogo3,
      'verified': false,
    },
    {
      'name': 'Jack Clark',
      'rating': 3.2,
      'location': 'Chicago',
      'price': '\$120',
      'image': IconPath.chatlogo9,
      'verified': true,
    },
    {
      'name': 'Will Smith',
      'rating': 4.2,
      'location': 'Los Angeles',
      'price': '\$300',
      'image': IconPath.chatlogo4,
      'verified': true,
    },
    {
      'name': 'Tom Lee',
      'rating': 4.8,
      'location': 'Chicago',
      'price': '\$400',
      'image': IconPath.chatlogo9,
      'verified': false,
    },
    {
      'name': 'Tracy Rand',
      'rating': 4.5,
      'location': 'Los Angeles',
      'price': '\$200',
      'image': IconPath.chatlogo8,
      'verified': true,
    },
    {
      'name': 'Raiyan Calin',
      'rating': 4.0,
      'location': 'Chicago',
      'price': '\$500',
      'image': IconPath.chatlogo7,
      'verified': false,
    },
  ];
  var serviceProviders = <Map<String, dynamic>>[].obs;
  var searchQuery = ''.obs;

  var locations = ['City 1', 'City 2', 'City 3'].obs;
  var areas = ['Area 1', 'Area 2', 'Area 3'].obs;
  var selectedLocation = ''.obs;
  var selectedArea = ''.obs;
  var rating = 4.5.obs;

  @override
  void onInit() {
    super.onInit();
    serviceProviders.assignAll(allServiceProviders);
    ever(searchQuery, (_) => filterProviders());
  }

  void filterProviders() {
    final query = searchQuery.value.toLowerCase();
    if (query.isEmpty) {
      serviceProviders.assignAll(allServiceProviders);
    } else {
      final filtered =
          allServiceProviders.where((provider) {
            final name = provider['name'].toString().toLowerCase();
            return name.contains(query);
          }).toList();
      serviceProviders.assignAll(filtered);
    }
  }

  void showFilterDialog(BuildContext context) {
    Get.dialog(
      AlertDialog(
        title: Text('Filter Service Providers'),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Location & Area'),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Obx(
                      () => DropdownButton<String>(
                        value:
                            selectedLocation.value.isEmpty
                                ? null
                                : selectedLocation.value,
                        hint: Text('Select Location'),
                        onChanged: (value) {
                          selectedLocation.value = value!;
                        },
                        items:
                            locations.map((location) {
                              return DropdownMenuItem<String>(
                                value: location,
                                child: Text(location),
                              );
                            }).toList(),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),

                  Expanded(
                    child: Obx(
                      () => DropdownButton<String>(
                        value:
                            selectedArea.value.isEmpty
                                ? null
                                : selectedArea.value,
                        hint: Text('Select Area'),
                        onChanged: (value) {
                          selectedArea.value = value!;
                        },
                        items:
                            areas.map((area) {
                              return DropdownMenuItem<String>(
                                value: area,
                                child: Text(area),
                              );
                            }).toList(),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),

              // Ratings & Reviews Slider
              Text('Ratings & Reviews'),
              Obx(
                () => Row(
                  children: [
                    Text('${rating.value.toStringAsFixed(1)}'),
                    Expanded(
                      child: Slider(
                        min: 1.0,
                        max: 5.0,
                        value: rating.value,
                        onChanged: (value) {
                          rating.value = value;
                        },
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),

              // Apply and Cancel Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      Get.back(); // Close the dialog
                    },
                    child: Text('Cancel'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      filterProviders();
                      Get.back(); // Close the dialog after applying filter
                    },
                    child: Text('Apply'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
