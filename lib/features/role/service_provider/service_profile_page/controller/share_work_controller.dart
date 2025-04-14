import 'package:blinqo/features/role/service_provider/service_profile_page/controller/work_post_controller.dart';
import 'package:blinqo/features/role/service_provider/service_profile_page/model/work_post_model.dart';
import 'package:blinqo/features/role/service_provider/service_profile_page/screen/work_post_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ShareWorkController extends GetxController {
  var eventList = ['Wedding', 'Birthday', 'Corporate Event', 'Other'].obs;
  var selectedEvent = 'Wedding'.obs;
  var projectTitle = ''.obs;
  var projectDescription = ''.obs;
  var selectedImages = <XFile>[].obs;

  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
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

    // var uri = Uri.parse('https://your-api-endpoint.com/upload');
    // var request = http.MultipartRequest('POST', uri);

    // request.fields['event_type'] = selectedEvent.value;
    // request.fields['project_title'] = projectTitle.value;
    // request.fields['project_description'] = projectDescription.value;

    // for (int i = 0; i < selectedImages.length; i++) {
    //   var file = await http.MultipartFile.fromPath(
    //     'photos[$i]',
    //     selectedImages[i].path,
    //     contentType: http.MediaType('image', selectedImages[i].path.endsWith('.png') ? 'png' : 'jpeg'),
    //   );
    //   request.files.add(file);
    // }

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

  @override
  void onClose() {
    titleController.dispose();
    descriptionController.dispose();
    super.onClose();
  }
}
