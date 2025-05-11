import 'dart:io';

import 'package:blinqo/core/urls/endpoint.dart';
import 'package:blinqo/features/role/service_provider/common/controller/auth_controller.dart';
import 'package:blinqo/features/role/service_provider/services/sp_network_caller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class SpVerificationSubmissionController extends GetxController {
  TextEditingController spNameController = TextEditingController();
  TextEditingController spShortBioController = TextEditingController();

  Rx<File?> nidImage = Rx<File?>(null);
  Rx<File?> tradeLicenseImage = Rx<File?>(null);

  Future<File?> pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      File imageFile = File(pickedFile.path);
      int imageSize = await imageFile.length();
      if (imageSize <= 1024 * 1024) {
        return imageFile;
      } else {
        Get.snackbar("Error", "Image size should be less than 1MB");
      }
    }
    return null;
  }

  Future<void> addImage(bool isNid) async {
    File? image = await pickImage();
    if (image != null) {
      if (isNid) {
        nidImage.value = image;
      } else {
        tradeLicenseImage.value = image;
      }
    }
    update();
  }

  Future<bool> getVerified() async {
    EasyLoading.showProgress(0.5, status: 'Loading...');
    bool isSuccess = false;

    final response = await Get.find<SpNetworkCaller>().multipartRequest(
      url: Urls.sendVerificationRequest,
      formFields: {
        'profileId': SpAuthController.profileInfoModel?.id ?? '',
        'bio': spShortBioController.text,
      },
      files: [
        if (nidImage.value != null)
          await http.MultipartFile.fromPath('idCard', nidImage.value!.path),
        if (tradeLicenseImage.value != null)
          await http.MultipartFile.fromPath(
            'tradeLicense',
            tradeLicenseImage.value!.path,
          ),
      ],
    );
    if (response.isSuccess) {
      EasyLoading.dismiss();
      EasyLoading.showSuccess('Verification request sent successfully');
      isSuccess = true;
    } else {
      EasyLoading.dismiss();
      EasyLoading.showError(response.errorMessage);
    }
    return isSuccess;
  }
}
