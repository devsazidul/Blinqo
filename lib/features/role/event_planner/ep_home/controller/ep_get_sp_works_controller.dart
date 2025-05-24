import 'package:blinqo/core/services/network_caller.dart';
import 'package:blinqo/core/urls/endpoint.dart';
import 'package:blinqo/features/role/event_planner/auth/auth_service/auth_service.dart';
import 'package:blinqo/features/role/service_provider/sp_profile/model/sp_works_model.dart';
import 'package:get/get.dart';

class EpGetSpWorksController extends GetxController {
  bool _isLoading = false;
  String _errorMessage = '';
  final List<SpWorksModel> _soWorksModelList = [];

  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;
  List<SpWorksModel>? get soWorksModelList => _soWorksModelList;

  Future<bool> getServiceProviderWorks({required String profileId}) async {
    _isLoading = true;
    _errorMessage = '';
    update();

    bool isSuccess = false;
    final accessToken = await AuthService.getToken();

    final response = await Get.find<NetworkCaller>().getRequest(
      Urls.getAllWorksByProfileId(profileId),
      accessToken: accessToken,
    );

    if (response.isSuccess) {
      final List<dynamic>? data = response.responseData["data"];
      if (data != null) {
        _soWorksModelList.clear();
        _soWorksModelList.addAll(
          data.map<SpWorksModel>((e) => SpWorksModel.fromJson(e)).toList(),
        );
      }

      isSuccess = true;
    } else {
      _errorMessage = response.errorMessage;
      isSuccess = false;
    }

    _isLoading = false;
    update();
    return isSuccess;
  }
}
