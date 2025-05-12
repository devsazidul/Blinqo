import 'package:blinqo/features/role/service_provider/sp_profile/model/work_post_model.dart';
import 'package:blinqo/features/role/service_provider/sp_profile/screen/share_work_page.dart';
import 'package:get/get.dart';

class WorkPostController extends GetxController {
  var workPosts =
      <WorkPost>[
        WorkPost(
          eventType: 'Wedding Photography',
          projectTitle: 'Wedding Photography',
          description: 'Wedding Photography Description',
          photos: [],
          likes: 0,
          isLiked: false,
        ),
      ].obs;
  List<String> imageUrls =
      [
        'assets/images/wedding_photography_1.jpeg',
        'assets/images/wedding_photography_2.jpeg',
        'assets/images/wedding_photography_3.jpeg',
        'assets/images/wedding_photography_1.jpeg',
        'assets/images/wedding_photography_2.jpeg',
        'assets/images/wedding_photography_3.jpeg',
        'assets/images/wedding_photography_1.jpeg',
        'assets/images/wedding_photography_2.jpeg',
        'assets/images/wedding_photography_3.jpeg',
        'assets/images/wedding_photography_1.jpeg',
      ].obs;

  void addWorkPost(WorkPost post) {
    workPosts.add(post);
  }

  void toggleLike(int index) {
    var post = workPosts[index];
    if (post.isLiked) {
      post.likes--;
      post.isLiked = false;
    } else {
      post.likes++;
      post.isLiked = true;
    }
    workPosts[index] = post; // Update the post to trigger UI refresh
    workPosts.refresh();
  }

  void deletePost(int index) {
    workPosts.removeAt(index);
  }

  void editPost(int index) {
    var post = workPosts[index];
    // Navigate to ShareWork page with pre-filled data
    Get.to(
      () => SpShareWorkPage(
        isEditing: true,
        postIndex: index,
        eventType: post.eventType,
        projectTitle: post.projectTitle,
        description: post.description,
        photos: post.photos,
      ),
    );
  }

  void updatePost(int index, WorkPost updatedPost) {
    workPosts[index] = updatedPost;
    workPosts.refresh();
  }
}
