import 'package:blinqo/core/services/network_caller.dart';
import 'package:blinqo/core/urls/endpoint.dart';
import 'package:blinqo/features/role/event_planner/auth/auth_service/auth_service.dart';
import 'package:blinqo/features/role/event_planner/home/model/service_provider_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/web.dart';

class EpServiceProviderListController extends GetxController {
  // Text editing controllers
  final TextEditingController search = TextEditingController();

  // Private variables
  bool _isLoading = false;
  String _errorMessage = '';
  final List<EpServiceProviderModel> _spProfileModelList = [];
  // ServiceProviderUserWorkModel? _workModel;

  // Getters
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;
  List<EpServiceProviderModel>? get spProfileModelList => _spProfileModelList;
  // ServiceProviderUserWorkModel? get workModel => _workModel;
  var searchQuery = ''.obs;

  // service user model
  // Rx<Rx<ServiceUserModel>> serviceUserModelRx =
  //     Rx<ServiceUserModel>(
  //       ServiceUserModel(success: false, statusCode: 0, message: '', data: []),
  //     ).obs;

  // Rx<Rx<ServiceProviderUserWorkModel>> workModelRx =
  //     Rx<ServiceProviderUserWorkModel>(
  //       ServiceProviderUserWorkModel(
  //         data: [],
  //         message: '',
  //         statusCode: 0,
  //         success: false,
  //       ),
  //     ).obs;

  // var allServiceProviders = <Map<String, dynamic>>[
  //   {
  //     'name': 'Thaddeus Mercer',
  //     'rating': 4.5,
  //     'location': 'New York',
  //     'price': '\$800',
  //     'image': IconPath.chatlogo1,
  //     'verified': true,
  //   },
  //   {
  //     'name': 'Jessica Leigh',
  //     'rating': 3.7,
  //     'location': 'Los Angeles',
  //     'price': '\$550',
  //     'image': IconPath.chatlogo2,
  //     'verified': false,
  //   },
  //   {
  //     'name': 'Michael Clark',
  //     'rating': 5.0,
  //     'location': 'Chicago',
  //     'price': '\$500',
  //     'image': IconPath.chatlogo5,
  //     'verified': true,
  //   },
  //   {
  //     'name': 'Colen',
  //     'rating': 4.6,
  //     'location': 'Los Angeles',
  //     'price': '\$100',
  //     'image': IconPath.chatlogo3,
  //     'verified': false,
  //   },
  //   {
  //     'name': 'Jack Clark',
  //     'rating': 3.2,
  //     'location': 'Chicago',
  //     'price': '\$120',
  //     'image': IconPath.chatlogo9,
  //     'verified': true,
  //   },
  //   {
  //     'name': 'Will Smith',
  //     'rating': 4.2,
  //     'location': 'Los Angeles',
  //     'price': '\$300',
  //     'image': IconPath.chatlogo4,
  //     'verified': true,
  //   },
  //   {
  //     'name': 'Tom Lee',
  //     'rating': 4.8,
  //     'location': 'Chicago',
  //     'price': '\$400',
  //     'image': IconPath.chatlogo9,
  //     'verified': false,
  //   },
  //   {
  //     'name': 'Tracy Rand',
  //     'rating': 4.5,
  //     'location': 'Los Angeles',
  //     'price': '\$200',
  //     'image': IconPath.chatlogo8,
  //     'verified': true,
  //   },
  //   {
  //     'name': 'Raiyan Calin',
  //     'rating': 4.0,
  //     'location': 'Chicago',
  //     'price': '\$500',
  //     'image': IconPath.chatlogo7,
  //     'verified': false,
  //   },
  // ];
  // var serviceProviders = <Map<String, dynamic>>[].obs;

  // var locations = ['City 1', 'City 2', 'City 3'].obs;
  // var areas = ['Area 1', 'Area 2', 'Area 3'].obs;
  // var selectedLocation = ''.obs;
  // var selectedArea = ''.obs;
  // var rating = 4.5.obs;

  // @override
  // void onInit() {
  //   super.onInit();
  //   serviceProviders.assignAll(allServiceProviders);
  //   ever(searchQuery, (_) => filterProviders());
  // }

  // void filterProviders() {
  //   final query = searchQuery.value.toLowerCase();

  //   var filtered =
  //       allServiceProviders.where((provider) {
  //         final name = provider['name'].toString().toLowerCase();
  //         final matchesSearchQuery = name.contains(query);

  //         final matchesLocation =
  //             selectedLocation.value.isEmpty ||
  //             provider['location'].toString().toLowerCase().contains(
  //               selectedLocation.value.toLowerCase(),
  //             );

  //         final matchesArea =
  //             selectedArea.value.isEmpty ||
  //             provider['location'].toString().toLowerCase().contains(
  //               selectedArea.value.toLowerCase(),
  //             );

  //         final matchesRating = provider['rating'] >= rating.value;

  //         return matchesSearchQuery &&
  //             matchesLocation &&
  //             matchesArea &&
  //             matchesRating;
  //       }).toList();

  //   serviceProviders.assignAll(filtered);
  // }

  // final _logger = createLogger();

  Future<bool> getSpProfileListByServiceTypeId({
    required String serviceId,
  }) async {
    _isLoading = true;
    bool isSuccess = false;
    update();

    final accessToken = await AuthService.getToken();

    final response = await Get.find<NetworkCaller>().getRequest(
      '${Urls.getServiceProviderProfile}?id=$serviceId',
      accessToken: accessToken == null ? '' : 'Bearer $accessToken',
    );

    if (response.isSuccess) {
      final List<dynamic>? data = response.responseData["data"];

      if (data != null) {
        _spProfileModelList.clear();
        _spProfileModelList.addAll(
          data
              .map<EpServiceProviderModel>(
                (e) => EpServiceProviderModel.fromJson(e),
              )
              .toList(),
        );
      }
      // _spProfileModel = EpServiceProviderModel.fromJson(response.responseData);
      // serviceUserModelRx.value = Rx<EpServiceProviderModel>(_spProfileModel!);
      // _logger.i(_spProfileModel?.data[0].name);
      isSuccess = true;
    } else {
      _errorMessage = response.errorMessage;
      Logger().e(_errorMessage);
      isSuccess = false;
    }

    _isLoading = false;
    update();
    return isSuccess;
  }

  // Future<bool> getServiceProviderWorks({required String userId}) async {
  //   _isLoading = true;
  //   _errorMessage = '';
  //   update();

  //   bool isSuccess = false;
  //   final accessToken = await AuthService.getToken();

  //   try {
  //     final response = await NetworkCaller1().getRequest(
  //       Urls.getAllWorksByProfileId(userId),
  //       token: 'Bearer $accessToken',
  //     );

  //     if (response.statusCode == 200) {
  //       _workModel = ServiceProviderUserWorkModel.fromJson(
  //         response.responseData,
  //       );
  //       // workModelRx.value = Rx<ServiceProviderUserWorkModel>(_workModel!);
  //       isSuccess = true;
  //     } else {
  //       _errorMessage = 'Failed to fetch works';
  //       isSuccess = false;
  //     }
  //   } catch (e) {
  //     _errorMessage = 'Error: $e';
  //     isSuccess = false;
  //   }

  //   _isLoading = false;
  //   update();
  //   return isSuccess;
  // }
}
