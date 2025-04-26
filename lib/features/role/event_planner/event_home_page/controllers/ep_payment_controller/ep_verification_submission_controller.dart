import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class EpVerificationSubmissionController extends GetxController {
  TextEditingController spnameController = TextEditingController();
  TextEditingController spProfileLinkController = TextEditingController();
  TextEditingController spShortBioController = TextEditingController();
  var nidimageupload = <File>[].obs;
  final roles = ["Photographer", "Videographer", "DJ Brand", "Catering"];
  var selectedRole = 'Photographer'.obs;

  void setRole(String role) {
    selectedRole.value = role;
  }

  // nidimageupload.add(File(imagePath));
  Future<void> addNidImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      File imageFile = File(pickedFile.path);
      int imageSize = await imageFile.length();
      if (imageSize <= 1024 * 1024) {
        nidimageupload.add(imageFile);
      } else {
        Get.snackbar("Error", "Image size should be less than 1MB");
      }
    }
  }
}
