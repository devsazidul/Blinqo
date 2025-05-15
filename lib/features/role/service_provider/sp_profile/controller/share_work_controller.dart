import 'package:blinqo/core/urls/endpoint.dart';
import 'package:blinqo/features/role/service_provider/common/controller/auth_controller.dart';
import 'package:blinqo/features/role/service_provider/common/models/sp_user_model.dart';
import 'package:blinqo/features/role/service_provider/services/sp_network_caller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class ShareWorkController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  RxList<EventPreference> eventPreferenceList =
      (SpAuthController.spUser?.profile?.eventPreference ?? [])
          .cast<EventPreference>()
          .obs;
  var selectedEvent = ''.obs;

  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  RxString imageEmptyError = ''.obs;
  var selectedImages = <XFile>[].obs;

  void checkImageEmptyError() {
    if (selectedImages.isEmpty) {
      imageEmptyError.value = 'Please upload at least one image';
    } else {
      imageEmptyError.value = '';
    }
  }

  bool isEditing = false;
  int? postIndex;

  Future<void> pickImages() async {
    final picker = ImagePicker();
    final List<XFile> pickedFiles = await picker.pickMultiImage();

    if (pickedFiles.isNotEmpty) {
      int remainingSlots = 20 - selectedImages.length;
      int imagesToAdd =
          pickedFiles.length > remainingSlots
              ? remainingSlots
              : pickedFiles.length;
      selectedImages.addAll(pickedFiles.take(imagesToAdd));
      if (selectedImages.isNotEmpty) {
        checkImageEmptyError();
      }

      if (pickedFiles.length > remainingSlots) {
        Get.snackbar(
          'Limit Reached',
          'You can only upload up to 20 photos.',
          snackPosition: SnackPosition.TOP,
        );
      }
    }
  }

  void removeImage(int index) {
    selectedImages.removeAt(index);
  }

  //* ------------------  Upload Work Post  ------------------
  Future<bool> uploadWorkPost() async {
    bool isSuccess = false;
    EasyLoading.show(status: 'Uploading...');

    Map<String, String> formFields = {
      'eventTypeId': selectedEvent.value,
      'projectTitle': titleController.text,
      'description': descriptionController.text,
    };

    List<http.MultipartFile>? files;
    if (selectedImages.isNotEmpty) {
      files = [];
      for (var image in selectedImages) {
        files.add(await http.MultipartFile.fromPath('files', image.path));
      }
    }

    final response = await Get.find<SpNetworkCaller>().multipartRequest(
      url: Urls.workShowcase,
      formFields: formFields,
      files: files,
    );

    if (response.isSuccess) {
      EasyLoading.dismiss();
      isSuccess = true;
      // Get.off(() => SpWorkDetailsScreen());
    } else {
      EasyLoading.dismiss();
      isSuccess = false;
      Get.snackbar(
        'Error',
        'Failed to upload work post.',
        snackPosition: SnackPosition.TOP,
      );
    }

    update();
    return isSuccess;
  }

  @override
  void onClose() {
    titleController.dispose();
    descriptionController.dispose();
    super.onClose();
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }
}
