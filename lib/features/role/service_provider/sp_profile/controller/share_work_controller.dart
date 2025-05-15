import 'package:blinqo/core/urls/endpoint.dart';
import 'package:blinqo/features/role/service_provider/common/controller/auth_controller.dart';
import 'package:blinqo/features/role/service_provider/common/models/sp_user_model.dart';
import 'package:blinqo/features/role/service_provider/services/sp_network_caller.dart';
import 'package:blinqo/features/role/service_provider/sp_profile/controller/work_post_controller.dart';
import 'package:blinqo/features/role/service_provider/sp_profile/model/work_post_model.dart';
import 'package:blinqo/features/role/service_provider/sp_profile/screen/work_post_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class ShareWorkController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  var eventList = ['Wedding', 'Birthday', 'Corporate Event', 'Other'].obs;
  RxList<EventPreference> eventPreferenceList =
      (SpAuthController.spUser?.profile?.eventPreference ?? [])
          .cast<EventPreference>()
          .obs;
  var selectedEvent = ''.obs;

  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  var selectedImages = <XFile>[].obs;

  var projectTitle = ''.obs;
  var projectDescription = ''.obs;

  bool isEditing = false;
  int? postIndex;

  @override
  void onInit() {
    super.onInit();
    titleController.addListener(() {
      projectTitle.value = titleController.text;
    });
    descriptionController.addListener(() {
      projectDescription.value = descriptionController.text;
    });

    // Check for arguments passed during navigation (for editing)
    if (Get.arguments != null) {
      isEditing = Get.arguments['isEditing'] ?? false;
      postIndex = Get.arguments['postIndex'];
      if (isEditing) {
        selectedEvent.value = Get.arguments['eventType'];
        projectTitle.value = Get.arguments['projectTitle'];
        projectDescription.value = Get.arguments['description'];
        selectedImages.addAll(Get.arguments['photos']);
        titleController.text = projectTitle.value;
        descriptionController.text = projectDescription.value;
      }
    }
  }

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

  Future<void> uploadToServer() async {
    if (selectedEvent.value.isEmpty ||
        projectTitle.value.isEmpty ||
        projectDescription.value.isEmpty) {
      Get.snackbar(
        'Error',
        'Please fill in all fields.',
        snackPosition: SnackPosition.TOP,
      );
      return;
    }

    if (selectedImages.isEmpty) {
      Get.snackbar(
        'Error',
        'Please select at least one image.',
        snackPosition: SnackPosition.TOP,
      );

      return;
    }

    // Create or update the post
    var post = WorkPost(
      eventType: selectedEvent.value,
      projectTitle: projectTitle.value,
      description: projectDescription.value,
      photos: selectedImages.toList(),
    );

    // final WorkPostController workPostController = Get.find();
    final WorkPostController workPostController = Get.put(WorkPostController());
    if (isEditing && postIndex != null) {
      workPostController.updatePost(postIndex!, post);
    } else {
      workPostController.addWorkPost(post);
    }

    // Navigate to the WorkPostScreen to display the posts
    Get.to(() => WorkPostScreen());

    // Clear the form
    selectedImages.clear();
    titleController.clear();
    descriptionController.clear();
    selectedEvent.value = eventList[0];
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
      Get.off(() => WorkPostScreen());
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
