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
  @override
  void onInit() {
    super.onInit();
    serviceProviders.assignAll(allServiceProviders);

    ever(searchQuery, (_) => _filterProviders());
  }

  void _filterProviders() {
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
}
