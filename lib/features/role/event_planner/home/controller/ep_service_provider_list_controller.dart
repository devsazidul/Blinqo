import 'package:blinqo/core/common/widgets/logger_view.dart';
import 'package:blinqo/core/services/network_caller_1.dart';
import 'package:blinqo/core/urls/endpoint.dart';
import 'package:blinqo/core/utils/constants/icon_path.dart';
import 'package:blinqo/features/role/event_planner/auth/auth_service/auth_service.dart';
import 'package:blinqo/features/role/event_planner/event_home_page/models/service_provider_work_model.dart';
import 'package:blinqo/features/role/event_planner/event_home_page/models/service_user_data_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EpServiceProviderListController extends GetxController {
  final TextEditingController search = TextEditingController();

  // service user model
  Rx<Rx<ServiceUserModel>> serviceUserModel =
      Rx<ServiceUserModel>(
        ServiceUserModel(success: false, statusCode: 0, message: '', data: []),
      ).obs;

  Rx<Rx<ServiceProviderUserWorkModel>> workModel =
      Rx<ServiceProviderUserWorkModel>(
        ServiceProviderUserWorkModel(
          data: [],
          message: '',
          statusCode: 0,
          success: false,
        ),
      ).obs;

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

  var isLoading = false.obs;

  void filterProviders() {
    final query = searchQuery.value.toLowerCase();

    var filtered =
        allServiceProviders.where((provider) {
          final name = provider['name'].toString().toLowerCase();
          final matchesSearchQuery = name.contains(query);

          final matchesLocation =
              selectedLocation.value.isEmpty ||
              provider['location'].toString().toLowerCase().contains(
                selectedLocation.value.toLowerCase(),
              );

          final matchesArea =
              selectedArea.value.isEmpty ||
              provider['location'].toString().toLowerCase().contains(
                selectedArea.value.toLowerCase(),
              );

          final matchesRating = provider['rating'] >= rating.value;

          return matchesSearchQuery &&
              matchesLocation &&
              matchesArea &&
              matchesRating;
        }).toList();

    serviceProviders.assignAll(filtered);
  }

  final _logger = createLogger();

  Future<void> fetchData({required String serviceId}) async {
    isLoading.value = true;
    final accessToken = await AuthService.getToken();

    final response = await NetworkCaller1().getRequest(
      '${Urls.getServiceProviderProfile}?id=$serviceId',
      token: 'Bearer $accessToken',
    );

    if (response.statusCode == 200) {
      serviceUserModel.value = Rx<ServiceUserModel>(
        ServiceUserModel.fromJson(response.responseData),
      );
      _logger.i(serviceUserModel.value.value.data[0].name);
    }
    isLoading.value = false;
  }

  Future<void> getServiceProviderWorks({required String userId}) async {
    isLoading.value = true;
    final accessToken = await AuthService.getToken();

    final response = await NetworkCaller1().getRequest(
      Urls.getWorkAllDetails(userId),
      token: 'Bearer $accessToken',
    );

    if (response.statusCode == 200) {
      workModel.value = Rx<ServiceProviderUserWorkModel>(
        ServiceProviderUserWorkModel.fromJson(response.responseData),
      );
    }

    isLoading.value = false;
  }
}
