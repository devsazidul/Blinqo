import 'package:blinqo/core/urls/endpoint.dart';
import 'package:blinqo/features/role/service_provider/services/sp_network_caller.dart';
import 'package:blinqo/features/role/service_provider/sp_profile/model/sp_works_model.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class SpGetAllWorksController extends GetxController {
  bool _isLoading = false;
  String _errorMessage = '';
  final List<SpWorksModel> _works = [];

  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;
  List<SpWorksModel> get works => _works;

  // @override
  // void onInit() async {
  //   await getAllWorks();
  //   super.onInit();
  // }

  Future<bool> getAllWorks() async {
    _works.clear();
    // EasyLoading.show(status: 'Loading...');
    bool isSuccess = false;
    _isLoading = true;
    update();

    try {
      final response = await Get.find<SpNetworkCaller>().getRequest(
        Urls.getAllWorks,
      );

      if (response.isSuccess) {
        for (var work in response.responseData['data']) {
          _works.add(SpWorksModel.fromJson(work as Map<String, dynamic>));
        }
        // response.responseData['data']
        //     .map((e) => SpWorksModel.fromJson(e as Map<String, dynamic>))
        //     .toList();

        // EasyLoading.showSuccess("Works retrieved successfully");
        isSuccess = true;
      } else {
        _errorMessage = response.errorMessage;
        EasyLoading.showError(_errorMessage);
      }
    } catch (e) {
      _errorMessage = "Failed to load works: $e";
      // EasyLoading.showError(_errorMessage);
    }

    _isLoading = false;
    update();
    // EasyLoading.dismiss();
    return isSuccess;
  }
}
