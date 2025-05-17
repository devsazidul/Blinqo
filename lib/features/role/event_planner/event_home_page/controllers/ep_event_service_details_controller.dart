import 'package:blinqo/core/common/widgets/logger_view.dart';
import 'package:blinqo/core/utils/constants/icon_path.dart';
import 'package:blinqo/features/role/event_planner/event_home_page/models/service_provider_work_model.dart';
import 'package:blinqo/features/role/event_planner/event_home_page/models/service_user_data_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../core/services/network_caller.dart';
import '../../../../../core/urls/endpoint.dart';
import '../../auth/auth_service/auth_service.dart';

class EpEventServiceDetailsController extends GetxController {
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

    final response = await NetworkCaller().getRequest(
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

    final response = await NetworkCaller().getRequest(
      Urls.getWorkAllDetails(userId),
      token: 'Bearer $accessToken',
    );

    if (response.statusCode == 200) {
     workModel.value = Rx<ServiceProviderUserWorkModel>(ServiceProviderUserWorkModel.fromJson(response.responseData));
    }

    isLoading.value = false;
  }

  // void showFilterDialog(BuildContext context) {
  //   Get.dialog(
  //     AlertDialog(
  //       backgroundColor: AppColors.backgroundColor,
  //       content: SingleChildScrollView(
  //         child: Column(
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           mainAxisSize: MainAxisSize.min,
  //           children: [
  //             Row(
  //               children: [
  //                 Image.asset(IconPath.eplocation, width: 18, height: 20),
  //                 SizedBox(width: 10),
  //                 Text(
  //                   'Location',
  //                   style: getTextStyle(
  //                     fontSize: 16,
  //                     fontWeight: FontWeight.w500,
  //                     color: AppColors.textColor,
  //                   ),
  //                 ),
  //               ],
  //             ),
  //             SizedBox(height: 10),
  //             Row(
  //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //               children: [
  //                 Flexible(
  //                   child: Obx(
  //                     () => Container(
  //                       padding: EdgeInsets.all(10),
  //                       width: 155,
  //                       height: 40,
  //                       decoration: BoxDecoration(
  //                         color: Colors.white,
  //                         borderRadius: BorderRadius.circular(8),
  //                         boxShadow: [
  //                           BoxShadow(blurRadius: 3, color: Colors.black12),
  //                         ],
  //                       ),
  //                       child: DropdownButton<String>(
  //                         value:
  //                             selectedLocation.value.isEmpty
  //                                 ? null
  //                                 : selectedLocation.value,
  //                         hint: Text(
  //                           'City',
  //                           style: getTextStyle(
  //                             fontSize: 16,
  //                             fontWeight: FontWeight.w500,
  //                             color: AppColors.subTextColor,
  //                           ),
  //                           overflow: TextOverflow.ellipsis,
  //                           textAlign: TextAlign.center,
  //                         ),
  //                         onChanged: (value) {
  //                           selectedLocation.value = value!;
  //                         },
  //                         items:
  //                             locations.map((location) {
  //                               return DropdownMenuItem<String>(
  //                                 value: location,
  //                                 child: Text(
  //                                   location,
  //                                   textAlign: TextAlign.center,
  //                                 ),
  //                               );
  //                             }).toList(),
  //                         isExpanded: true,
  //                         icon: Image.asset(
  //                           IconPath.backButton,
  //                           width: 16,
  //                           height: 16,
  //                         ),
  //                       ),
  //                     ),
  //                   ),
  //                 ),
  //                 SizedBox(width: 8),
  //                 Flexible(
  //                   child: Obx(
  //                     () => Container(
  //                       padding: EdgeInsets.all(10),
  //                       width: 155,
  //                       height: 40,
  //                       decoration: BoxDecoration(
  //                         color: Colors.white,
  //                         borderRadius: BorderRadius.circular(8),
  //                         boxShadow: [
  //                           BoxShadow(blurRadius: 3, color: Colors.black12),
  //                         ],
  //                       ),
  //                       child: DropdownButton<String>(
  //                         value:
  //                             selectedArea.value.isEmpty
  //                                 ? null
  //                                 : selectedArea.value,
  //                         hint: Text(
  //                           'Area',
  //                           style: getTextStyle(
  //                             fontSize: 16,
  //                             fontWeight: FontWeight.w500,
  //                             color: AppColors.subTextColor,
  //                           ),
  //                           overflow: TextOverflow.ellipsis,
  //                           textAlign: TextAlign.center,
  //                         ),
  //                         onChanged: (value) {
  //                           selectedArea.value = value!;
  //                         },
  //                         items:
  //                             areas.map((area) {
  //                               return DropdownMenuItem<String>(
  //                                 value: area,
  //                                 child: Text(
  //                                   area,
  //                                   textAlign: TextAlign.center,
  //                                 ),
  //                               );
  //                             }).toList(),
  //                         isExpanded: true,
  //                         icon: Image.asset(
  //                           IconPath.backButton,
  //                           width: 16,
  //                           height: 16,
  //                         ),
  //                       ),
  //                     ),
  //                   ),
  //                 ),
  //               ],
  //             ),
  //             SizedBox(height: 20),
  //
  //             Row(
  //               children: [
  //                 Image.asset(IconPath.eprating, width: 18, height: 20),
  //                 SizedBox(width: 10),
  //                 Text(
  //                   'Ratings & Reviews',
  //                   style: getTextStyle(
  //                     fontSize: 16,
  //                     fontWeight: FontWeight.w500,
  //                     color: AppColors.textColor,
  //                   ),
  //                 ),
  //               ],
  //             ),
  //             Obx(
  //               () => Row(
  //                 children: [
  //                   Container(
  //                     padding: EdgeInsets.all(5),
  //                     width: 60,
  //                     height: 28,
  //                     decoration: BoxDecoration(
  //                       borderRadius: BorderRadius.circular(8),
  //                       color: AppColors.primary,
  //                     ),
  //                     child: Row(
  //                       children: [
  //                         Image.asset(
  //                           IconPath.ratingstart2,
  //                           width: 14,
  //                           height: 14,
  //                         ),
  //                         SizedBox(width: 10),
  //                         Center(
  //                           child: Text(
  //                             rating.value.toStringAsFixed(1),
  //                             style: getTextStyle(
  //                               fontSize: 12,
  //                               fontWeight: FontWeight.w300,
  //                               color: AppColors.textColor,
  //                             ),
  //                           ),
  //                         ),
  //                       ],
  //                     ),
  //                   ),
  //                   Expanded(
  //                     child: SliderTheme(
  //                       data: SliderThemeData(
  //                         activeTrackColor: AppColors.buttonColor2,
  //                         inactiveTrackColor: Color(0xffE0E0E0),
  //                         thumbColor: AppColors.buttonColor2,
  //                         overlayColor: Colors.blue.withValues(alpha: 0.2),
  //                         trackHeight: 4.0,
  //                         thumbShape: RoundSliderThumbShape(
  //                           enabledThumbRadius: 10,
  //                         ),
  //                       ),
  //                       child: Slider(
  //                         min: 1.0,
  //                         max: 5.0,
  //                         value: rating.value,
  //                         onChanged: (value) {
  //                           rating.value = value;
  //                         },
  //                       ),
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //             ),
  //             SizedBox(height: 20),
  //             Row(
  //               mainAxisAlignment: MainAxisAlignment.center,
  //               children: [
  //                 GestureDetector(
  //                   onTap: () {
  //                     Get.back();
  //                   },
  //                   child: Container(
  //                     height: 48,
  //                     width: 105,
  //                     decoration: BoxDecoration(
  //                       border: Border.all(
  //                         width: 1,
  //                         color: AppColors.buttonColor2,
  //                       ),
  //                       borderRadius: BorderRadius.circular(8),
  //                       color: Colors.transparent,
  //                     ),
  //                     child: Center(
  //                       child: Text(
  //                         "Cancel",
  //                         style: getTextStyle(
  //                           fontSize: 16,
  //                           fontWeight: FontWeight.w500,
  //                           color: AppColors.textColor,
  //                         ),
  //                       ),
  //                     ),
  //                   ),
  //                 ),
  //                 SizedBox(width: 8),
  //                 GestureDetector(
  //                   onTap: () {
  //                     String selectedFilters =
  //                         "Location: ${selectedLocation.value}, Area: ${selectedArea.value}, Rating: ${rating.value.toStringAsFixed(1)}";
  //                     searchQuery.value = selectedFilters;
  //                     filterProviders(); // Apply filters
  //                     Get.back();
  //                   },
  //                   child: Container(
  //                     height: 48,
  //                     width: 105,
  //                     decoration: BoxDecoration(
  //                       border: Border.all(width: 1),
  //                       borderRadius: BorderRadius.circular(8),
  //                       color: AppColors.buttonColor2,
  //                     ),
  //                     child: Center(
  //                       child: Text(
  //                         "Apply",
  //                         style: getTextStyle(
  //                           fontSize: 16,
  //                           fontWeight: FontWeight.w500,
  //                           color: AppColors.primary,
  //                         ),
  //                       ),
  //                     ),
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }
}
