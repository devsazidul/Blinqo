import 'package:blinqo/features/role/event_planner/profile_setup/model/event_preference_model.dart';
import 'package:blinqo/features/role/service_provider/common/controller/auth_controller.dart';
import 'package:get/get.dart';

class ProfileSetupController extends GetxController{
  RxString selectedGender = 'Select Gender'.obs;

  // Method to update the gender
  void updateGender(String gender) {
    selectedGender.value = gender;
  }



  /// ------------------------------------------------
  /// Event Preference
  /// ------------------------------------------------
  // RxBool isLoadingEventPreference = false.obs;
  // final RxList<EEventPreferenceModel> eventPreferenceList =
  //     <EEventPreferenceModel>[].obs;

  // Future<bool> getEventPreferences() async {
  //   eventPreferenceList.clear();
  //   bool isSuccess = false;
  //   isLoadingEventPreference.value = true;
  //   update();

  //   await SpAuthController.getUserInformation();
  //   debugPrint('Token after reload: ${SpAuthController.token}');


  //   final SpNetworkResponse response = await Get.find<SpNetworkCaller>()
  //       .getRequest(Urls.getEventPreference);

  //   if (response.isSuccess) {
  //     eventPreferenceList.addAll(
  //       (response.responseData['data'] as List)
  //           .map((e) => EEventPreferenceModel.fromJson(e))
  //           .toList(),
  //     );
  //     update();
  //     isSuccess = true;
  //   } else {
  //     Get.snackbar('Error', response.errorMessage);
  //   }
  //   isLoadingEventPreference.value = false;
  //   update();
  //   return isSuccess;
  // }
}