import 'package:get/get.dart';


class GetServiceProviderListController extends GetxController {
  bool _isLoading = false;
  String _errorMessage = '';

  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;
}
