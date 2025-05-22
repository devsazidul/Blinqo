import 'package:blinqo/core/services/network_caller.dart';
import 'package:blinqo/core/urls/endpoint.dart';
import 'package:blinqo/features/role/service_provider/sp_profile/model/sp_works_model.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class SpWorkDetailsController extends GetxController {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String _errorMessage = '';
  String get errorMessage => _errorMessage;

  SpWorksModel? _workDetails;
  SpWorksModel get workDetails => _workDetails ?? SpWorksModel();

  Future<bool> getWorkDetails(String workId) async {
    EasyLoading.show(status: 'Loading...');
    _isLoading = true;
    bool isSuccess = false;
    update();

    final response = await Get.find<NetworkCaller>().getRequest(
      Urls.getWorkDetailsByWorkId(workId),
    );

    if (response.statusCode == 200) {
      _workDetails = SpWorksModel.fromJson(response.responseData['data']);
      isSuccess = true;
      EasyLoading.showSuccess('Work details fetched successfully');
    } else {
      _errorMessage = 'Failed to fetch work details';
      EasyLoading.showError(_errorMessage);
    }

    EasyLoading.dismiss();
    _isLoading = false;
    update();
    return isSuccess;
  }
  // var workPosts =
  //     <WorkPost>[
  //       WorkPost(
  //         eventType: 'Wedding Photography',
  //         projectTitle: 'Wedding Photography',
  //         description: 'Wedding Photography Description',
  //         photos: [],
  //         likes: 0,
  //         isLiked: false,
  //       ),
  //     ].obs;
  // List<String> imageUrls =
  //     [
  //       'assets/images/wedding_photography_1.jpeg',
  //       'assets/images/wedding_photography_2.jpeg',
  //       'assets/images/wedding_photography_3.jpeg',
  //       'assets/images/wedding_photography_1.jpeg',
  //       'assets/images/wedding_photography_2.jpeg',
  //       'assets/images/wedding_photography_3.jpeg',
  //       'assets/images/wedding_photography_1.jpeg',
  //       'assets/images/wedding_photography_2.jpeg',
  //       'assets/images/wedding_photography_3.jpeg',
  //       'assets/images/wedding_photography_1.jpeg',
  //     ].obs;

  // void addWorkPost(WorkPost post) {
  //   workPosts.add(post);
  // }

  // void toggleLike(int index) {
  //   var post = workPosts[index];
  //   if (post.isLiked) {
  //     post.likes--;
  //     post.isLiked = false;
  //   } else {
  //     post.likes++;
  //     post.isLiked = true;
  //   }
  //   workPosts[index] = post; // Update the post to trigger UI refresh
  //   workPosts.refresh();
  // }

  // void deletePost(int index) {
  //   workPosts.removeAt(index);
  // }

  // void editPost(int index) {
  //   var post = workPosts[index];
  //   // Navigate to ShareWork page with pre-filled data
  //   Get.to(
  //     () => SpShareWorkScreen(
  //       isEditing: true,
  //       postIndex: index,
  //       eventType: post.eventType,
  //       projectTitle: post.projectTitle,
  //       description: post.description,
  //       photos: post.photos,
  //     ),
  //   );
  // }

  // void updatePost(int index, WorkPost updatedPost) {
  //   workPosts[index] = updatedPost;
  //   workPosts.refresh();
  // }
}
