import 'package:blinqo/core/common/styles/global_text_style.dart';
import 'package:blinqo/core/utils/constants/colors.dart';
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
  var selectedCity = ''.obs;
  var selectedArea = ''.obs;
  var selectedRating = 0.0.obs;
  List<String> get cities =>
      allServiceProviders
          .map((provider) => provider['location'] as String)
          .toSet()
          .toList();

  List<String> get areas =>
      allServiceProviders
          .map((provider) => provider['area'] as String)
          .toSet()
          .toList();

  @override
  void onInit() {
    super.onInit();
    serviceProviders.assignAll(allServiceProviders);
    ever(searchQuery, (_) => filterServices());
    ever(selectedCity, (_) => filterServices());
    ever(selectedArea, (_) => filterServices());
    ever(selectedRating, (_) => filterServices());
  }

  void filterServices() {
    final query = searchQuery.value.toLowerCase();
    final city = selectedCity.value.toLowerCase();
    final area = selectedArea.value.toLowerCase();
    final rating = selectedRating.value;

    serviceProviders.assignAll(
      allServiceProviders.where((service) {
        final name = (service['name'] ?? '').toString().toLowerCase();
        final providerLocation = (service['location'] as String).toLowerCase();
        final providerArea = (service['area'] as String).toLowerCase();
        final providerRating = (service['rating'] as double);

        // Filter by name (search query), city, area, and rating
        final matchesQuery = query.isEmpty || name.contains(query);
        final matchesCity = city.isEmpty || providerLocation == city;
        final matchesArea = area.isEmpty || providerArea == area;
        final matchesRating = rating == 0.0 || providerRating >= rating;

        return matchesQuery && matchesCity && matchesArea && matchesRating;
      }).toList(),
    );
  }

  void resetFilters() {
    selectedCity.value = '';
    selectedArea.value = '';
    selectedRating.value = 0.0;
    filterServices();
  }

  Widget serviceItem(int index) {
    var service = serviceProviders[index];
    return ListTile(
      leading: Image.asset(service['image'] as String),
      title: Row(
        children: [
          Text(service['name'] as String),
          if (service['verified'] == true)
            Icon(Icons.check_circle, color: Colors.green, size: 16),
        ],
      ),
      subtitle: Text('${service['location']} - ${service['price']}'),
    );
  }

  @override
  void onClose() {
    search.dispose();
    super.onClose();
  }

  void showFilterDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppColors.backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Image.asset(
                    IconPath.eplocation,
                    width: 24,
                    height: 24,
                    fit: BoxFit.contain,
                  ),
                  SizedBox(width: 8),
                  Text(
                    'Location',
                    style: getTextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textColor,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12),
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 4),
                      SizedBox(
                        width: 154,
                        height: 38,
                        child: Obx(
                          () => Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: DropdownButtonFormField<String?>(
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 0,
                                ),
                              ),
                              value:
                                  selectedCity.value.isEmpty
                                      ? null
                                      : selectedCity.value,
                              items: [
                                DropdownMenuItem<String?>(
                                  value: null,
                                  child: Text(
                                    'Select City',
                                    style: getTextStyle(
                                      fontSize: 14,
                                      color: AppColors.subTextColor2,
                                    ),
                                  ),
                                ),
                                ...cities.map(
                                  (city) => DropdownMenuItem<String?>(
                                    value: city,
                                    child: Text(
                                      city,
                                      style: getTextStyle(
                                        fontSize: 14,
                                        color: AppColors.textColor,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                              onChanged: (value) {
                                selectedCity.value = value ?? '';
                              },
                              icon: Image.asset(
                                IconPath.arrowdown,
                                width: 16,
                                height: 16,
                                color: AppColors.textColor,
                              ),
                              isExpanded: true,
                              dropdownColor: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(width: 12),
                ],
              ),
              SizedBox(height: 20),

              Row(
                children: [
                  Image.asset(
                    IconPath.eprating,
                    width: 18,
                    height: 18,
                    fit: BoxFit.cover,
                  ),
                  SizedBox(width: 8),
                  Text(
                    'Ratings & Review',
                    style: getTextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textColor,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Obx(
                () => Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          width: 1,
                          color: AppColors.subTextColor2,
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            selectedRating.value.toStringAsFixed(1),
                            style: getTextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: AppColors.buttonColor2,
                            ),
                          ),
                          SizedBox(width: 6.5),
                          Image.asset(
                            IconPath.ratingstart2,
                            width: 10,
                            height: 10,
                            fit: BoxFit.cover,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: Slider(
                        value: selectedRating.value,
                        min: 0.0,
                        max: 5.0,

                        activeColor: AppColors.buttonColor2,
                        inactiveColor: AppColors.subTextColor2,
                        onChanged: (value) {
                          selectedRating.value = value;
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          actions: [
            GestureDetector(
              onTap: () {
                resetFilters();
                Navigator.of(context).pop();
              },
              child: Container(
                width: 105,
                height: 48,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(width: 1, color: AppColors.subTextColor),
                ),
                child: Center(
                  child: Text(
                    "Cancel",
                    style: getTextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: AppColors.textColor,
                    ),
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Container(
                width: 105,
                height: 48,
                decoration: BoxDecoration(
                  color: AppColors.buttonColor2,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Text(
                    "Apply",
                    style: getTextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: AppColors.primary,
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
