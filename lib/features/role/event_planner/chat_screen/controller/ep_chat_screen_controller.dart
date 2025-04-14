import 'package:get/get.dart';

class EpChatScreenController extends GetxController {
  var isEmojiVisible = false.obs;

  void toggleEmojiPicker() {
    isEmojiVisible.value = !isEmojiVisible.value;
  }
}
