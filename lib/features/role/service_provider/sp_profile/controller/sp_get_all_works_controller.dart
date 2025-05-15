import 'package:blinqo/core/urls/endpoint.dart';
import 'package:blinqo/features/role/service_provider/services/sp_network_caller.dart';
import 'package:blinqo/features/role/service_provider/sp_profile/model/sp_works_model.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class SpGetAllWorksController extends GetxController {
  bool _isLoading = false;
  String _errorMessage = '';
  List<SpWorksModel> _works = [];

  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;
  List<SpWorksModel> get works => _works;

  @override
  void onInit() async {
    await getAllWorks();
    super.onInit();
  }

  Future<bool> getAllWorks() async {
    EasyLoading.show(status: 'Loading...');
    bool isSuccess = false;
    _isLoading = true;
    update();

    final response = await Get.find<SpNetworkCaller>().getRequest(
      Urls.getAllWorks,
    );

    if (response.isSuccess) {
      final List<SpWorksModel> spWorksModel =
          response.responseData['data']
              .map((e) => SpWorksModel.fromJson(e))
              .toList();
      _works = spWorksModel;
      EasyLoading.showSuccess("Works retrieved successfully");
      isSuccess = true;
    } else {
      _errorMessage = "Works retrieval failed";
      EasyLoading.showError(_errorMessage);
    }

    _isLoading = false;
    update();
    EasyLoading.dismiss();
    return isSuccess;
  }
}
